import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/admin_screens/admin_layout.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboardData();
    });
  }

  Future<void> _loadDashboardData() async {
    await ref.read(getAllformsProviders.notifier).fetchallCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isLoading) {
      return const AdminLayout(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return AdminLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : (isTablet ? 40.0 : 80.0),
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 32),
              _buildStatsOverview(isMobile),
              const SizedBox(height: 32),
              _buildQuickActions(isMobile, screenWidth),
              const SizedBox(height: 32),
              _buildRecentActivity(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F4C75),
            Color(0xFF3282B8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.dashboard_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Admin Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Welcome to VETASSESS Administration Panel',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(bool isMobile) {
    final allFormsModel = ref.watch(getAllformsProviders);
    final userList = allFormsModel.users ?? [];

    final totalApplications = userList.length;
    final approvedCount = userList.where((user) =>
    user.applicationStatus?.toLowerCase() == 'approved').length;
    final rejectedCount = userList.where((user) =>
    user.applicationStatus?.toLowerCase() == 'rejected').length;
    final underReviewCount = userList.where((user) =>
    user.applicationStatus?.toLowerCase() == 'under review').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        isMobile
            ? Column(
          children: [
            _buildStatCard('Total Applications', totalApplications.toString(),
                Icons.assignment, const Color(0xFFFF8C42), true),
            const SizedBox(height: 12),
            _buildStatCard('Under Review', underReviewCount.toString(),
                Icons.hourglass_bottom, const Color(0xFFFF8C42), true),
            const SizedBox(height: 12),
            _buildStatCard('Approved', approvedCount.toString(),
                Icons.check_circle, const Color(0xFF4CAF50), true),
            const SizedBox(height: 12),
            _buildStatCard('Rejected', rejectedCount.toString(),
                Icons.cancel, const Color(0xFFE57373), true),
          ],
        )
            : Row(
          children: [
            Expanded(child: _buildStatCard('Total Applications', totalApplications.toString(),
                Icons.assignment, const Color(0xFFFF8C42), false)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Under Review', underReviewCount.toString(),
                Icons.hourglass_bottom, const Color(0xFFFF8C42), false)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Approved', approvedCount.toString(),
                Icons.check_circle, const Color(0xFF4CAF50), false)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Rejected', rejectedCount.toString(),
                Icons.cancel, const Color(0xFFE57373), false)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : null,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile
          ? Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isMobile, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        isMobile
            ? Column(
          children: [
            _buildActionCard(
              'Manage Users',
              'View and manage all user applications',
              Icons.people_outline,
              const Color(0xFF3282B8),
                  () => context.go('/admin/users'),
              true,
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              'Manage Categories',
              'Add, edit, or remove application categories',
              Icons.category_outlined,
              const Color(0xFF9C27B0),
                  () => context.go('/admin/categories'),
              true,
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              'Document Categories',
              'Manage document types and categories',
              Icons.folder_outlined,
              const Color(0xFF673AB7),
                  () => context.go('/admin/document-categories'),
              true,
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              'Visa & Occupations',
              'Manage visa types and occupation listings',
              Icons.work_outline,
              const Color(0xFF2E7D32),
                  () => context.go('/admin/visa-occupation'),
              true,
            ),
            const SizedBox(height: 12),
            _buildActionCard(
              'System Settings',
              'Configure application settings and preferences',
              Icons.settings_outlined,
              const Color(0xFF607D8B),
                  () => _showComingSoon(),
              true,
            ),
          ],
        )
            : screenWidth < 1200 // Adjusted breakpoint for 5 cards
            ? Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'Manage Users',
                    'View and manage all user applications',
                    Icons.people_outline,
                    const Color(0xFF3282B8),
                        () => context.go('/admin/users'),
                    false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    'Manage Categories',
                    'Add, edit, or remove application categories',
                    Icons.category_outlined,
                    const Color(0xFF9C27B0),
                        () => context.go('/admin/categories'),
                    false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'Document Categories',
                    'Manage document types and categories',
                    Icons.folder_outlined,
                    const Color(0xFF673AB7),
                        () => context.go('/admin/document-categories'),
                    false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    'Visa & Occupations',
                    'Manage visa types and occupation listings',
                    Icons.work_outline,
                    const Color(0xFF2E7D32),
                        () => context.go('/admin/visa-occupation'),
                    false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'System Settings',
                    'Configure application settings and preferences',
                    Icons.settings_outlined,
                    const Color(0xFF607D8B),
                        () => _showComingSoon(),
                    false,
                  ),
                ),
                const Expanded(child: SizedBox()), // Empty space for alignment
              ],
            ),
          ],
        )
            : Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Manage Users',
                'View and manage all user applications',
                Icons.people_outline,
                const Color(0xFF3282B8),
                    () => context.go('/admin/users'),
                false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'Manage Categories',
                'Add, edit, or remove application categories',
                Icons.category_outlined,
                const Color(0xFF9C27B0),
                    () => context.go('/admin/categories'),
                false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'Document Categories',
                'Manage document types and categories',
                Icons.folder_outlined,
                const Color(0xFF673AB7),
                    () => context.go('/admin/document-categories'),
                false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'Visa & Occupations',
                'Manage visa types and occupation listings',
                Icons.work_outline,
                const Color(0xFF2E7D32),
                    () => context.go('/admin/visa-occupation'),
                false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'System Settings',
                'Configure application settings and preferences',
                Icons.settings_outlined,
                const Color(0xFF607D8B),
                    () => _showComingSoon(),
                false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, String description, IconData icon,
      Color color, VoidCallback onTap, bool isMobile) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMobile ? double.infinity : null,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(bool isMobile) {
    final allFormsModel = ref.watch(getAllformsProviders);
    final userList = allFormsModel.users ?? [];
    final recentUsers = userList.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Applications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              if (recentUsers.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No applications yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...recentUsers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final user = entry.value;
                  final isLast = index == recentUsers.length - 1;

                  return Container(
                    decoration: BoxDecoration(
                      border: !isLast ? Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
                      ) : null,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF3282B8),
                        child: Text(
                          (user.givenNames ?? 'U')[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user.givenNames ?? 'Unknown User',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(user.email ?? 'No email'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(user.applicationStatus ?? 'pending')
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          user.applicationStatus?.toUpperCase() ?? 'PENDING',
                          style: TextStyle(
                            color: _getStatusColor(user.applicationStatus ?? 'pending'),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onTap: () => context.pushNamed('admin_user-details', extra: user),
                    ),
                  );
                }),
              if (recentUsers.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/admin/users'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3282B8),
                        side: const BorderSide(color: Color(0xFF3282B8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View All Applications'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF4CAF50);
      case 'under review':
        return const Color(0xFFFF8C42);
      case 'rejected':
        return const Color(0xFFE57373);
      default:
        return const Color(0xFF2E8B8B);
    }
  }

  void _showComingSoon() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Coming Soon'),
        content: const Text('This feature is under development and will be available soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}