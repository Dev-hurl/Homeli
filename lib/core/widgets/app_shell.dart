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

    return Scaffold(
      backgroundColor: Colors.white,
      body: navigationShell,
      bottomNavigationBar: HomeliBottomNav(
        currentIndex: navigationShell.currentIndex,
        onProfileLongPress: () => showProfileSwitcherSheet(context),
        onTap: (index) {
          if (role == UserRole.lister) {
            final listerLocations = [
              AppRouter.listerHome,
              AppRouter.listerBookingRequests,
              AppRouter.messages,
              AppRouter.listerProfile,
            ];
            context.go(listerLocations[index]);
            return;
          }

          final seekerLocations = [
            AppRouter.seekerHome,
            AppRouter.seekerBookings,
            AppRouter.seekerSavedSanctuaries,
            AppRouter.messages,
            AppRouter.seekerProfile,
          ];
          context.go(seekerLocations[index]);
        },
        showAddListingFab: role == UserRole.lister,
        onAddListingTap: () => context.push(AppRouter.listerCreateListing),
      ),
    );
  }
}
