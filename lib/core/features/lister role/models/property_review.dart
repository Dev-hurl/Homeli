import 'package:hugeicons/hugeicons.dart';

class RatingBreakdownModel {
  final int stars;
  final double percentage;
  RatingBreakdownModel({required this.stars, required this.percentage});
}

class CategoryScoreModel {
  final dynamic icon;
  final String label;
  final double score;
  CategoryScoreModel({
    required this.icon,
    required this.label,
    required this.score,
  });
}

class ReviewPhoto {
  final String imagePath;
  final String label;
  ReviewPhoto({required this.imagePath, required this.label});
}

class ReviewModel {
  final String avatarPath;
  final String name;
  final String stayInfo;
  final double rating;
  final String reviewText;
  final List<ReviewPhoto> photos;
  final int helpfulCount;
  final String tag;
  ReviewModel({
    required this.avatarPath,
    required this.name,
    required this.stayInfo,
    required this.rating,
    required this.reviewText,
    required this.photos,
    required this.helpfulCount,
    required this.tag,
  });
}

final ratingBreakdown = [
  RatingBreakdownModel(stars: 5, percentage: 92),
  RatingBreakdownModel(stars: 4, percentage: 6),
  RatingBreakdownModel(stars: 3, percentage: 2),
  RatingBreakdownModel(stars: 2, percentage: 0),
  RatingBreakdownModel(stars: 1, percentage: 0),
];

final categoryScores = [
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedRuler,
    label: 'Cleanliness & Design',
    score: 5.0,
  ),
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedCamera01,
    label: 'Accuracy to Photos',
    score: 4.9,
  ),
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedMessage01,
    label: 'Host Communication',
    score: 5.0,
  ),
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedLocation09,
    label: 'Location & Transit',
    score: 4.9,
  ),
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedKey01,
    label: 'Check-in Experience',
    score: 5.0,
  ),
  CategoryScoreModel(
    icon: HugeIcons.strokeRoundedHome01,
    label: 'Value for Space',
    score: 4.8,
  ),
];

final propertyReviews = [
  ReviewModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Elena Vance',
    stayInfo: 'Stayed Oct 2024 • 4 nights',
    rating: 5.0,
    reviewText: 'An exquisite sanctuary with impeccable natural lighting and acoustics. Sophia was an incredible host, providing curated neighborhood recommendations.',
    photos: [
      ReviewPhoto(
        imagePath: 'assets/images/onboard1.png',
        label: 'Living Hall',
      ),
      ReviewPhoto(
        imagePath: 'assets/images/onboard1.png',
        label: 'Reading Nook',
      ),
    ],
    helpfulCount: 12,
    tag: 'Verified Stay',
  ),
  ReviewModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Marcus Vance',
    stayInfo: 'Stayed Sep 2024 • 1 week',
    rating: 5.0,
    reviewText: 'The spatial harmony and minimalist aesthetic made remote work an absolute delight. Ultra-quiet loft with high-speed fiber connection and ergonomic seating.',
    photos: [],
    helpfulCount: 8,
    tag: 'Remote Work Trip',
  ),
  ReviewModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Chloe Laurent',
    stayInfo: 'Stayed Aug 2024 • Guided Tour',
    rating: 4.8,
    reviewText: 'Warm hospitality, seamless digital key entry, and stunning morning light. The neighborhood espresso bar recommendation was pure gold.',
    photos: [],
    helpfulCount: 5,
    tag: 'Verified Stay',
  ),
];
