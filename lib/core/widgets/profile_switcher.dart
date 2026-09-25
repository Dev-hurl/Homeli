import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileOption {
  final String imagePath;
  final String name;
  final String subtitle;
  final double? rating;
  ProfileOption({
    required this.imagePath,
    required this.name,
    required this.subtitle,
    this.rating,
  });
}

Future<void> showProfileSwitcherSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => ProfileSwitcherSheet(),
    //TODO: USage : onPressed: () => showProfileSwitcherSheet(context)
  );
}

class ProfileSwitcherSheet extends StatefulWidget {
  const ProfileSwitcherSheet({super.key});

  @override
  State<ProfileSwitcherSheet> createState() => _ProfileSwitcherSheetState();
}

class _ProfileSwitcherSheetState extends State<ProfileSwitcherSheet> {
  int _selectedIndex = 0;

  final _profiles = [
    ProfileOption(
      imagePath: 'assets/images/avatar.png',
      name: 'Larry Cho',
      subtitle: 'Renting & Exploring',
    ),
    ProfileOption(
      imagePath: 'assets/images/avatar.png',
      name: 'Sophia Chen (Host)',
      subtitle: '2 Active Listings',
      rating: 4.96,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Text(
              'Seamlessly transition between renting your dream home and managing listing inquiries.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            ...List.generate(_profiles.length, (index) {
              final profile = _profiles[index];
              final selected = index == _selectedIndex;
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? colorScheme.primary
                            : Colors.transparent,
                        width: 1.3,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(profile.imagePath),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              if (profile.rating != null)
                                Row(
                                  children: [
                                    Text(
                                      profile.subtitle,
                                      style: textTheme.labelSmall,
                                    ),
                                    SizedBox(width: 8),
                                    HugeIcon(
                                      icon: HugeIcons.strokeRoundedStar,
                                      size: 12,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '${profile.rating}',
                                      style: textTheme.labelSmall,
                                    ),
                                  ],
                                )
                              else
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    profile.subtitle,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colorScheme.secondaryContainer,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        selected
                            ? Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: HugeIcon(
                                  icon:
                                      HugeIcons.strokeRoundedCheckmarkCircle02,
                                  size: 16,
                                  color: colorScheme.surface,
                                ),
                              )
                            : HugeIcon(
                                icon: HugeIcons.strokeRoundedArrowRight01,
                                size: 18,
                                color: colorScheme.onSurfaceVariant,
                              ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(icon: HugeIcons.strokeRoundedAdd01, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Add Another Role',
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedRefresh,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                    strokeWidth: 2,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Chats sync instantly',
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
