import 'package:homeli/core/features/seeker%20role/models/featured_card_model.dart';
import 'package:hugeicons/hugeicons.dart';

final List<FeaturedCardModel> featureCard = [
  FeaturedCardModel(
    verificationStatus: 'Verified Architect',
    cardIcon: HugeIcon(icon: HugeIcons.strokeRoundedBookmark02),
    imagesPath: 'assets/images/onboard1.png',
    rating: '${4.9}',
    price: '${3850}/month',
    propertyName: 'The Glass Pavilion, Soho',
    propertyLocation: 'Broome & Mercer St, Soho, Manhattan',
    apartmentType: 'rent',
    features: ['3 beds', '2 baths', '1800 sq ft'],
  ),
];
