import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/seeker%20role/models/featured_card_model.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedCardModel featuredCard;
  const FeaturedCard({super.key, required this.featuredCard});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.push(AppRouter.seekerListingDetails);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondaryContainer.withValues(alpha: 0.05),
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
        ],
      ),
    );
  }

  Widget _buildTopSection(
    BuildContext context, {
    required String imagePath,
    required String rating,
    required double price,
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
            alignment: Alignment.center,
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
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, size: 18),
                color: colorScheme.secondary,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            alignment: Alignment.center,
            height: 28,
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
              child: Row(
                spacing: 4,
                children: [
                  Icon(Icons.star, color: colorScheme.primary, size: 18),
                  Text(
                    rating,
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '/month',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.surface,
                ),
              ),
            ],
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
            Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedLocation09,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                  strokeWidth: 2,
                ),
                SizedBox(width: 4),
                Text(propertyLocation, style: textTheme.labelMedium),
              ],
            ),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      feature,
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
