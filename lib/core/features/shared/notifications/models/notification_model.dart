enum NotificationType { bookings, messages, system, review }

class NotificationModel {
  final String avatarPath;
  final String titleLabel;
  final String message;
  final String timeLabel;
  final bool isRead;
  final NotificationType type;
  final String dateGroupLabel;
  final String? primaryActionLabel;
  final String? secondaryActionLabel;
  final String? roleTag;

  const NotificationModel({
    required this.avatarPath,
    required this.titleLabel,
    required this.message,
    required this.timeLabel,
    required this.isRead,
    required this.type,
    required this.dateGroupLabel,
    this.primaryActionLabel,
    this.secondaryActionLabel,
    this.roleTag,
  });
}

final notifications = [
  const NotificationModel(
    avatarPath: 'assets/images/avatar.png',
    titleLabel: 'Tour Request',
    message: 'Liam Gallagher requested a walkthrough for The Glass Pavilion Soho on Thu, Oct 24.',
    timeLabel: '18m ago',
    isRead: false,
    type: NotificationType.bookings,
    dateGroupLabel: 'TODAY',
    primaryActionLabel: 'Review Request',
    secondaryActionLabel: 'Decline',
  ),
  const NotificationModel(
    avatarPath: 'assets/images/avatar.png',
    titleLabel: 'Sophia Chen',
    message: '"Lobby desk on Prince Street! I will meet you there by 10:15 with the key"',
    timeLabel: '42m ago',
    isRead: false,
    type: NotificationType.messages,
    dateGroupLabel: 'TODAY',
  ),
  const NotificationModel(
    avatarPath: 'assets/images/avatar.png',
    titleLabel: 'Government ID Verified',
    message: 'Your passport was authenticated. You now have the Gold Trust Badge active across your profiles.',
    timeLabel: '4:15 PM',
    isRead: false,
    type: NotificationType.system,
    dateGroupLabel: 'YESTERDAY',
  ),
  const NotificationModel(
    avatarPath: 'assets/images/avatar.png',
    titleLabel: 'Price Drop on Saved Sanctuary',
    message: 'The Arched Brownstone in Cobble Hill dropped from \$3,100 to \$2,950/month.',
    timeLabel: '11:30 AM',
    isRead: true,
    type: NotificationType.bookings,
    dateGroupLabel: 'YESTERDAY',
  ),
  const NotificationModel(
    avatarPath: 'assets/images/avatar.png',
    titleLabel: 'New 5.0 Star Review',
    message: '"An exquisite sanctuary with impeccable natural lighting and effortless keyless entry."',
    timeLabel: 'Oct 19',
    isRead: true,
    type: NotificationType.review,
    dateGroupLabel: 'EARLIER THIS WEEK',
    roleTag: 'Host',
  ),
];
