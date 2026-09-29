import 'package:flutter/material.dart';
import 'package:homeli/core/features/lister%20role/models/booking_request_model.dart';
import 'package:homeli/core/features/lister%20role/presentation/widgets/booking_request_card.dart';
import 'package:hugeicons/hugeicons.dart';

class BookingRequestsScreen extends StatefulWidget {
  const BookingRequestsScreen({super.key});

  @override
  State<BookingRequestsScreen> createState() => _BookingRequestsScreenState();
}

class _BookingRequestsScreenState extends State<BookingRequestsScreen> {
  int _selectedTab = 0;
  final _tabs = ['All Requests (3)', 'Tours & Visits (2)', 'Monthly Stays (1)'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Requests',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Manage host inquiries and prospective guests',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedPreferenceHorizontal,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${bookingRequests.length} PENDING INQUIRIES',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Auto-declines after 24h',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
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
                            ? colorScheme.secondaryContainer
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
            ...bookingRequests.map(
              (request) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: BookingRequestCard(
                  request: request,
                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

