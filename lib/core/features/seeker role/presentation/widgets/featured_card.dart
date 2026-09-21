import 'package:flutter/material.dart';
import 'package:homeli/core/features/seeker%20role/models/featured_card_model.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedCardModel featuredCard;
  const FeaturedCard({super.key, required this.featuredCard});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Selection',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.secondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(24),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondary.withValues(alpha: 0.07),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
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
        ),
      ],
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
          //width: double.infinity,
          height: 200,
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
                    color: colorScheme.secondaryContainer,
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
            SizedBox(height: 4),
            Text(propertyLocation, style: textTheme.labelMedium),
            SizedBox(height: 18),
            SizedBox(
              height: 28,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: features.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(feature, style: textTheme.labelSmall),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
