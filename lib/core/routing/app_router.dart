import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/otp_verification.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/role_setup_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_in_screen.dart';
import 'package:homeli/core/features/auth/presentation/screens/registration/sign_up_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/booking_requests_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/lister_dashboard_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/property_review_screen.dart';
import 'package:homeli/core/features/lister%20role/presentation/screens/trust_verification_screen.dart';
import 'package:homeli/core/features/messaging/presentation/screens/chat_screens.dart';
import 'package:homeli/core/features/messaging/presentation/screens/message_list_screen.dart';
import 'package:homeli/core/features/seeker%20role/models/listing_detail_model.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/booking_detail_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/booking_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/complete_profile_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/leave_review_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/listing_details_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/saved_santuary_screen.dart';
import 'package:homeli/core/features/seeker%20role/presentation/screens/search_filter_screen.dart';
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
  static const seekerBookings = '/seeker/bookings';
  static const seekerBookingDetail = '/seeker/booking-detail';
  static const seekerCompleteProfile = '/seeker/complete-profile';
  static const seekerLeaveReview = '/seeker/leave-review';
  static const seekerListingDetails = '/seeker/listing-details';
  static const seekerSavedSanctuaries = '/seeker/saved-sanctuaries';
  static const seekerSearchFilters = '/seeker/search-filters';
  static const listerHome = '/lister/home';
  static const listerBookingRequests = '/lister/booking-requests';
  static const listerPropertyReviews = '/lister/property-reviews';
  static const listerTrustVerification = '/lister/trust-verification';
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
      GoRoute(
        path: '/lister',
        redirect: (context, state) =>
            state.uri.path == '/lister' ? listerHome : null,
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => ListerDashboardScreen(),
          ),
          GoRoute(
            path: 'booking-requests',
            builder: (context, state) => BookingRequestsScreen(),
          ),
          GoRoute(
            path: 'property-reviews',
            builder: (context, state) => PropertyReviewsScreen(),
          ),
          GoRoute(
            path: 'trust-verification',
            builder: (context, state) => TrustVerificationScreen(),
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
          GoRoute(
            path: 'bookings',
            builder: (context, state) => MyBookingsScreen(),
          ),
          GoRoute(
            path: 'booking-detail',
            builder: (context, state) => BookingDetailScreen(),
          ),
          GoRoute(
            path: 'complete-profile',
            builder: (context, state) => CompleteProfileScreen(),
          ),
          GoRoute(
            path: 'leave-review',
            builder: (context, state) => LeaveReviewScreen(),
          ),
          GoRoute(
            path: 'listing-details',
            builder: (context, state) => ListingDetailScreen(
              listing: state.extra is ListingDetailModel
                  ? state.extra! as ListingDetailModel
                  : listingDetailData,
            ),
          ),
          GoRoute(
            path: 'saved-sanctuaries',
            builder: (context, state) => SavedSanctuariesScreen(),
          ),
          GoRoute(
            path: 'search-filters',
            builder: (context, state) => SearchFiltersScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/messaging',
        redirect: (context, state) =>
            state.uri.path == '/messaging' ? messages : null,
        routes: [
          GoRoute(
            path: 'messages',
            builder: (context, state) => MessagesListScreen(),
          ),
          GoRoute(path: 'chat', builder: (context, state) => ChatScreen()),
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
