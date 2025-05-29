import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: Color(0xFF00565B),
              height: screenHeight * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Skills Assessment Applications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 0,
                    ),
                    child: Text(
                      'Manage and review professional migration applications',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: isMobile ? 16 : 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Content with responsive horizontal padding
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 100.0,
              ),
              child: Column(
                children: [
                  // Stats Cards
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        isMobile
                            ? Column(
                              children: [
                                _buildStatCard(
                                  'Total Applications',
                                  '156',
                                  Icons.assignment,
                                  const Color(0xFFFF8C42),
                                  isMobile,
                                ),
                                const SizedBox(height: 12),
                                _buildStatCard(
                                  'Under Review',
                                  '23',
                                  Icons.pending,
                                  Colors.redAccent.shade100,
                                  isMobile,
                                ),
                                const SizedBox(height: 12),
                                _buildStatCard(
                                  'Approved',
                                  '98',
                                  Icons.check_circle,
                                  const Color(0xFF2E8B8B),
                                  isMobile,
                                ),
                              ],
                            )
                            : Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    'Total Applications',
                                    '156',
                                    Icons.assignment,
                                    const Color(0xFFFF8C42),
                                    isMobile,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    'Under Review',
                                    '23',
                                    Icons.pending,
                                    Colors.redAccent.shade100,
                                    isMobile,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    'Approved',
                                    '98',
                                    Icons.check_circle,
                                    const Color(0xFF2E8B8B),
                                    isMobile,
                                  ),
                                ),
                              ],
                            ),
                  ),

                  // Users List
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : 16.0,
                    ),
                    child: Column(
                      children:
                          _getUsers()
                              .map(
                                (user) =>
                                    _buildUserCard(context, user, isMobile),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isMobile,
  ) {
    return Container(
      width: isMobile ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child:
          isMobile
              ? Row(
                children: [
                  Icon(icon, color: color, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  Icon(icon, color: color, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
    );
  }

  Widget _buildUserCard(
    BuildContext context,
    Map<String, dynamic> user,
    bool isMobile,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(isMobile ? 12 : 16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2E8B8B),
          radius: isMobile ? 20 : 25,
          child: Text(
            user['name'][0].toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 16 : 18,
            ),
          ),
        ),
        title: Text(
          user['name'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user['occupation'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isMobile ? 12 : 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    user['email'],
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: isMobile ? 10 : 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 6 : 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(user['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user['status'],
                style: TextStyle(
                  color: _getStatusColor(user['status']),
                  fontSize: isMobile ? 10 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
        onTap: () {
          // Using GoRouter navigation
          context.pushNamed('admin_user-details', extra: user);
        },
      ),
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

  List<Map<String, dynamic>> _getUsers() {
    return [
      {
        'name': 'John Smith',
        'occupation': 'Software Engineer',
        'email': 'john.smith@email.com',
        'status': 'Under Review',
        'applicationId': 'APP001',
        'submissionDate': '2024-05-15',
        'experience': '5 years',
        'qualification': 'Bachelor of Computer Science',
        'documents': [
          'Resume',
          'Educational Certificates',
          'Work Experience Letters',
        ],
      },
      {
        'name': 'Sarah Johnson',
        'occupation': 'Registered Nurse',
        'email': 'sarah.j@email.com',
        'status': 'Approved',
        'applicationId': 'APP002',
        'submissionDate': '2024-05-10',
        'experience': '8 years',
        'qualification': 'Bachelor of Nursing',
        'documents': ['Resume', 'Nursing Registration', 'Experience Letters'],
      },
      {
        'name': 'Michael Chen',
        'occupation': 'Civil Engineer',
        'email': 'mchen@email.com',
        'status': 'Under Review',
        'applicationId': 'APP003',
        'submissionDate': '2024-05-20',
        'experience': '6 years',
        'qualification': 'Master of Civil Engineering',
        'documents': ['Resume', 'Degree Certificates', 'Project Portfolio'],
      },
      {
        'name': 'Emma Wilson',
        'occupation': 'Accountant',
        'email': 'emma.wilson@email.com',
        'status': 'Approved',
        'applicationId': 'APP004',
        'submissionDate': '2024-05-12',
        'experience': '4 years',
        'qualification': 'CPA Certification',
        'documents': ['Resume', 'CPA Certificate', 'Work References'],
      },
      {
        'name': 'David Brown',
        'occupation': 'Marketing Manager',
        'email': 'david.brown@email.com',
        'status': 'Rejected',
        'applicationId': 'APP005',
        'submissionDate': '2024-05-08',
        'experience': '3 years',
        'qualification': 'MBA Marketing',
        'documents': ['Resume', 'MBA Certificate', 'Portfolio'],
      },
    ];
  }
}
