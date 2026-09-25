-- ============================================================
-- EXTENSIONS
-- ============================================================
create extension if not exists "pgcrypto"; -- for gen_random_uuid()

-- ============================================================
-- ENUMS
-- ============================================================
create type user_role as enum ('seeker', 'lister');
create type property_type as enum ('house', 'apartment', 'villa', 'land');
create type listing_type as enum ('rent', 'sale');
create type listing_status as enum ('draft', 'active', 'paused', 'archived');
create type verification_status as enum ('pending', 'action_required', 'scheduled', 'verified', 'connected');
create type verification_document_type as enum ('government_id', 'ownership_proof', 'inspection', 'payout_account');

-- ============================================================
-- IDENTITY & PROFILES (auth.users is Supabase-managed)
-- ============================================================

-- One row per user: fields shared across both roles by default
create table identities (
  user_id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  phone text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Up to 2 rows per user (one per role). display_name/avatar_url are
-- nullable overrides — null means "fall back to identities.full_name/avatar_url"
create table profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  role user_role not null,
  display_name text,
  avatar_url text,
  occupation text,
  primary_interest text,
  bio text,
  is_verified boolean not null default false,
  rating numeric(2,1),
  review_count integer not null default 0,
  response_rate numeric(4,1),
  response_time_label text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, role)
);

create index idx_profiles_user_id on profiles(user_id);

-- Tracks which of the user's (up to 2) profiles is currently active
create table user_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  active_profile_id uuid references profiles(id) on delete set null,
  updated_at timestamptz not null default now()
);

-- ============================================================
-- LISTINGS
-- ============================================================

create table listings (
  id uuid primary key default gen_random_uuid(),
  lister_profile_id uuid not null references profiles(id) on delete cascade,
  title text not null,
  description text,
  property_type property_type not null,
  listing_type listing_type not null default 'rent',
  price numeric(10,2) not null,
  price_period text default 'month', -- 'month', 'year', null for sale listings
  address text not null,
  city text,
  region text,
  country text,
  latitude double precision,
  longitude double precision,
  bedrooms integer,
  bathrooms integer,
  area_sqft integer,
  status listing_status not null default 'draft',
  is_visible boolean not null default true,
  is_verified boolean not null default false,
  transit_score integer,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index idx_listings_lister on listings(lister_profile_id);
create index idx_listings_status on listings(status);
create index idx_listings_property_type on listings(property_type);

create table listing_images (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references listings(id) on delete cascade,
  image_path text not null, -- Supabase Storage path, not a raw file
  position integer not null default 0,
  is_primary boolean not null default false
);

create index idx_listing_images_listing on listing_images(listing_id);

create table amenities (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  icon_key text -- e.g. 'strokeRoundedWifi01', matches your HugeIcons naming
);

create table listing_amenities (
  listing_id uuid not null references listings(id) on delete cascade,
  amenity_id uuid not null references amenities(id) on delete cascade,
  primary key (listing_id, amenity_id)
);

create table favorites (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id) on delete cascade,
  listing_id uuid not null references listings(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (profile_id, listing_id)
);

-- ============================================================
-- REVIEWS
-- ============================================================

create table reviews (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references listings(id) on delete cascade,
  reviewer_profile_id uuid not null references profiles(id) on delete cascade,
  overall_rating numeric(2,1) not null check (overall_rating between 1 and 5),
  review_text text,
  created_at timestamptz not null default now()
);

create index idx_reviews_listing on reviews(listing_id);

create table review_category_scores (
  id uuid primary key default gen_random_uuid(),
  review_id uuid not null references reviews(id) on delete cascade,
  category_key text not null, -- e.g. 'cleanliness', 'communication', 'location'
  score numeric(2,1) not null check (score between 1 and 5)
);

create table review_tags (
  id uuid primary key default gen_random_uuid(),
  name text not null unique -- e.g. 'True to photos', 'Peaceful sanctuary'
);

create table review_tag_selections (
  review_id uuid not null references reviews(id) on delete cascade,
  tag_id uuid not null references review_tags(id) on delete cascade,
  primary key (review_id, tag_id)
);

create table review_photos (
  id uuid primary key default gen_random_uuid(),
  review_id uuid not null references reviews(id) on delete cascade,
  image_path text not null,
  label text
);

-- ============================================================
-- LISTER VERIFICATION
-- ============================================================

create table verification_documents (
  id uuid primary key default gen_random_uuid(),
  lister_profile_id uuid not null references profiles(id) on delete cascade,
  document_type verification_document_type not null,
  status verification_status not null default 'pending',
  file_path text, -- Supabase Storage path, null until uploaded
  notes text,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  unique (lister_profile_id, document_type)
);

-- Payout accounts: only ever store a processor token + last 4 digits for display.
-- Never store a raw bank/card account number.
create table payout_accounts (
  id uuid primary key default gen_random_uuid(),
  lister_profile_id uuid not null references profiles(id) on delete cascade,
  provider text not null, -- e.g. 'stripe_connect'
  external_account_id text not null, -- token/id from the payment processor
  bank_name text,
  last4 text,
  status verification_status not null default 'pending',
  created_at timestamptz not null default now()
);

-- ============================================================
-- MESSAGING (general, not tied to a listing)
-- ============================================================

create table conversations (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  last_message_at timestamptz
);

create table conversation_participants (
  conversation_id uuid not null references conversations(id) on delete cascade,
  profile_id uuid not null references profiles(id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (conversation_id, profile_id)
);

create table messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references conversations(id) on delete cascade,
  sender_profile_id uuid not null references profiles(id) on delete cascade,
  content text not null,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create index idx_messages_conversation on messages(conversation_id);
create index idx_conversation_participants_profile on conversation_participants(profile_id);