import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/providers/role_provider.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:homeli/core/theme/app_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await Supabase.initialize(
    url: 'https://depaphvgzaijinxbxche.supabase.co',
    publishableKey: 'sb_publishable_ey7FA_3TtPQomZIr9K6XYg_AWUJP896',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserRoleProvider(),
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
