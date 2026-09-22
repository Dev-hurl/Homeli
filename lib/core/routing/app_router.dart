import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/otp_verification.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/role_setup_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_in_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_up_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/booking_requests_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/lister_dashboard_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/lister_profile_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/property_review_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/trust_verification_screen.dart';
import 'package:homeli/core/features/messaging/presentation/screens/chat_screens.dart';
import 'package:homeli/core/features/messaging/presentation/screens/message_list_screen.dart';
import 'package:homeli/core/features/seeker%20role/models/listing_detail_model.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/booking_detail_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/booking_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/leave_review_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/listing_details_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/saved_santuary_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/search_filter_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/seeker_home_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/seeker_profile_screen.dart';
import 'package:homeli/core/features/shared/notifications/notification_screen.dart';
import 'package:homeli/core/widgets/app_shell.dart';

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
  static const seekerBookings = '/seeker/bookings';
  static const seekerBookingDetail = '/seeker/booking-detail';
  static const seekerLeaveReview = '/seeker/leave-review';
  static const seekerListingDetails = '/seeker/listing-details';
  static const seekerSavedSanctuaries = '/seeker/saved-sanctuaries';
  static const seekerSearchFilters = '/seeker/search-filters';
  static const seekerProfile = '/seeker/profile';
  static const listerHome = '/lister/home';
  static const listerBookingRequests = '/lister/booking-requests';
  static const listerPropertyReviews = '/lister/property-reviews';
  static const listerTrustVerification = '/lister/verification';
  static const listerProfile = '/lister/profile';
  static const messages = '/messaging/messages';
  static const chat = '/messaging/chat';
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: seekerHome,
                builder: (context, state) {
                  final arguments = state.extra;
                  final firstName = arguments is SeekerHomeRouteArguments
                      ? arguments.firstName
                      : 'User';
                  return SeekerHomeScreen(firstName: firstName);
                },
              ),
              GoRoute(
                path: listerHome,
                builder: (context, state) => ListerDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: seekerBookings,
                builder: (context, state) => MyBookingsScreen(),
              ),
              GoRoute(
                path: listerBookingRequests,
                builder: (context, state) => BookingRequestsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: messages,
                builder: (context, state) => MessagesListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: seekerProfile,
                builder: (context, state) => SeekerProfileScreen(),
              ),
              GoRoute(
                path: listerProfile,
                builder: (context, state) => ListerProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/seeker/booking-detail',
        builder: (context, state) => BookingDetailScreen(),
      ),
      GoRoute(
        path: '/seeker/leave-review',
        builder: (context, state) => LeaveReviewScreen(),
      ),
      GoRoute(
        path: '/seeker/listing-details',
        builder: (context, state) => ListingDetailScreen(
          listing: state.extra is ListingDetailModel
              ? state.extra! as ListingDetailModel
              : listingDetailData,
        ),
      ),
      GoRoute(
        path: '/seeker/saved-sanctuaries',
        builder: (context, state) => SavedSanctuariesScreen(),
      ),
      GoRoute(
        path: seekerSearchFilters,
        builder: (context, state) => SearchFiltersScreen(),
      ),
      GoRoute(
        path: '/lister/property-reviews',
        builder: (context, state) => PropertyReviewsScreen(),
      ),
      GoRoute(
        path: '/lister/verification',
        builder: (context, state) => TrustVerificationScreen(),
      ),
      GoRoute(
        path: '/messaging/chat',
        builder: (context, state) => ChatScreen(),
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
