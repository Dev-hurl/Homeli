import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_in_screen.dart';
import 'package:homeli/core/features/auth/providers/role_provider.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/lister_dashboard_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/seeker_home_screen.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
  automatically listen for auth state chages

  unauthenticated => loginScreen
  authenticated => profilescreen
*/
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen for changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        //Check for valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session == null) {
          return SignInScreen();
        }

        final metadata = session.user.userMetadata ?? <String, dynamic>{};
        final roleName = (metadata['role'] as String?)?.toUpperCase();
        final activeRole = roleName == 'LISTER'
            ? UserRole.lister
            : UserRole.seeker;

        if (context.read<UserRoleProvider>().activeRole != activeRole) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<UserRoleProvider>().setRole(activeRole);
            }
          });
        }

        if (activeRole == UserRole.lister) {
          return ListerDashboardScreen();
        }

        final legalName = (metadata['legal_name'] as String?)?.trim();
        return SeekerHomeScreen(
          firstName: legalName == null || legalName.isEmpty
              ? 'User'
              : legalName,
        );
      },
    );
  }
}
