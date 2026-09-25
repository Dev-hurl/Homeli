import 'package:flutter/material.dart';
import 'package:homeli/core/features/seeker%20role/models/nearby_residences_model.dart';
import 'package:hugeicons/hugeicons.dart';

class NearbyResidencesCard extends StatelessWidget {
  final NearbyResidencesModel nearbyResidences;
  const NearbyResidencesCard({super.key, required this.nearbyResidences});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
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
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              SizedBox(
                width: 180,
                child: _buildLeftSection(
                  context,
                  imagePath: nearbyResidences.imagePath,
                  rating: nearbyResidences.rating,
                ),
              ),
              Expanded(
                child: _buildRightSection(
                  context,
                  price: nearbyResidences.price,
                  propertyName: nearbyResidences.propertyName,
                  propertyLocation: nearbyResidences.propertyLocation,
                  features: nearbyResidences.features,
                  viewType: nearbyResidences.viewType,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeftSection(
    BuildContext context, {
    required String imagePath,
    required double rating,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          width: double.infinity,
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
          left: 12,
          child: Container(
            alignment: Alignment.center,
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                spacing: 4,
                children: [
                  Icon(Icons.star, color: colorScheme.primary, size: 14),
                  Text(
                    rating.toString(),
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSection(
    BuildContext context, {
    required String propertyName,
    required String propertyLocation,
    required double price,
    required List<String> features,
    required String viewType,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedLocation09,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                  strokeWidth: 2,
                ),
                SizedBox(width: 4),
                Text(
                  propertyLocation,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.secondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    //
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              propertyName,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${price.toStringAsFixed(0)}',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.secondary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //
                  },
                  child: Text(
                    viewType,
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
