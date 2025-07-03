import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/screens/about_us.dart';
import 'package:vetassess/screens/admin_screens/dashboard.dart';
import 'package:vetassess/screens/admin_screens/document_category_screen.dart';
import 'package:vetassess/screens/admin_screens/user_application.dart';
import 'package:vetassess/screens/admin_screens/users_list.dart';
import 'package:vetassess/screens/admin_screens/visa_occupation_ui.dart';
import 'package:vetassess/screens/application_forms/appli_documents_uploaded.dart';
import 'package:vetassess/screens/application_forms/appli_general_edu.dart';
import 'package:vetassess/screens/application_forms/appli_occupation.dart';
import 'package:vetassess/screens/application_forms/appli_personal_details.dart';
import 'package:vetassess/screens/application_forms/appli_priority.dart';
import 'package:vetassess/screens/application_forms/electronic_document_upload.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/screens/application_type%20.dart';
import 'package:vetassess/screens/applioptions.dart';
import 'package:vetassess/screens/apply_screen.dart';
import 'package:vetassess/screens/cancellation_refund_polic.dart';
import 'package:vetassess/screens/contact_us.dart';
import 'package:vetassess/screens/eligibility_criteria.dart';
import 'package:vetassess/screens/employment.dart';
import 'package:vetassess/screens/fee_screen.dart';
import 'package:vetassess/screens/licence.dart';
import 'package:vetassess/screens/login.dart';
import 'package:vetassess/screens/login_page.dart';
import 'package:vetassess/screens/nominate_an_occupation.dart';
import 'package:vetassess/screens/not_found_screen.dart';
import 'package:vetassess/screens/payment_screen.dart';
import 'package:vetassess/screens/priorityprocessing.dart';
import 'package:vetassess/screens/profissional_viewall.dart';
import 'package:vetassess/screens/registration_page.dart';
import 'package:vetassess/screens/review_and_confirm.dart';
import 'package:vetassess/screens/skills_assessment_support.dart';
import 'package:vetassess/screens/submitted_appl.dart';
import 'package:vetassess/screens/terms&conditions.dart';
import 'package:vetassess/screens/tertiary_education.dart';
import 'package:vetassess/widgets/SkillsAssessmentDropdownPanel.dart';
import 'package:vetassess/widgets/skills_assessment_Viewallpage.dart';
import 'package:vetassess/widgets/under_maintenance.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: VetassessApp()));
}

// Create a router provider that rebuilds when auth state changes
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    // Add refresh listenable to rebuild router when login state changes
    refreshListenable: RouterRefreshNotifier(ref),
    redirect: (context, state) async {
      // Get current login state
      final loginState = ref.read(loginProvider);
      final loginNotifier = ref.read(loginProvider.notifier);
      final currentPath = state.fullPath;

      // Define login paths
      final isLoginPath =
          currentPath == '/login' || currentPath == '/login_page';

      // Define protected routes for applicants/agents
      final applicantProtectedRoutes = [
        '/appli_opt',
        '/personal_form',
        '/occupation_form',
        '/education_form',
        '/tertiary_education_form',
        '/employment_form',
        '/licence_form',
        '/app_priority_form',
        '/doc_upload',
        '/appli_type',
      ];

      // Updated protected routes for admins - include ALL new dashboard routes
      final adminProtectedRoutes = [
        '/admin',
        '/admin/dashboard',
        '/admin/users',
        '/admin/categories',
        '/admin/document-categories',
        '/admin/visa-occupation',
        '/admin_users', // Keep for backward compatibility
        '/admin_user-details', // Keep for backward compatibility
      ];

      final isApplicantProtectedRoute = applicantProtectedRoutes.contains(
        currentPath,
      );
      final isAdminProtectedRoute = adminProtectedRoutes.contains(currentPath) ||
          currentPath!.startsWith('/admin/');
      final isAnyProtectedRoute =
          isApplicantProtectedRoute || isAdminProtectedRoute;

      // For protected routes, validate session before proceeding
      if (isAnyProtectedRoute) {
        final isSessionValid = await loginNotifier.validateSession();
        if (!isSessionValid) {
          return '/login';
        }
      }

      // If user is logged in and trying to access login page
      if (loginState.isSuccess && loginState.response != null && isLoginPath) {
        // Navigate based on user role
        final defaultRoute = loginNotifier.getNavigationRouteForRole();
        // If admin, redirect to new dashboard
        if (loginState.userRole == 'admin') {
          return '/admin/dashboard';
        }
        return defaultRoute;
      }

      // If user is not logged in and trying to access protected routes
      if (!loginState.isSuccess && isAnyProtectedRoute) {
        return '/login';
      }

      // If user is logged in but trying to access wrong role's routes
      if (loginState.isSuccess && loginState.userRole != null) {
        final userRole = loginState.userRole!;

        // Admin trying to access applicant routes
        if (userRole == 'admin' && isApplicantProtectedRoute) {
          return '/admin/dashboard';
        }

        // Applicant/Agent trying to access admin routes
        if ((userRole == 'applicant' || userRole == 'agent') &&
            isAdminProtectedRoute) {
          return '/appli_opt';
        }
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '*', builder: (context, state) => const NotFoundScreen()),

      GoRoute(
        path: '/login_page',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const Login()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const VetassessRegistrationForm(),
      ),

      // NEW COMPLETE Admin Dashboard Routes
      GoRoute(
        path: '/admin',
        redirect: (context, state) => '/admin/dashboard',
      ),
      GoRoute(
        path: '/admin/dashboard',
        name: 'admin_dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/users',
        name: 'admin_users_new',
        builder: (context, state) => const UsersListScreen(),
      ),
      /* GoRoute(
        path: '/admin/categories',
        name: 'admin_categories',
        builder: (context, state) => const CategoriesManagementScreen(),
      ),*/
      GoRoute(
        path: '/admin/document-categories',
        name: 'admin_document_categories',
        builder: (context, state) => const DocumentManagementScreen(),
      ),
      GoRoute(
        path: '/admin/visa-occupation',
        name: 'admin_visa_occupation',
        builder: (context, state) => const VisaOccupationManagementScreen(),
      ),

      // Legacy Admin routes (keep for backward compatibility)
      GoRoute(
        path: '/admin_users',
        builder: (context, state) => UsersListScreen(),
      ),
      GoRoute(
        path: '/admin_user-details',
        name: 'admin_user-details',
        builder: (context, state) {
          final user = state.extra as Users;
          return UserDetailsScreen(user: user);
        },
      ),

      // Contact and About pages
      GoRoute(path: '/contact_us', builder: (context, state) => ContactUs()),
      GoRoute(path: '/about_us', builder: (context, state) => AboutUs()),
      
      GoRoute(
        path: '/cancellation-refund-policy',
        builder: (context, state) => const CancellationRefundPolicy(),
      ),
      // Public routes
      GoRoute(
        path: '/application_process',
        builder: (context, state) => const ApplicationProcess(),
      ),

      GoRoute(
        path: '/submitted_opp',
        builder: (context, state) => const SubmittedAppl(),
      ),

      GoRoute(
        path: '/fee_screen',
        builder: (context, state) => const FeeScreen(),
      ),
      GoRoute(
        path: '/skills_assess_support',
        builder: (context, state) => const SkillsAssessmentSupport(),
      ),
      GoRoute(
        path: '/nominate_screen',
        builder: (context, state) => const NominateScreen(),
      ),
      GoRoute(
        path: '/eligibility_criteria',
        builder: (context, state) => const EligibilityCriteria(),
      ),
      GoRoute(
        path: '/priority_processing',
        builder: (context, state) => const PriorityProcessing(),
      ),
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenancePage(),
      ),
      GoRoute(
        path: '/skill_assess_viewall',
        builder: (context, state) => const SkillsAssessmentViewall(),
      ),
      GoRoute(
        path: '/professionals_viewall',
        builder: (context, state) => const ProfessionalViewall(),
      ),
      GoRoute(
        path: '/apply_now',
        builder: (context, state) => const ApplyNowScreen(),
      ),

      // Applicant/Agent application forms - Protected routes
      GoRoute(
        path: '/personal_form',
        builder: (context, state) => const PersonalDetailsForm(),
      ),
      GoRoute(
        path: '/occupation_form',
        builder: (context, state) => const OccupationForm(),
      ),
      GoRoute(
        path: '/education_form',
        builder: (context, state) => const EducationForm(),
      ),
      GoRoute(
        path: '/tertiary_education_form',
        builder: (context, state) => const TertiaryEducationForm(),
      ),
      GoRoute(
        path: '/employment_form',
        builder: (context, state) => const EmploymentForm(),
      ),
      GoRoute(
        path: '/licence_form',
        builder: (context, state) => const LicenceForm(),
      ),
      GoRoute(
        path: '/app_priority_form',
        builder: (context, state) => const ApplicationPriorityProcessing(),
      ),
      GoRoute(
        path: '/doc_upload',
        builder: (context, state) => const DocumentUploadScreen(),
      ),
      GoRoute(
        path: '/vetassess_upload',
        builder: (context, state) => VetassessUploadPage(),
      ),
      GoRoute(
        path: '/appli_type',
        builder: (context, state) => const ApplicationTypeSelectionScreen(),
      ),
      GoRoute(
        path: '/appli_opt',
        builder: (context, state) => const AppliOptions(),
      ),
      GoRoute(
        path: '/get_all_forms',
        builder: (context, state) => const ReviewAndConfirm(),
      ),
      GoRoute(
        path: '/cashfree_pay',
        builder: (context, state) => const CashfreePaymentScreen(),
      ),
      GoRoute(
        path: '/terms-conditions',
        builder: (context, state) => const TermsAndConditions(),
      ),
    ],
  );
});


// Create a custom listenable that watches the login provider
class RouterRefreshNotifier extends ChangeNotifier {
  late final ProviderSubscription _subscription;

  RouterRefreshNotifier(ProviderRef ref) {
    _subscription = ref.listen(loginProvider, (previous, next) {
      // Notify router to refresh when login state or role changes
      if (previous?.isSuccess != next.isSuccess ||
          previous?.userRole != next.userRole ||
          previous?.response?.userId != next.response?.userId) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

class VetassessApp extends ConsumerWidget {
  const VetassessApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VETASSESS - Skills Assessment Australia',
      routerConfig: router,
    );
  }
}