import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/seeker%20role/models/saved_santuary_model.dart';
import 'package:homeli/core/features/seeker%20role/presentation/widgets/saved_listing_card.dart';
import 'package:hugeicons/hugeicons.dart';

class SavedSanctuariesScreen extends StatefulWidget {
  const SavedSanctuariesScreen({super.key});

  @override
  State<SavedSanctuariesScreen> createState() => _SavedSanctuariesScreenState();
}

class _SavedSanctuariesScreenState extends State<SavedSanctuariesScreen> {
  int _selectedTab = 0;
  final _tabs = ['All Saved', 'Manhattan Stays', 'Brooklyn Retreats'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            color: colorScheme.secondary,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Sanctuaries',
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.secondaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${savedListings.length} properties saved across 2 collections',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedPreferenceHorizontal,
                    size: 18,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification01,
                    size: 18,
                    color: colorScheme.secondary,
                    strokeWidth: 2,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price drop radar active',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.secondaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Alerts enabled for instant updates',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 16),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                separatorBuilder: (_, _) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final selected = index == _selectedTab;
                  final label = index == 0
                      ? '${_tabs[index]} (${savedListings.length})'
                      : _tabs[index];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? colorScheme.secondaryContainer
                            : colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        label,
                        style: textTheme.labelMedium?.copyWith(
                          color: selected
                              ? colorScheme.surface
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
            ...savedListings.map(
              (listing) => Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: SavedListingCard(listing: listing),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedShare08,
                    size: 24,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Share your sanctuaries',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Invite a partner or friend to collaborate on your favorite stays and compare locations in real time.',
                    textAlign: TextAlign.center,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text('Create Shared Board'),
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
