import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class ListerDashboardScreen extends StatefulWidget {
  const ListerDashboardScreen({super.key});

  @override
  State<ListerDashboardScreen> createState() => _ListerDashboardScreenState();
}

class _ListerDashboardScreenState extends State<ListerDashboardScreen> {
  int _selectedTab = 0;
  final String _imagePath = '';
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
          CircleAvatar(
            child: _imagePath.isNotEmpty
                ? Image.asset(_imagePath)
                : HugeIcon(
                    icon: HugeIcons.strokeRoundedUser02,
                    size: 24,
                    strokeWidth: 2,
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
            _ActiveListingCard(
              imagePath: 'assets/images/elite-prop.jpg',
              badge: 'Premier Host',
              location: 'Soho, New York',
              title: 'The Glass Pavilion',
              price: '\$3,850',
              stats: ['18 views', '4 requests', '1 today'],
              visibilityLabel: 'Listing Visibility',
              visibilitySubtitle: 'Publicly bookable on search',
              visibilityOn: true,
              actionButtons: ['Edit', 'Calendar', 'Promote'],
              highlightedAction: 'Promote',
            ),
            SizedBox(height: 16),
            _ActiveListingCard(
              imagePath: 'assets/images/naksha.jpg',
              badge: null,
              location: 'Tribeca, New York',
              title: 'Franklin Studio Loft',
              price: '\$4,200',
              stats: ['12 Views today', '2 Booking Inquiries'],
              visibilityLabel: 'Listing Active',
              visibilitySubtitle: 'Accepting instant requests',
              visibilityOn: true,
              actionButtons: ['Manage', 'Calendar'],
              highlightedAction: null,
            ),
            SizedBox(height: 16),
            _DraftListingCard(
              imagePath: 'assets/images/new-uk-homes.png',
              title: 'Chelsea Townhouse',
              stepLabel: 'Draft (Step 2/3)',
              note: 'Pricing & verification pending',
            ),
            SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                context.go('/lister/create-listing');
              },
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
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

class _ActiveListingCard extends StatelessWidget {
  final String imagePath;
  final String? badge;
  final String location;
  final String title;
  final String price;
  final List<String> stats;
  final String visibilityLabel;
  final String visibilitySubtitle;
  final bool visibilityOn;
  final List<String> actionButtons;
  final String? highlightedAction;

  const _ActiveListingCard({
    required this.imagePath,
    required this.badge,
    required this.location,
    required this.title,
    required this.price,
    required this.stats,
    required this.visibilityLabel,
    required this.visibilitySubtitle,
    required this.visibilityOn,
    required this.actionButtons,
    required this.highlightedAction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Active',
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (badge != null) ...[
                      SizedBox(width: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badge!,
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.surface,
                      ),
                    ),
                    Text(
                      title,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.surface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '/month',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: stats
                        .map(
                          (stat) => Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Text(
                              stat,
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visibilityLabel,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            visibilitySubtitle,
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: visibilityOn,
                      onChanged: (_) {},
                      activeThumbColor: colorScheme.primary,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: actionButtons.map((label) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.surfaceContainerLow,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            label,
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DraftListingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String stepLabel;
  final String note;

  const _DraftListingCard({
    required this.imagePath,
    required this.title,
    required this.stepLabel,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(stepLabel, style: textTheme.labelSmall),
                      ),
                      SizedBox(height: 4),
                      Text(
                        title,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        note,
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedEdit02,
                    size: 16,
                    color: colorScheme.secondary,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Finish listing to publish',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
