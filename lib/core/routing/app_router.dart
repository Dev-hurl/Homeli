import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/otp_verification.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/role_setup_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_in_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_up_screen.dart';
import 'package:homeli/core/features/lister role/presentation/screens/lister_home_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/seeker_home_screen.dart';
import 'package:homeli/core/features/shared/notifications/notification_screen.dart';

enum UserRole { seeker, lister }

class SignUpRouteArguments {
  final UserRole role;

  SignUpRouteArguments({required this.role});
}

class OtpRouteArguments {
  final String firstName;
  final String emailAddress;
  final UserRole role;

  OtpRouteArguments({
    required this.firstName,
    required this.emailAddress,
    required this.role,
  });
}

class SeekerHomeRouteArguments {
  final String firstName;

  SeekerHomeRouteArguments({required this.firstName});
}

class AppRouter {
  static const onboarding = '/';
  static const roleSetup = '/auth/role-setup';
  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const otpVerification = '/auth/otp-verification';
  static const seekerHome = '/seeker/home';
  static const listerHome = '/lister/home';
  static const notifications = '/shared/notifications';

  static final GoRouter router = GoRouter(
    initialLocation: onboarding,
    routes: [
      GoRoute(
        path: onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        redirect: (context, state) =>
            state.uri.path == '/auth' ? roleSetup : null,
        routes: [
          GoRoute(
            path: 'role-setup',
            builder: (context, state) => RoleSetupScreen(),
          ),
          GoRoute(path: 'sign-in', builder: (context, state) => SignInScreen()),
          GoRoute(
            path: 'sign-up',
            builder: (context, state) {
              final arguments = state.extra! as SignUpRouteArguments;
              return SignUpScreen(roleName: _roleName(arguments.role));
            },
          ),
          GoRoute(
            path: 'otp-verification',
            builder: (context, state) {
              final arguments = state.extra! as OtpRouteArguments;
              return OtpVerification(
                firstName: arguments.firstName,
                emailAddress: arguments.emailAddress,
                roleName: _roleName(arguments.role),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/lister',
        redirect: (context, state) =>
            state.uri.path == '/lister' ? listerHome : null,
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => ListerHomeScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/seeker',
        redirect: (context, state) =>
            state.uri.path == '/seeker' ? seekerHome : null,
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) {
              final arguments = state.extra! as SeekerHomeRouteArguments;
              return SeekerHomeScreen(firstName: arguments.firstName);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/shared',
        redirect: (context, state) =>
            state.uri.path == '/shared' ? notifications : null,
        routes: [
          GoRoute(
            path: 'notifications',
            builder: (context, state) => NotificationScreen(),
          ),
        ],
      ),
    ],
  );

  static String _roleName(UserRole role) {
    return role == UserRole.lister ? 'LISTER' : 'SEEKER';
  }
}
