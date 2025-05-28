import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetassess/screens/application_forms/appli_documents_uploaded.dart';
import 'package:vetassess/screens/application_forms/appli_general_edu.dart';
import 'package:vetassess/screens/application_forms/appli_occupation.dart';
import 'package:vetassess/screens/application_forms/appli_personal_details.dart';
import 'package:vetassess/screens/application_forms/appli_priority.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/screens/application_type%20.dart';
import 'package:vetassess/screens/applioptions.dart';
import 'package:vetassess/screens/apply_screen.dart';
import 'package:vetassess/screens/eligibility_criteria.dart';
import 'package:vetassess/screens/empoyment.dart';
import 'package:vetassess/screens/fee_screen.dart';
import 'package:vetassess/screens/licence.dart';
import 'package:vetassess/screens/login.dart';
import 'package:vetassess/screens/login_page.dart';
import 'package:vetassess/screens/nominate_an_occupation.dart';
import 'package:vetassess/screens/not_found_screen.dart';
import 'package:vetassess/screens/priorityprocessing.dart';
import 'package:vetassess/screens/profissional_viewall.dart';
import 'package:vetassess/screens/registration_page.dart';
import 'package:vetassess/screens/skills_assessment_support.dart';
import 'package:vetassess/screens/tertiary_education.dart';
import 'package:vetassess/widgets/SkillsAssessmentDropdownPanel.dart';
import 'package:vetassess/widgets/skills_assessment_Viewallpage.dart';
import 'package:vetassess/widgets/under_maintenance.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: VetassessApp()));
}

class VetassessApp extends StatelessWidget {
  const VetassessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
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
        GoRoute(
          path: '/application_process',
          builder: (context, state) => const ApplicationProcess(),
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

        ///APPLICATION FORMS
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
          path: '/appli_type',
          builder: (context, state) => const ApplicationTypeSelectionScreen(),
        ),
        GoRoute(
          path: '/appli_opt',
          builder: (context, state) => const AppliOptions(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VETASSESS - Skills Assessment Australia',
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Axiforma',
        useMaterial3: true,
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            // Section titles
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
            height: 1.2,
          ),
          bodyMedium: TextStyle(
            // Paragraphs
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
            height: 1.5,
          ),
          labelLarge: TextStyle(
            // Buttons
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            // Links
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.teal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
