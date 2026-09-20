import 'package:flutter/material.dart';
import 'package:homeli/core/features/lister%20role/models/booking_request_model.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/Homeli Logo Inverted .png',
              width: 28,
              height: 28,
            ),
            SizedBox(width: 8),
            Text('Homeli'),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(radius: 16),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Requests',
                        style: textTheme.headlineSmall?.copyWith(
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
                ),
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
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${bookingRequests.length} PENDING INQUIRIES',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
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
            SizedBox(height: 14),
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
            ...bookingRequests.map(
              (request) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: _BookingRequestCard(request: request),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingRequestCard extends StatelessWidget {
  final BookingRequestModel request;
  const _BookingRequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (request.urgencyLabel != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    request.urgencyLabel!,
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Text(
                request.requestedAgo,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(request.guestAvatar),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          request.guestName,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6),
                        if (request.isVerified)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 10,
                                  color: colorScheme.secondary,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  request.verifiedLabel ?? 'Verified',
                                  style: textTheme.labelSmall?.copyWith(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    if (request.guestRating != null)
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: colorScheme.primary,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${request.guestRating} • ${request.guestMetaText}',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      )
                    else if (request.subtitle != null)
                      Text(
                        request.subtitle!,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    request.listingImage,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TARGET LISTING',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 9,
                        ),
                      ),
                      Text(
                        request.listingName,
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (request.listingPrice.isNotEmpty)
                  Text(
                    request.listingPrice,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ),
          if (request.visitType != null || request.duration != null) ...[
            SizedBox(height: 10),
            Row(
              children: [
                if (request.visitType != null)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.tour_outlined,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Visit Type',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                request.visitType!,
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (request.duration != null)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_repeat,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Duration',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                request.duration!,
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else if (request.scheduledTime != null &&
                    request.visitType != null)
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Scheduled Time',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                request.scheduledTime!,
                                style: textTheme.labelSmall?.copyWith(
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
          ] else if (request.scheduledTime != null) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 6),
                Text(
                  request.scheduledTime!,
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
          if (request.guestNote != null) ...[
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '"${request.guestNote}"',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Decline'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Accept Request',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
