import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/screens/admin_screens/admin_layout.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends ConsumerState<UsersListScreen> {
  bool isLoading = true;
  String? selectedFilter; // null = show all, 'approved', 'rejected'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchformsCategories();
    });
  }

  Future<void> _fetchformsCategories() async {
    await ref.read(getAllformsProviders.notifier).fetchallCategories();
    setState(() {
      isLoading = false;
    });
  }

  void _applyFilter(String? filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  List<Users> _getFilteredUsers(List<Users> userList) {
    if (selectedFilter == null) {
      return userList;
    }

    return userList.where((user) =>
    user.applicationStatus?.toLowerCase() == selectedFilter!.toLowerCase()
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allFormsModel = ref.watch(getAllformsProviders);
    final userList = allFormsModel.users ?? [];
    final filteredUserList = _getFilteredUsers(userList);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final totalApplications = userList.length;
    final approvedCount = userList.where((user) => user.applicationStatus?.toLowerCase() == 'approved').length;
    final rejectedCount = userList.where((user) => user.applicationStatus?.toLowerCase() == 'rejected').length;
    final underReviewCount = userList.where((user) => user.applicationStatus?.toLowerCase() == 'under review').length;

    return AdminLayout(
      child: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            // Content with responsive horizontal padding
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 100.0,
              ),
              child: Column(
                children: [
                  // Filter Indicator
                  if (selectedFilter != null)
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(selectedFilter!).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getStatusColor(selectedFilter!).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            selectedFilter == 'approved' ? Icons.check_circle : Icons.cancel,
                            color: _getStatusColor(selectedFilter!),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Showing ${selectedFilter!.toUpperCase()} applications',
                            style: TextStyle(
                              color: _getStatusColor(selectedFilter!),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _applyFilter(null),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(selectedFilter!),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Stats Cards
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isMobile
                        ? Column(
                      children: [
                        _buildStatCard(
                          'Total Applications',
                          '$totalApplications',
                          Icons.assignment,
                          const Color(0xFFFF8C42),
                          isMobile,
                          isSelected: selectedFilter == null,
                          onTap: () => _applyFilter(null),
                        ),
                        const SizedBox(height: 12),
                        _buildStatCard(
                          'Rejected',
                          '$rejectedCount',
                          Icons.cancel,
                          Colors.redAccent,
                          isMobile,
                          isSelected: selectedFilter == 'rejected',
                          onTap: () => _applyFilter('rejected'),
                        ),
                        const SizedBox(height: 12),
                        _buildStatCard(
                          'Approved',
                          '$approvedCount',
                          Icons.check_circle,
                          const Color(0xFF2E8B8B),
                          isMobile,
                          isSelected: selectedFilter == 'approved',
                          onTap: () => _applyFilter('approved'),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total Applications',
                            '$totalApplications',
                            Icons.assignment,
                            const Color(0xFFFF8C42),
                            isMobile,
                            isSelected: selectedFilter == null,
                            onTap: () => _applyFilter(null),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            'Rejected',
                            '$rejectedCount',
                            Icons.cancel,
                            Colors.redAccent,
                            isMobile,
                            isSelected: selectedFilter == 'rejected',
                            onTap: () => _applyFilter('rejected'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            'Approved',
                            '$approvedCount',
                            Icons.check_circle,
                            const Color(0xFF2E8B8B),
                            isMobile,
                            isSelected: selectedFilter == 'approved',
                            onTap: () => _applyFilter('approved'),
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
                      children: filteredUserList.isEmpty && selectedFilter != null
                          ? [
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(
                                selectedFilter == 'approved' ? Icons.check_circle_outline : Icons.cancel_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No ${selectedFilter!} applications found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                          : filteredUserList.map(
                            (user) => _buildUserCardFromModel(context, user, isMobile),
                      ).toList(),
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
      bool isMobile, {
        bool isSelected = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isMobile ? double.infinity : null,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: isSelected ? 2 : 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isMobile
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
            if (isSelected)
              Icon(
                Icons.check,
                color: color,
                size: 20,
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
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.check,
                  color: color,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCardFromModel(
      BuildContext context,
      Users user,
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
            (user.givenNames ?? 'U')[0].toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 16 : 18,
            ),
          ),
        ),
        title: Text(
          '${user.givenNames ?? ''} ${user.surname ?? ''}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    user.email ?? 'N/A',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: isMobile ? 10 : 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Show application status if available
            if (user.applicationStatus != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(user.applicationStatus!).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  user.applicationStatus!.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(user.applicationStatus!),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
        onTap: () {
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
}