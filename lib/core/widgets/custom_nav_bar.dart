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
  NavItem(icon: HugeIcons.strokeRoundedMessage01, label: 'Messages'),
  NavItem(icon: HugeIcons.strokeRoundedUser02, label: 'Profile'),
];

class HomeliBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showAddListingFab;
  final VoidCallback? onAddListingTap;

  const HomeliBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showAddListingFab = false,
    this.onAddListingTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16  ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(navItems.length, (index) {
                    final selected = index == currentIndex;
                    final item = navItems[index];
                    return GestureDetector(
                      onTap: () => onTap(index),
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
              if (showAddListingFab) ...[
                SizedBox(width: 10),
                GestureDetector(
                  onTap: onAddListingTap,
                  child: Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      color: colorScheme.secondary,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
