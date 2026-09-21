class FeaturedCardModel {
  final String verificationStatus;
  final String rating;
  final double price;
  final String imagesPath;
  final dynamic cardIcon;
  final String propertyName;
  final String propertyLocation;
  final String apartmentType;
  final List<String> features;
 
  FeaturedCardModel({
    required this.verificationStatus,
    required this.cardIcon,
    required this.imagesPath,
    required this.rating,
    required this.price,
    required this.propertyName,
    required this.propertyLocation,
    required this.apartmentType,
    required this.features
  });
}
