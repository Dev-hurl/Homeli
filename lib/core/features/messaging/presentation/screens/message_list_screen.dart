import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/messaging/models/conversation_model.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  final _searchController = TextEditingController();
  int _selectedTab = 0;
  final _tabs = ['All Messages', 'Active Stays', 'Tour Inquiries'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final unreadTotal = conversations.fold<int>(
      0,
      (sum, c) => sum + c.unreadCount,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Messages',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (unreadTotal > 0) ...[
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$unreadTotal Unread',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.surface,
                          fontWeight: FontWeight.w600,
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
              SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                  hintText: 'Search conversations or listings...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedSearch02,
                      size: 18,
                      strokeWidth: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
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
              Expanded(
                child: ListView.separated(
                  //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: conversations.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 24,
                    color: Theme.of(context).dividerColor,
                  ),
                  itemBuilder: (context, index) =>
                      _ConversationTile(conversation: conversations[index]),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'messages-new-message-fab',
        onPressed: () {},
        backgroundColor: colorScheme.secondaryContainer,
        icon: HugeIcon(icon: HugeIcons.strokeRoundedEdit03),
        label: Text(
          'New Message',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.push(AppRouter.chat);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(conversation.avatarPath),
              ),
              if (conversation.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      conversation.name,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        conversation.roleTag,
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      conversation.timeLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedHome01,
                      size: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        conversation.contextLabel,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        conversation.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: conversation.unreadCount > 0
                              ? colorScheme.onSurface
                              : colorScheme.onSurfaceVariant,
                          fontWeight: conversation.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    if (conversation.unreadCount > 0)
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${conversation.unreadCount}',
                          style: textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    else if (conversation.isRead)
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: colorScheme.secondary,
                      )
                    else
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
