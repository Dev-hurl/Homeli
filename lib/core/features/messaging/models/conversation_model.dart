class ConversationModel {
  final String avatarPath;
  final String name;
  final String roleTag;
  final String contextLabel;
  final String lastMessage;
  final String timeLabel;
  final int unreadCount;
  final bool isOnline;
  final bool isRead;

  ConversationModel({
    required this.avatarPath,
    required this.name,
    required this.roleTag,
    required this.contextLabel,
    required this.lastMessage,
    required this.timeLabel,
    required this.unreadCount,
    required this.isOnline,
    required this.isRead,
  });
}

final conversations = [
  ConversationModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Sophia Chen',
    roleTag: 'HOST',
    contextLabel: 'The Glass Pavilion, Soho',
    lastMessage: 'I will be waiting by the lobby w...',
    timeLabel: '10:42 AM',
    unreadCount: 2,
    isOnline: true,
    isRead: false,
  ),
  ConversationModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Julian Hayes',
    roleTag: 'LISTER',
    contextLabel: 'Franklin Studio Loft',
    lastMessage: 'Would Saturday 11am work for yo...',
    timeLabel: 'Yesterday',
    unreadCount: 0,
    isOnline: false,
    isRead: false,
  ),
  ConversationModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Marcus Vance',
    roleTag: 'HOST',
    contextLabel: 'The Arched Brownstone',
    lastMessage: 'Thanks for visiting! Let me know ...',
    timeLabel: 'Oct 19',
    unreadCount: 0,
    isOnline: false,
    isRead: true,
  ),
  ConversationModel(
    avatarPath: 'assets/images/avatar1.png',
    name: 'Homeli Concierge',
    roleTag: 'OFFICIAL',
    contextLabel: 'Account & Verification',
    lastMessage: 'Your identity verification was succe...',
    timeLabel: 'Oct 17',
    unreadCount: 0,
    isOnline: false,
    isRead: true,
  ),
];
