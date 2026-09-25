import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/lister%20role/models/active_listing_model.dart';
import 'package:homeli/core/features/lister%20role/models/draft_listing_model.dart';
import 'package:homeli/core/features/lister%20role/presentation/widgets/active_listing_card.dart';
import 'package:homeli/core/features/lister%20role/presentation/widgets/draft_listing_card.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';

class ListerDashboardScreen extends StatefulWidget {
  const ListerDashboardScreen({super.key});

  @override
  State<ListerDashboardScreen> createState() => _ListerDashboardScreenState();
}

class _ListerDashboardScreenState extends State<ListerDashboardScreen> {
  int _selectedTab = 0;
  final String _imagePath = 'assets/images/avatar.png';
  final _tabs = ['All (3)', 'Active (2)', 'Draft / Review (1)', 'Paused (0)'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leading: Image.asset('assets/icons/Homeli Logo T Inverted.png'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.notifications),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedNotification01,
              size: 22,
              strokeWidth: 2,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              context.go(AppRouter.listerProfile);
            },
            child: ClipOval(
              child: _imagePath.isNotEmpty
                  ? Image.asset(_imagePath, fit: BoxFit.cover)
                  : CircleAvatar(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser02,
                        size: 22,
                        strokeWidth: 2,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(
              'My Listings',
              style: textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.secondary,
              ),
            ),
            Text(
              'Manage 3 residences and your incoming guest inquiries.',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Est. Revenue',
                    value: '\$11,900',
                    trailingChip: '+14%',
                    trailing: _RevenueSparkline(),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Occupancy',
                    value: '94%',
                    subtitle: 'Target: 90%',
                    trailing: SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        value: 0.94,
                        strokeWidth: 3,
                        color: colorScheme.primary,
                        backgroundColor: colorScheme.surfaceContainerHigh,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Inquiries',
                    value: '5 Pending',
                    subtitle: '2 need reply today',
                    trailing: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Rating',
                    value: '4.98',
                    subtitle: '124 verified reviews',
                    trailing: Icon(
                      Icons.star,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                separatorBuilder: (_, _) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final selected = index == _selectedTab;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
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
                        _tabs[index],
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
            ...activeListing.map(
              (active) => Padding(
                padding: EdgeInsetsGeometry.only(bottom: 12),
                child: ActiveListingCard(activeListing: active),
              ),
            ),
            SizedBox(height: 16),
            ...draftListing.map(
              (draft) => Padding(
                padding: EdgeInsetsGeometry.only(bottom: 12),
                child: DraftListingCard(draftListing: draft),
              ),
            ),
            SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                context.push(AppRouter.listerCreateListing);
              },
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Add New Listing',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.w700,
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;
  final String? trailingChip;
  final Widget trailing;

  const _StatCard({
    required this.label,
    required this.value,
    this.subtitle,
    this.trailingChip,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (trailingChip != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trailingChip!,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                trailing,
            ],
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          if (trailingChip != null) SizedBox(height: 24, child: trailing),
        ],
      ),
    );
  }
}

class _RevenueSparkline extends StatelessWidget {
  const _RevenueSparkline();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 1.5),
              FlSpot(3, 3),
              FlSpot(4, 2.5),
              FlSpot(5, 4),
            ],
            isCurved: true,
            color: colorScheme.primary,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
