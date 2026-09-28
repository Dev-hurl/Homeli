import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/providers/role_provider.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:homeli/core/widgets/custom_nav_bar.dart';
import 'package:homeli/core/widgets/profile_switcher.dart';
import 'package:provider/provider.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<UserRoleProvider>().activeRole;
    final isLister = role == UserRole.lister;
    final currentNavIndex = isLister
        ? switch (navigationShell.currentIndex) {
            0 => 0,
            1 => 1,
            3 => 2,
            4 => 3,
            _ => 0,
          }
        : navigationShell.currentIndex;

    return Scaffold(
      //backgroundColor: Colors.white,
      body: navigationShell,
      bottomNavigationBar: HomeliBottomNav(
        items: isLister ? listerNavItems : navItems,
        currentIndex: currentNavIndex,

        onProfileLongPress: () => showProfileSwitcherSheet(context),
        onTap: (index) {
          if (isLister) {
            final listerLocations = [
              AppRouter.listerHome,
              AppRouter.listerBookingRequests,
              AppRouter.messages,
              AppRouter.accountSettings,
            ];
            context.go(listerLocations[index]);
            return;
          }

          final seekerLocations = [
            AppRouter.seekerHome,
            AppRouter.seekerBookings,
            AppRouter.seekerSavedSanctuaries,
            AppRouter.messages,
            AppRouter.accountSettings,
          ];
          context.go(seekerLocations[index]);
        },
      ),
    );
  }
}
