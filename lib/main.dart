import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/role_setup_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/splash_screen.dart';
import 'package:homeli/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homeli',
      theme: AppTheme.lightTheme,
      home: OnboardingScreen(), // Change this to the desired initial screen
    );
  }
}
