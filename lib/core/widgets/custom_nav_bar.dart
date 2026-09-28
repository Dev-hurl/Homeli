import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NavItem {
  final dynamic icon;
  final String label;
  NavItem({required this.icon, required this.label});
}

final navItems = [
  NavItem(icon: HugeIcons.strokeRoundedHome01, label: 'Home'),
  NavItem(icon: HugeIcons.strokeRoundedCalendar03, label: 'Bookings'),
  NavItem(icon: HugeIcons.strokeRoundedBookmark01, label: 'Saved'),
  NavItem(icon: HugeIcons.strokeRoundedMessage01, label: 'Messages'),
  NavItem(icon: HugeIcons.strokeRoundedUser02, label: 'Profile'),
];

final listerNavItems = [navItems[0], navItems[1], navItems[3], navItems[4]];

class HomeliBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onProfileLongPress;
  final List<NavItem>? items;

  const HomeliBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onProfileLongPress,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final visibleItems = items ?? navItems;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  //color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(visibleItems.length, (index) {
                    final selected = index == currentIndex;
                    final item = visibleItems[index];
                    return GestureDetector(
                      onTap: () => onTap(index),
                      onLongPress: index == visibleItems.length - 1
                          ? onProfileLongPress
                          : null,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: selected ? 20 : 28,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? colorScheme.secondaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HugeIcon(
                                icon: item.icon,
                                size: 20,
                                color: selected
                                    ? colorScheme.surface
                                    : colorScheme.onSurfaceVariant,
                                strokeWidth: 2,
                              ),
                              if (selected) ...[
                                SizedBox(width: 6),
                                Text(
                                  item.label,
                                  style: textTheme.labelLarge?.copyWith(
                                    color: colorScheme.surface,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
