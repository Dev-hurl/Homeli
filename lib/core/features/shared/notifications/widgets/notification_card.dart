import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 50,
      decoration: BoxDecoration(color: colorScheme.surface),
      child: Column(
        children: [
          //
        ],
      ),
    );
  }
}
