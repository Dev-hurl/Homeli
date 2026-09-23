import 'package:hugeicons/hugeicons.dart';

class ListingDetailModel {
  final List<String> imagePaths;
  final String statusLabel;
  final double rating;
  final int reviewCount;
  final String title;
  final String address;
  final String price;
  final String moveInStatus;
  final List<String> quickFeatures;
  final String hostName;
  final String hostImagePath;
  final String hostResponseTime;
  final String description;
  final List<AmenityItem> amenities;
  final int totalAmenitiesCount;
  final String transitScore;
  final String neighborhoodName;
  final String neighborhoodDescription;

  ListingDetailModel({
    required this.imagePaths,
    required this.statusLabel,
    required this.rating,
    required this.reviewCount,
    required this.title,
    required this.address,
    required this.price,
    required this.moveInStatus,
    required this.quickFeatures,
    required this.hostName,
    required this.hostImagePath,
    required this.hostResponseTime,
    required this.description,
    required this.amenities,
    required this.totalAmenitiesCount,
    required this.transitScore,
    required this.neighborhoodName,
    required this.neighborhoodDescription,
  });

  final listingDetailData = ListingDetailModel(
  imagePaths: List.filled(5, 'assets/images/elite-prop.jpg'),
  statusLabel: 'For Rent',
  rating: 4.96,
  reviewCount: 48,
  title: 'The Glass Pavilion, Soho',
  address: '32 W Mercer St, Soho, Manhattan, NY',
  price: '\$3,850',
  moveInStatus: 'Immediate Move-in',
  quickFeatures: ['3 Beds', '2 Baths', '1,800 sq ft'],
  hostName: 'Larry Cho',
  hostImagePath: 'assets/images/avatar.png',
  hostResponseTime: 'Responds in < 15 mins',
  description: 'Experience refined urban elegance in this thoughtfully customized modern sanctuary. Soaring ceilings and floor-to-ceiling acoustic glass frame the city skyline, while the private courtyard pool offers a rare moment of stillness in Soho.',
  amenities: [
    AmenityItem(
      icon: HugeIcons.strokeRoundedRuler,
      label: 'Architectural Design',
    ),
    AmenityItem(
      icon: HugeIcons.strokeRoundedSquareLock02,
      label: 'Private Courtyard',
    ),
    AmenityItem(icon: HugeIcons.strokeRoundedCall02, label: 'Concierge 24/7'),
    AmenityItem(icon: HugeIcons.strokeRoundedWifi01, label: 'High-speed Fiber'),
    AmenityItem(
      icon: HugeIcons.strokeRoundedKey01,
      label: 'Smart Keyless Entry',
    ),
    AmenityItem(
      icon: HugeIcons.strokeRoundedCar01,
      label: 'Dedicated EV Charging',
    ),
  ],
  totalAmenitiesCount: 24,
  transitScore: '99/100',
  neighborhoodName: 'SoHo Cast-Iron District',
  neighborhoodDescription: 'Quiet cobblestone corridor near Mercer & Prince',
);
}

class AmenityItem {
  final dynamic icon;
  final String label;
  AmenityItem({required this.icon, required this.label});
}