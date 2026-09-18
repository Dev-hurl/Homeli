import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SeekerHomeScreen extends StatefulWidget {
  final String firstName;
  const SeekerHomeScreen({super.key, required this.firstName});

  @override
  State<SeekerHomeScreen> createState() => _SeekerHomeScreenState();
}

class _SeekerHomeScreenState extends State<SeekerHomeScreen> {
  final String _imagePath = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leading: Image.asset(
          'assets/icons/Homeli Logo Inverted.png',
          width: 40,
          height: 40,
        ),
        actions: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedNotification01,
            size: 24,
            strokeWidth: 2,
          ),
          SizedBox(width: 16),
          CircleAvatar(
            child: _imagePath.isNotEmpty
                ? Image.asset(_imagePath)
                : HugeIcon(
                    icon: HugeIcons.strokeRoundedUser02,
                    size: 24,
                    strokeWidth: 2,
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: colorScheme.surfaceContainerHigh,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      spacing: 6,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedLocation09,
                          color: colorScheme.secondaryContainer,
                        ),
                        Text(
                          'Nigeria,IB',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //
                          },
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowDown01,
                            strokeWidth: 2,
                            color: colorScheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning ${widget.firstName}',
                  style: textTheme.bodyMedium?.copyWith(),
                ),
                Text(
                  'Find your perfect place',
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
