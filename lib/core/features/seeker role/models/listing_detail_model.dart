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
}

class AmenityItem {
  final dynamic icon;
  final String label;
  AmenityItem({required this.icon, required this.label});
}