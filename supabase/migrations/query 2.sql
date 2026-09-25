-- ============================================================
-- ENABLE RLS ON ALL TABLES
-- ============================================================
alter table identities enable row level security;
alter table profiles enable row level security;
alter table user_state enable row level security;
alter table listings enable row level security;
alter table listing_images enable row level security;
alter table amenities enable row level security;
alter table listing_amenities enable row level security;
alter table favorites enable row level security;
alter table reviews enable row level security;
alter table review_category_scores enable row level security;
alter table review_tags enable row level security;
alter table review_tag_selections enable row level security;
alter table review_photos enable row level security;
alter table verification_documents enable row level security;
alter table payout_accounts enable row level security;
alter table conversations enable row level security;
alter table conversation_participants enable row level security;
alter table messages enable row level security;

-- ============================================================
-- IDENTITIES
-- ============================================================
create policy "Users can view their own identity" on identities for select using (auth.uid() = user_id);
create policy "Users can insert their own identity" on identities for insert with check (auth.uid() = user_id);
create policy "Users can update their own identity" on identities for update using (auth.uid() = user_id);

-- ============================================================
-- PROFILES
-- Publicly readable (seekers need to see lister profiles and vice versa)
-- but only the owner can create/modify their own
-- ============================================================
create policy "Profiles are viewable by everyone" on profiles for select using (true);
create policy "Users can insert their own profiles" on profiles for insert with check (auth.uid() = user_id);
create policy "Users can update their own profiles" on profiles for update using (auth.uid() = user_id);
create policy "Users can delete their own profiles" on profiles for delete using (auth.uid() = user_id);

-- ============================================================
-- USER_STATE
-- ============================================================
create policy "Users can view their own state" on user_state for select using (auth.uid() = user_id);
create policy "Users can insert their own state" on user_state for insert with check (auth.uid() = user_id);
create policy "Users can update their own state" on user_state for update using (auth.uid() = user_id);

-- ============================================================
-- LISTINGS
-- Active listings are public; listers manage only their own
-- ============================================================
create policy "Active listings are viewable by everyone" on listings for select
  using (status = 'active' or lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can insert their own listings" on listings for insert
  with check (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can update their own listings" on listings for update
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can delete their own listings" on listings for delete
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));

-- ============================================================
-- LISTING_IMAGES
-- ============================================================
create policy "Listing images are viewable by everyone" on listing_images for select using (true);
create policy "Listers can manage images on their own listings" on listing_images for insert
  with check (listing_id in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Listers can update images on their own listings" on listing_images for update
  using (listing_id in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Listers can delete images on their own listings" on listing_images for delete
  using (listing_id in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid())));

-- ============================================================
-- AMENITIES (read-only reference data)
-- ============================================================
create policy "Amenities are viewable by everyone" on amenities for select using (true);

-- ============================================================
-- LISTING_AMENITIES
-- ============================================================
create policy "Listing amenities are viewable by everyone" on listing_amenities for select using (true);
create policy "Listers can manage amenities on their own listings" on listing_amenities for insert
  with check (listing_id in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Listers can remove amenities on their own listings" on listing_amenities for delete
  using (listing_id in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid())));

-- ============================================================
-- FAVORITES
-- ============================================================
create policy "Users can view their own favorites" on favorites for select
  using (profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Users can add their own favorites" on favorites for insert
  with check (profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Users can remove their own favorites" on favorites for delete
  using (profile_id in (select id from profiles where user_id = auth.uid()));

-- ============================================================
-- REVIEWS
-- ============================================================
create policy "Reviews are viewable by everyone" on reviews for select using (true);
create policy "Users can insert their own reviews" on reviews for insert
  with check (reviewer_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Users can update their own reviews" on reviews for update
  using (reviewer_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Users can delete their own reviews" on reviews for delete
  using (reviewer_profile_id in (select id from profiles where user_id = auth.uid()));

-- ============================================================
-- REVIEW_CATEGORY_SCORES / REVIEW_TAG_SELECTIONS / REVIEW_PHOTOS
-- Keyed off review ownership
-- ============================================================
create policy "Review category scores are viewable by everyone" on review_category_scores for select using (true);
create policy "Users can insert scores on their own reviews" on review_category_scores for insert
  with check (review_id in (select id from reviews where reviewer_profile_id in (select id from profiles where user_id = auth.uid())));

create policy "Review tag selections are viewable by everyone" on review_tag_selections for select using (true);
create policy "Users can insert tags on their own reviews" on review_tag_selections for insert
  with check (review_id in (select id from reviews where reviewer_profile_id in (select id from profiles where user_id = auth.uid())));

create policy "Review photos are viewable by everyone" on review_photos for select using (true);
create policy "Users can insert photos on their own reviews" on review_photos for insert
  with check (review_id in (select id from reviews where reviewer_profile_id in (select id from profiles where user_id = auth.uid())));

-- ============================================================
-- REVIEW_TAGS (read-only reference data)
-- ============================================================
create policy "Review tags are viewable by everyone" on review_tags for select using (true);

-- ============================================================
-- VERIFICATION_DOCUMENTS — private, owner-only
-- ============================================================
create policy "Listers can view their own verification documents" on verification_documents for select
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can insert their own verification documents" on verification_documents for insert
  with check (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can update their own verification documents" on verification_documents for update
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));

-- ============================================================
-- PAYOUT_ACCOUNTS — private, owner-only
-- ============================================================
create policy "Listers can view their own payout accounts" on payout_accounts for select
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can insert their own payout accounts" on payout_accounts for insert
  with check (lister_profile_id in (select id from profiles where user_id = auth.uid()));
create policy "Listers can update their own payout accounts" on payout_accounts for update
  using (lister_profile_id in (select id from profiles where user_id = auth.uid()));

-- ============================================================
-- CONVERSATIONS / CONVERSATION_PARTICIPANTS / MESSAGES
-- Only participants can see or send within a conversation
-- ============================================================
create policy "Participants can view their conversations" on conversations for select
  using (id in (select conversation_id from conversation_participants where profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Authenticated users can create conversations" on conversations for insert
  with check (auth.uid() is not null);

create policy "Participants can view conversation membership" on conversation_participants for select
  using (conversation_id in (select conversation_id from conversation_participants where profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Users can add themselves as a participant" on conversation_participants for insert
  with check (profile_id in (select id from profiles where user_id = auth.uid()));

create policy "Participants can view messages in their conversations" on messages for select
  using (conversation_id in (select conversation_id from conversation_participants where profile_id in (select id from profiles where user_id = auth.uid())));
create policy "Participants can send messages in their conversations" on messages for insert
  with check (
    sender_profile_id in (select id from profiles where user_id = auth.uid())
    and conversation_id in (select conversation_id from conversation_participants where profile_id in (select id from profiles where user_id = auth.uid()))
  );
create policy "Participants can update messages in their conversations" on messages for update
  using (conversation_id in (select conversation_id from conversation_participants where profile_id in (select id from profiles where user_id = auth.uid())));

-- ============================================================
-- STORAGE POLICIES
-- ============================================================

-- avatars: public read, owner-only write (path: {user_id}/avatar.jpg)
create policy "Avatar images are publicly accessible" on storage.objects for select using (bucket_id = 'avatars');
create policy "Users can upload their own avatar" on storage.objects for insert
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "Users can update their own avatar" on storage.objects for update
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "Users can delete their own avatar" on storage.objects for delete
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

-- listing-images: public read, write restricted to the owning lister (path: {listing_id}/{uuid}.jpg)
create policy "Listing images are publicly accessible" on storage.objects for select using (bucket_id = 'listing-images');
create policy "Listers can upload images to their own listings" on storage.objects for insert
  with check (
    bucket_id = 'listing-images'
    and (storage.foldername(name))[1]::uuid in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid()))
  );
create policy "Listers can delete images from their own listings" on storage.objects for delete
  using (
    bucket_id = 'listing-images'
    and (storage.foldername(name))[1]::uuid in (select id from listings where lister_profile_id in (select id from profiles where user_id = auth.uid()))
  );

-- review-photos: public read, write restricted to the reviewer (path: {review_id}/{uuid}.jpg)
create policy "Review photos are publicly accessible" on storage.objects for select using (bucket_id = 'review-photos');
create policy "Reviewers can upload photos to their own reviews" on storage.objects for insert
  with check (
    bucket_id = 'review-photos'
    and (storage.foldername(name))[1]::uuid in (select id from reviews where reviewer_profile_id in (select id from profiles where user_id = auth.uid()))
  );

-- verification-documents: private, owner-only (path: {lister_profile_id}/{document_type}.pdf)
create policy "Listers can view their own verification documents" on storage.objects for select
  using (bucket_id = 'verification-documents' and (storage.foldername(name))[1] in (select id::text from profiles where user_id = auth.uid()));
create policy "Listers can upload their own verification documents" on storage.objects for insert
  with check (bucket_id = 'verification-documents' and (storage.foldername(name))[1] in (select id::text from profiles where user_id = auth.uid()));
create policy "Listers can update their own verification documents" on storage.objects for update
  using (bucket_id = 'verification-documents' and (storage.foldername(name))[1] in (select id::text from profiles where user_id = auth.uid()));