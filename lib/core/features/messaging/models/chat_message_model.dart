class ChatMessageModel {
  final String text;
  final String time;
  final bool isMe;
  final bool isRead;
  ChatMessageModel({
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });
}

final chatMessages = [
  ChatMessageModel(
    text: 'Hi Alex! Looking forward to showing you the Soho sanctuary this Thursday.',
    time: '10:32 AM',
    isMe: false,
  ),
  ChatMessageModel(
    text: 'Just confirming if 2:00 PM still works well for your schedule?',
    time: '10:33 AM',
    isMe: false,
  ),
  ChatMessageModel(
    text: 'Hi Sophia! Yes, 2:00 PM is perfect. Should I come directly to the Mercer St entrance or the lobby?',
    time: '10:38 AM',
    isMe: true,
    isRead: true,
  ),
  ChatMessageModel(
    text: 'Lobby desk on Prince Street! I will meet you there with the access credentials and property guidebook.',
    time: '10:41 AM',
    isMe: false,
  ),
];
