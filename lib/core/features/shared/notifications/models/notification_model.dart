enum NotiificationType { bookings, messages, system }

class NotificationModel {
  final String avatarPath;
  final String titleLable;
  final String message;
  final String timeLabel;
  final bool isRead;
  final NotiificationType type;

  NotificationModel({
    required this.avatarPath,
    required this.titleLable,
    required this.message,
    required this.timeLabel,
    required this.isRead,
    required this.type,
  });

  final notifications = [
    NotificationModel(
      avatarPath: 'assets/images/avatar.png',
      titleLable: 'Tour Request',
      message: 'Liam Gallaghar requested a walkthrough for The Glass Pavilion Soho on Thu, Oct 24.',
      timeLabel: '18m ago',
      isRead: false,

      type: NotiificationType.bookings,
    ),
    NotificationModel(
      avatarPath: 'assets/images/avatar.png',
      titleLable: 'Sophia Chen',
      message: '"Lobby desk on Prince Street! I will meet you there by 10:15 with the key"',
      timeLabel: '42m ago',
      isRead: false,
      type: NotiificationType.messages,
    ),
    NotificationModel(
      avatarPath: 'assets/images/avatar.png',
      titleLable: 'Government ID Verified',
      message: 'Your passport was authenticated. You now hav ethe Gold Trust Badge active across your profiles',
      timeLabel: '4:15 PM',
      isRead: false,
      type: NotiificationType.system,
    ),
    NotificationModel(
      avatarPath: 'assets/images/avatar.png',
      titleLable: 'Price Drop on Saved Santuary',
      message: 'The Arch Browstone in Cobble Hill dropped from \$3,100 to \$2,950/month',
      timeLabel: '11:30 AM',
      isRead: true,
      type: NotiificationType.bookings,
    ),
  ];
}
