import 'package:flutter/material.dart';

class EditIdentityScreen extends StatelessWidget {
  const EditIdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Identity & Profile',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text(
          'Edit your name, phone number, avatar, and profile details.',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
