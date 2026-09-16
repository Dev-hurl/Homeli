import 'package:flutter/material.dart';
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
      title: 'Homeli',
      theme: AppTheme.lightTheme,
      home: SplashScreen()
    );
  }
}
