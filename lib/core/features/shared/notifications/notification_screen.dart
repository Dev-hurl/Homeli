import 'package:flutter/material.dart';
import 'package:homeli/core/features/shared/notifications/models/notification_model.dart';
import 'package:homeli/core/features/shared/notifications/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedTab = 0;
  final _tabs = const ['All', 'Bookings', 'Messages', 'System'];

  List<NotificationModel> get _filtered {
    switch (_selectedTab) {
      case 1:
        return notifications
            .where(
              (n) =>
                  n.type == NotificationType.bookings ||
                  n.type == NotificationType.review,
            )
            .toList();
      case 2:
        return notifications
            .where((n) => n.type == NotificationType.messages)
            .toList();
      case 3:
        return notifications
            .where((n) => n.type == NotificationType.system)
            .toList();
      default:
        return notifications;
    }
  }

  Map<String, List<NotificationModel>> get _grouped {
    final map = <String, List<NotificationModel>>{};
    for (final n in _filtered) {
      map.putIfAbsent(n.dateGroupLabel, () => []).add(n);
    }
    return map;
  }

  int _countFor(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return notifications
            .where(
              (n) =>
                  n.type == NotificationType.bookings ||
                  n.type == NotificationType.review,
            )
            .length;
      case 2:
        return notifications
            .where((n) => n.type == NotificationType.messages)
            .length;
      case 3:
        return notifications
            .where((n) => n.type == NotificationType.system)
            .length;
      default:
        return notifications.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final unreadCount = notifications.where((n) => !n.isRead).length;
    final grouped = _grouped;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Notification',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (unreadCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$unreadCount New',
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.done_all, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Mark all read',
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final selected = index == _selectedTab;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTab = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? colorScheme.secondaryContainer
                              : colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          '${_tabs[index]} (${_countFor(index)})',
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
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                children: grouped.entries.expand((entry) {
                  final groupUnread = entry.value
                      .where((n) => !n.isRead)
                      .length;
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              letterSpacing: 1,
                            ),
                          ),
                          if (groupUnread > 0)
                            Text(
                              '$groupUnread unread',
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    ...entry.value.map<Widget>(
                      (n) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: NotificationCard(notification: n),
                      ),
                    ),
                  ];
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
