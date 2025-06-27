import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

class ApplicationNav extends StatelessWidget {
  final String? currentRoute;

  const ApplicationNav({
    super.key,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    // Get current route if not provided
    final route = currentRoute ?? GoRouterState.of(context).uri.path;

    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header - Personal details
          _buildHeaderItem(
            title: 'Personal details',
            route: '/personal_form',
            currentRoute: route,
            onTap: () => context.go('/personal_form'),
          ),

          // Menu Items
          _buildMenuItem(
            'Occupation',
            route: '/occupation_form',
            currentRoute: route,
            onTap: () => context.go('/occupation_form'),
          ),
          _buildMenuItem(
            'General education',
            route: '/education_form',
            currentRoute: route,
            onTap: () => context.go('/education_form'),
          ),
          _buildMenuItem(
            'Tertiary education',
            route: '/tertiary_education_form',
            currentRoute: route,
            onTap: () => context.go('/tertiary_education_form'),
          ),
          _buildMenuItem(
            'Employment',
            route: '/employment_form',
            currentRoute: route,
            onTap: () => context.go('/employment_form'),
          ),
          _buildMenuItem(
            'Licence',
            route: '/licence_form',
            currentRoute: route,
            onTap: () => context.go('/licence_form'),
          ),
          _buildMenuItem(
            'Priority Processing',
            route: '/app_priority_form',
            currentRoute: route,
            onTap: () => context.go('/app_priority_form'),
          ),
          _buildMenuItem(
            'Documents upload',
            route: '/doc_upload',
            currentRoute: route,
            onTap: () => context.go('/doc_upload'),
          ),
          _buildMenuItem(
            'Review and confirm',
            route: '/get_all_forms',
            currentRoute: route,
            onTap: () => context.go('/get_all_forms'),
          ),
          _buildMenuItem(
            'Payment',
            route: '/cashfree_pay',
            currentRoute: route,
            onTap: () => context.go('/cashfree_pay'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderItem({
    required String title,
    required String route,
    required String currentRoute,
    required VoidCallback onTap,
  }) {
    final isActive = currentRoute == route;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          border: isActive
              ? Border.all(color: Colors.teal.shade300, width: 2)
              : null,
        ),
        child: Row(
          children: [
            if (isActive) ...[
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.black87,
                ),
              ),
            ),
            if (isActive)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      String title, {
        required String route,
        required String currentRoute,
        required VoidCallback onTap,
        bool isLast = false,
      }) {
    final isActive = currentRoute == route;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.shade50 : Colors.transparent,
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey[300]!, width: 1),
            left: isActive
                ? BorderSide(color: Colors.teal, width: 4)
                : BorderSide.none,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: isActive ? 12 : 16, // Adjust for left border
        ),
        child: Row(
          children: [
            if (isActive) ...[
              Icon(
                Icons.radio_button_checked,
                color: Colors.teal,
                size: 18,
              ),
              const SizedBox(width: 8),
            ] else ...[
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey[400],
                size: 18,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: isActive ? Colors.teal.shade700 : Colors.brown[800],
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (isActive)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.teal,
                size: 12,
              ),
          ],
        ),
      ),
    );
  }
}

// Alternative version with step completion tracking
class ApplicationNavWithProgress extends StatelessWidget {
  final String? currentRoute;
  final Set<String> completedRoutes;

  const ApplicationNavWithProgress({
    super.key,
    this.currentRoute,
    this.completedRoutes = const {},
  });

  @override
  Widget build(BuildContext context) {
    final route = currentRoute ?? GoRouterState.of(context).uri.path;

    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildProgressHeaderItem(
            title: 'Personal details',
            route: '/personal_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
            
            onTap: () => context.go('/personal_form'),
          ),

          // Menu Items
          _buildProgressMenuItem(
            'Occupation',
            route: '/occupation_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
          
            onTap: () => context.go('/occupation_form'),
          ),
          _buildProgressMenuItem(
            'General education',
            route: '/education_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
           
            onTap: () => context.go('/education_form'),
          ),
          _buildProgressMenuItem(
            'Tertiary education',
            route: '/tertiary_education_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
            
            onTap: () => context.go('/tertiary_education_form'),
          ),
          _buildProgressMenuItem(
            'Employment',
            route: '/employment_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
            
            onTap: () => context.go('/employment_form'),
          ),
          _buildProgressMenuItem(
            'Licence',
            route: '/licence_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
            
            onTap: () => context.go('/licence_form'),
          ),
          _buildProgressMenuItem(
            'Priority Processing',
            route: '/app_priority_form',
            currentRoute: route,
            completedRoutes: completedRoutes,
            
            onTap: () => context.go('/app_priority_form'),
          ),

          _buildProgressMenuItem(
            'Documents upload',
            route: '/doc_upload',
            currentRoute: route,
            completedRoutes: completedRoutes,
           
            onTap: () => context.go('/doc_upload'),
          ),
          _buildProgressMenuItem(
            'Review and confirm',
            route: '/get_all_forms',
            currentRoute: route,
            completedRoutes: completedRoutes,
           
            onTap: () => context.go('/get_all_forms'),
          ),
          _buildProgressMenuItem(
            'Payment',
            route: '/cashfree_pay',
            currentRoute: route,
            completedRoutes: completedRoutes,
           
            onTap: () => context.go('/cashfree_pay'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeaderItem({
  required String title,
  required String route,
  required String currentRoute,
  required Set<String> completedRoutes,
  required VoidCallback onTap,
}) {
  final isActive = currentRoute == route;
  final isCompleted = completedRoutes.contains(route);

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEDEDED) : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive
                    ? Colors.deepOrange
                    : Colors.brown[800],
              ),
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check, color: Colors.black87, size: 18),
        ],
      ),
    ),
  );
}


  Widget _buildProgressMenuItem(
  String title, {
  required String route,
  required String currentRoute,
  required Set<String> completedRoutes,
  required VoidCallback onTap,
  bool isLast = false,
}) {
  final isActive = currentRoute == route;
  final isCompleted = completedRoutes.contains(route);

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      color: isActive ? const Color(0xFFEDEDED) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive
                    ? Colors.deepOrange
                    : Colors.brown[800],
              ),
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check, color: Colors.black87, size: 18),
        ],
      ),
    ),
  );
}

}