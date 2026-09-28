import 'package:flutter/material.dart';
import 'package:homeli/core/features/shared/notifications/models/notification_model.dart';
import 'package:hugeicons/hugeicons.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notification.isRead
            ? colorScheme.surface
            : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeadingIcon(colorScheme),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              notification.titleLabel,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (notification.roleTag != null) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                notification.roleTag!,
                                style: textTheme.labelSmall?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Text(
                      notification.timeLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (notification.primaryActionLabel != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          notification.primaryActionLabel!,
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (notification.secondaryActionLabel != null) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            notification.secondaryActionLabel!,
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (!notification.isRead) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLeadingIcon(ColorScheme colorScheme) {
    if (notification.type == NotificationType.messages) {
      return CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage(notification.avatarPath),
      );
    }

    final dynamic icon;
    final Color bgColor;
    switch (notification.type) {
      case NotificationType.bookings:
        icon = HugeIcons.strokeRoundedCalendar03;
        bgColor = colorScheme.primaryContainer;
        break;
      case NotificationType.system:
        icon = HugeIcons.strokeRoundedShieldUser;
        bgColor = colorScheme.secondaryContainer;
        break;
      case NotificationType.review:
        icon = HugeIcons.strokeRoundedStar;
        bgColor = colorScheme.primaryContainer;
        break;
      case NotificationType.messages:
        icon = HugeIcons.strokeRoundedMessage01; // unreachable, handled above
        bgColor = colorScheme.surfaceContainerHigh;
        break;
    }

    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: UnconstrainedBox(
        child: HugeIcon(
          icon: icon,
          size: 22,
          color: colorScheme.surface,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
