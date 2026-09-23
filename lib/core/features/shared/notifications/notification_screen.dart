import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedTab = 0;
  final _tabs = ['All', 'Bookings', 'Messages', 'System'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Messages',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '3 Unread',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.done_all, size: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final selected = index == _selectedTab;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
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
                separatorBuilder: (_, _) => SizedBox(height: 8),
                itemCount: _tabs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
