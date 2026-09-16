import 'package:flutter/material.dart';

class RoleSetupScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              spacing: 8,
              children: [
                Text(
                  'How will you Use Homeli?',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                Text(
                  'Select your primary role. You can switch or add another role anytime from your profile.',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
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
