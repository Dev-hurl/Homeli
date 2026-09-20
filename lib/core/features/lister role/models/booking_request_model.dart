class BookingRequestModel {
  final String? urgencyLabel;
  final String requestedAgo;
  final String guestAvatar;
  final String guestName;
  final bool isVerified;
  final String? verifiedLabel;
  final double? guestRating;
  final String? guestMetaText;
  final String listingImage;
  final String listingName;
  final String listingPrice;
  final String? visitType;
  final String? scheduledTime;
  final String? duration;
  final String? guestNote;
  final String? subtitle;

  BookingRequestModel({
    this.urgencyLabel,
    required this.requestedAgo,
    required this.guestAvatar,
    required this.guestName,
    required this.isVerified,
    this.verifiedLabel,
    this.guestRating,
    this.guestMetaText,
    required this.listingImage,
    required this.listingName,
    required this.listingPrice,
    this.visitType,
    this.scheduledTime,
    this.duration,
    this.guestNote,
    this.subtitle,
  });
}

final bookingRequests = [
  BookingRequestModel(
    urgencyLabel: 'Expires in 4hrs',
    requestedAgo: 'Requested 20h ago',
    guestAvatar: 'assets/images/avatar1.png',
    guestName: 'Liam Gallagher',
    isVerified: true,
    verifiedLabel: 'Verified',
    guestRating: 4.9,
    guestMetaText: '12 verified stays',
    listingImage: 'assets/images/onboard1.png',
    listingName: 'The Glass Pavilion, Soho',
    listingPrice: '\$3,850/mo',
    visitType: 'Private Guided Tour',
    scheduledTime: 'Thu, Oct 24 • 3:30 PM',
    guestNote: 'Hello Sophia, I\'m an architect relocating from London. Looking for a quiet space for 6+ months. Excited to see the high ceilings.',
  ),
  BookingRequestModel(
    urgencyLabel: '3-Month Extended Lease',
    requestedAgo: 'Requested 2h ago',
    guestAvatar: 'assets/images/avatar1.png',
    guestName: 'Camilla Rossi',
    isVerified: true,
    verifiedLabel: 'Verified',
    guestRating: 5.0,
    guestMetaText: '8 stays • 780+',
    listingImage: 'assets/images/onboard1.png',
    listingName: 'Franklin Studio Loft',
    listingPrice: '\$4,200/mo',
    duration: 'Nov 1, 2024 – Jan 31, 2025 • 92 nights',
    guestNote: 'Quiet writer seeking a light-filled space for winter. All references ready.',
  ),
  BookingRequestModel(
    urgencyLabel: 'On-Site Tour',
    requestedAgo: 'Requested 6h ago',
    guestAvatar: 'assets/images/avatar1.png',
    guestName: 'David Zhao',
    isVerified: true,
    verifiedLabel: 'Verified ID',
    subtitle: 'First-time Seeker • New York, NY',
    listingImage: 'assets/images/onboard1.png',
    listingName: 'Chelsea Townhouse',
    scheduledTime: 'Sat, Oct 26 • 11:00 AM',
    listingPrice: '',
  ),
];
