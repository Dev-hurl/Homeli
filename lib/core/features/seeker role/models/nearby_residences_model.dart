class NearbyResidencesModel {
  final String imagePath;
  final double rating;
  final String propertyName;
  final String propertyLocation;
  final bool isSaved;
  final List<String> features;
  final double price;
  final String viewType;

  NearbyResidencesModel({
    required this.imagePath,
    required this.rating,
    required this.propertyLocation,
    required this.propertyName,
    this.isSaved = false,
    required this.features,
    required this.price,
    required this.viewType,
  });
}
