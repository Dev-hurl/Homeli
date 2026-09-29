class PastBookingModel {
  final String propertyName;
  final String location;
  final String stayInfo;
  final String status;
  final String date;
  final bool hasReview;

  PastBookingModel({
    required this.propertyName,
    required this.location,
    required this.stayInfo,
    required this.status,
    required this.date,
    required this.hasReview,
  });
}

final pastBookings = [
  PastBookingModel(
    propertyName: 'The Arched Brownstone',
    location: 'Cobble Hill, Brooklyn',
    stayInfo: '2 Nights Stay',
    status: 'Completed',
    date: 'Checked out Sep 28, 2024',
    hasReview: false,
  ),
  PastBookingModel(
    propertyName: 'Oceanview Penthouse',
    location: 'Miami Beach',
    stayInfo: 'Tour on Aug 14',
    status: 'Reviewed',
    date: '',
    hasReview: true,
  ),
];
