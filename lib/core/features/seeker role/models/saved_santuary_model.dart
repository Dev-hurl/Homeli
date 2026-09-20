class SavedListingModel {
  final String imagePath;
  final String badgeLabel;
  final String price;
  final String propertyName;
  final String location;
  final List<String> features;

  const SavedListingModel({
    required this.imagePath,
    required this.badgeLabel,
    required this.price,
    required this.propertyName,
    required this.location,
    required this.features,
  });
}

final List<SavedListingModel> savedListings = [
  SavedListingModel(
    imagePath: 'assets/images/onboard1.png',
    badgeLabel: 'Verified Architectural',
    price: '\$3,850/mo',
    propertyName: 'Architectural Glass Villa',
    location: 'Greene Street, Soho • Manhattan',
    features: const ['3 Beds', '2 Baths', '1,840 sqft'],
  ),
  SavedListingModel(
    imagePath: 'assets/images/onboard1.png',
    badgeLabel: 'Tour Available Today',
    price: '\$2,950/mo',
    propertyName: 'The Arched Brownstone',
    location: 'Clinton Street, Cobble Hill • Brooklyn',
    features: const ['2 Beds', '1 Bath', 'Private Garden'],
  ),
  SavedListingModel(
    imagePath: 'assets/images/onboard1.png',
    badgeLabel: 'Concierge 24/7',
    price: '\$4,200/mo',
    propertyName: 'Franklin Studio Loft',
    location: 'Franklin Street, Tribeca • Manhattan',
    features: const ['1 Bed', '1 Bath', 'High Ceiling (13ft)'],
  ),
];