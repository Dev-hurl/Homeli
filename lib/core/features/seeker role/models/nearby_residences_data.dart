import 'package:homeli/core/features/seeker%20role/models/nearby_residences_model.dart';

final List<NearbyResidencesModel> nearbyProperty = [
  NearbyResidencesModel(
    imagePath: 'assets/images/naksha.jpg',
    rating: 4.9,
    propertyLocation: 'Cobble Hill, Brooklyn',
    propertyName: 'The Arched Brownstone',
    features: ['2 Beds', '1 Bath', 'Private Gardern'],
    price: '${2950}',
    isSaved: true,
    viewType: 'Tour View',
  ),
  NearbyResidencesModel(
    imagePath: 'assets/images/new-uk-homes.png',
    rating: 4.9,
    propertyLocation: 'Tribeca, New York',
    propertyName: 'Franklin Studio Loft',
    features: ['1 Beds', '1 Bath', 'Concierge 24/7'],
    price: '${4200}',
    viewType: 'Instant View',
  ),
];
