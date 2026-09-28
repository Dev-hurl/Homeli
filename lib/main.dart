import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/providers/role_provider.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:homeli/core/theme/app_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(
    url: 'https://depaphvgzaijinxbxche.supabase.co',
    publishableKey: 'sb_publishable_ey7FA_3TtPQomZIr9K6XYg_AWUJP896',
  );

  final preferences = await SharedPreferences.getInstance();
  final hasSeenOnboarding =
      preferences.getBool(AppRouter.hasSeenOnboardingPreferenceKey) == true;
  final session = Supabase.instance.client.auth.currentSession;
  final hasExistingSession = session != null;
  final roleName = session?.user.userMetadata?['role'] as String?;
  final activeRole = roleName?.toUpperCase() == 'LISTER'
      ? UserRole.lister
      : UserRole.seeker;

  // Older installations may have an authenticated Supabase session but no
  // onboarding preference saved yet. Treat them as returning users.
  if (hasExistingSession && !hasSeenOnboarding) {
    await preferences.setBool(AppRouter.hasSeenOnboardingPreferenceKey, true);
  }

  AppRouter.initialLocation = hasExistingSession
      ? activeRole == UserRole.lister
            ? AppRouter.listerHome
            : AppRouter.seekerHome
      : hasSeenOnboarding
      ? AppRouter.signIn
      : AppRouter.onboarding;

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserRoleProvider()..setRole(activeRole),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Homeli',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
