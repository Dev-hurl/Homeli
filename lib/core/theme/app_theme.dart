import 'package:flutter/material.dart';
import 'package:homeli/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.borderColor,
    fontFamily: 'Plus Jakarta Sans',

    colorScheme: ColorScheme.light(
      primary: AppColors.goldPrimary,
      primaryContainer: AppColors.goldSecondary,
      tertiary: AppColors.goldTertiary,
      secondary: AppColors.bluePrimary,
      secondaryContainer: AppColors.blueSecondary,
      surface: AppColors.white,
      surfaceContainerLow: AppColors.greyLight,
      surfaceContainerHigh: AppColors.grey,
      onSurface: AppColors.primaryText,
      onSurfaceVariant: AppColors.secondaryText,
      error: AppColors.error,
      
    ),
    
  );
}
