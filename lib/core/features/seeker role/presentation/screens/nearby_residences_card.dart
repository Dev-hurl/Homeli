import 'package:flutter/material.dart';
import 'package:homeli/core/features/seeker%20role/models/nearby_residences_model.dart';
import 'package:hugeicons/hugeicons.dart';

class NearbyResidencesCard extends StatelessWidget {
  final NearbyResidencesModel nearbyResidences;
  const NearbyResidencesCard({super.key, required this.nearbyResidences});

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
              'Nearby Residences',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.secondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Curated spots within 2 miles of you',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.secondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: UnconstrainedBox(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedPreferenceHorizontal,
                  color: colorScheme.secondaryContainer,
                  strokeWidth: 1.5,
                  size: 20,
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
                _buildLeftSection(
                  context,
                  imagePath: nearbyResidences.imagePath,
                  rating: nearbyResidences.rating,
                ),
                _buildRightSection(
                  context,
                  price: nearbyResidences.price,
                  propertyName: nearbyResidences.propertyName,
                  propertyLocation: nearbyResidences.propertyLocation,
                  features: nearbyResidences.features,
                ),
              ],
            ),
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
          left: 12,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                rating.toString(),
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

  Widget _buildRightSection(
    BuildContext context, {
    required String propertyName,
    required String propertyLocation,
    bool isSaved = false,
    required String price,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  propertyLocation,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.secondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                  ),
                  child: Icon(
                    isSaved ? Icons.favorite_outline : Icons.favorite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(propertyName, style: textTheme.labelMedium),
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
                      borderRadius: BorderRadius.circular(16),
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
