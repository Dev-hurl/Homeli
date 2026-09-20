import 'package:flutter/material.dart';
import 'package:homeli/core/features/seeker%20role/models/featured_card_model.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedCardModel featuredCard;
  const FeaturedCard({super.key, required this.featuredCard});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
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
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 23,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                verificationStatus,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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

    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  propertyName,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(apartmentType, style: textTheme.labelSmall),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(propertyLocation, style: textTheme.labelMedium),
            SizedBox(height: 24),
            Wrap(
              direction: Axis.vertical,
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
      ),
    );
  }
}
