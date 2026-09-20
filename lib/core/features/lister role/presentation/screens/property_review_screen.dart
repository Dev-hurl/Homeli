import 'package:flutter/material.dart';
import 'package:homeli/core/features/lister%20role/models/property_review.dart';
import 'package:hugeicons/hugeicons.dart';

class PropertyReviewsScreen extends StatefulWidget {
  const PropertyReviewsScreen({super.key});

  @override
  State<PropertyReviewsScreen> createState() => _PropertyReviewsScreenState();
}

class _PropertyReviewsScreenState extends State<PropertyReviewsScreen> {
  int _selectedFilter = 0;
  final _filters = ['All (48)', 'With Photos (14)', 'Solo Travelers (18)'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Property Details',
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/avatar1.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'VERIFIED RESIDENT FEEDBACK',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.ios_share,
                            size: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Share',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🌟', style: TextStyle(fontSize: 12)),
                              SizedBox(width: 4),
                              Text(
                                'Exceptional Host',
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '4.96',
                              style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 6),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                '/ 5.0',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Based on 48 verified guest stays',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              Icons.star,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Top 1% in Brooklyn',
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: ratingBreakdown.map((row) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Text(
                                        '${row.stars} ★',
                                        style: textTheme.labelSmall,
                                      ),
                                    ),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: LinearProgressIndicator(
                                          value: row.percentage / 100,
                                          minHeight: 6,
                                          backgroundColor:
                                              colorScheme.surfaceContainerHigh,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 36,
                                      child: Text(
                                        '${row.percentage.round()}%',
                                        textAlign: TextAlign.end,
                                        style: textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category Breakdown',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Audited & Verified',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryScores.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.7,
                    ),
                    itemBuilder: (context, index) {
                      final category = categoryScores[index];
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HugeIcon(
                                  icon: category.icon,
                                  size: 18,
                                  color: colorScheme.secondary,
                                ),
                                Text(
                                  category.score.toStringAsFixed(1),
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              category.label,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Filter By Perspective',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, _) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final selected = index == _selectedFilter;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = index),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? colorScheme.secondary
                                  : colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              _filters[index],
                              style: textTheme.labelMedium?.copyWith(
                                color: selected
                                    ? colorScheme.onSecondary
                                    : colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ...propertyReviews.map(
                    (review) => Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: _ReviewCard(review: review),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR EXPERIENCE',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'Stayed recently?',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_note, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Write a Review',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(review.avatarPath),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    review.stayInfo,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 12, color: colorScheme.primary),
                  SizedBox(width: 4),
                  Text(
                    review.rating.toStringAsFixed(1),
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          review.reviewText,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        if (review.photos.isNotEmpty) ...[
          SizedBox(height: 10),
          Row(
            children: review.photos
                .map(
                  (photo) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Image.asset(
                              photo.imagePath,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 6,
                              left: 6,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  photo.label,
                                  style: textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.thumb_up_outlined,
              size: 14,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 4),
            Text(
              'Helpful (${review.helpfulCount})',
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Spacer(),
            Text(
              review.tag,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(color: colorScheme.outlineVariant),
      ],
    );
  }
}
