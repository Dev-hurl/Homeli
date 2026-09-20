enum TourStepStatus { completed, active, locked }

class TourStepModel {
  final String title;
  final String? trailingLabel;
  final String description;
  final TourStepStatus status;
  TourStepModel({
    required this.title,
    this.trailingLabel,
    required this.description,
    required this.status,
  });
}

final tourSteps = [
  TourStepModel(
    title: 'Request Submitted',
    trailingLabel: 'Oct 18 • 10:15 AM',
    description: 'Booking request sent with verified tenant profile',
    status: TourStepStatus.completed,
  ),
  TourStepModel(
    title: 'Host Approved',
    trailingLabel: 'Oct 18 • 2:40 PM',
    description: 'Sophia accepted the time slot & prepared itinerary',
    status: TourStepStatus.completed,
  ),
  TourStepModel(
    title: 'Tour Scheduled',
    trailingLabel: 'Active Step',
    description: 'Thursday, Oct 24 • 2:00 PM EST\n⏰ Reminder set for 1 hour prior (1:00 PM)',
    status: TourStepStatus.active,
  ),
  TourStepModel(
    title: 'Digital Key & Tour Pass',
    trailingLabel: 'Unlocks at 1:45 PM',
    description: 'NFC lobby gate reader & smart elevator clearance',
    status: TourStepStatus.locked,
  ),
];
