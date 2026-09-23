class ActiveListingModel {
  final String imagePath;
  final String? badge;
  final String location;
  final String title;
  final String price;
  final List<String> stats;
  final String visibilityLabel;
  final String visibilitySubtitle;
  final bool visibilityOn;
  final List<String> actionButtons;
  final String? highlightedAction;

  ActiveListingModel({
    required this.imagePath,
    required this.badge,
    required this.location,
    required this.title,
    required this.price,
    required this.stats,
    required this.visibilityLabel,
    required this.visibilitySubtitle,
    required this.visibilityOn,
    required this.actionButtons,
    required this.highlightedAction,
  });
}

final activeListing = [
  ActiveListingModel(
    imagePath: 'assets/images/elite-prop.jpg',
    badge: 'Premier Host',
    location: 'Soho, New York',
    title: 'The Glass Pavilion',
    price: '\$3,850',
    stats: ['18 views', '4 requests', '1 today'],
    visibilityLabel: 'Listing Visibility',
    visibilitySubtitle: 'Publicly bookable on search',
    visibilityOn: true,
    actionButtons: ['Edit', 'Calendar', 'Promote'],
    highlightedAction: 'Promote',
  ),

  ActiveListingModel(
    imagePath: 'assets/images/naksha.jpg',
    badge: null,
    location: 'Tribeca, New York',
    title: 'Franklin Studio Loft',
    price: '\$4,200',
    stats: ['12 Views today', '2 Booking Inquiries'],
    visibilityLabel: 'Listing Active',
    visibilitySubtitle: 'Accepting instant requests',
    visibilityOn: true,
    actionButtons: ['Manage', 'Calendar'],
    highlightedAction: null,
  ),
];
