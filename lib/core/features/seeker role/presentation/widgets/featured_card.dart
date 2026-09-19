import 'package:flutter/material.dart';
import 'package:homeli/core/features/seeker%20role/models/featured_card_model.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedCardModel featuredCard;
  const FeaturedCard({super.key, required this.featuredCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _buildTopSection(
            context,
            imagePath: featuredCard.imagesPath,
            rating: featuredCard.rating,
            price: featuredCard.price,
            verificationStatus: featuredCard.verificationStatus,
          ),
          _buildBottomSection(
            context,
            cardIcon: featuredCard.cardIcon,
            propertyName: featuredCard.propertyName,
            propertyLocation: featuredCard.propertyLocation,
            apartmentType: featuredCard.apartmentType,
            features: featuredCard.features,
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(
    BuildContext context, {
    required String imagePath,
    required String rating,
    required String price,
    required String verificationStatus,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
  width: double.infinity,
  height: 200, // pick whatever fits your card design
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage(imagePath),
      fit: BoxFit.cover,
    ),
  ),
),
        Positioned(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(verificationStatus, style: textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(
    BuildContext context, {
    required dynamic cardIcon,
    required String propertyName,
    required String propertyLocation,
    required String apartmentType,
    required List<String> features,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: colorScheme.surface),
      child: Column(
        children: [
          Row(
            children: [
              Text(propertyName, style: textTheme.headlineSmall),
              Spacer(),
              Container(
                height: 18,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                ),
                child: Text(apartmentType, style: textTheme.labelSmall),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(propertyLocation, style: textTheme.labelMedium),
          SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: features
                .map(
                  (feature) => Container(
                    height: 18,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(feature, style: textTheme.labelSmall),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
