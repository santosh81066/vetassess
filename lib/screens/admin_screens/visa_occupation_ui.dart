import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/screens/admin_screens/admin_layout.dart';
import 'package:vetassess/models/visa_occupation_models.dart';
import 'package:vetassess/providers/visa_occupation_providers.dart';

// Constants for visa categories and assessment types
class VisaConstants {
  static const List<String> categories = [
    'Full Skills Assessment',
    'Qualifications Only',
    'Skills Assessment Review',
    'Recognition of Prior Learning',
    'Provisional Skills Assessment',
  ];

  static const Map<String, int> assessmentTypes = {
    'Full Skills Assessment': 0,
    'Qualifications Only': 1,
  };

  static const Map<int, String> assessmentTypeLabels = {
    0: 'Full Skills Assessment',
    1: 'Qualifications Only',
  };
}

class VisaOccupationManagementScreen extends ConsumerStatefulWidget {
  const VisaOccupationManagementScreen({super.key});

  @override
  ConsumerState<VisaOccupationManagementScreen> createState() => _VisaOccupationManagementScreenState();
}

class _VisaOccupationManagementScreenState extends ConsumerState<VisaOccupationManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = '';
  bool showInactive = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AdminLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 80.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildTabNavigation(),
              const SizedBox(height: 24),
              _buildControls(isMobile),
              const SizedBox(height: 24),
              _buildTabContent(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF66BB6A),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.work_outline,
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
                  'Visa & Occupation Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage visa types and occupation listings for skills assessment',
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
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF2E7D32),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF2E7D32),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(
            icon: Icon(Icons.description_outlined),
            text: 'Visa Types',
          ),
          Tab(
            icon: Icon(Icons.work_outline),
            text: 'Occupations',
          ),
        ],
      ),
    );
  }

  Widget _buildControls(bool isMobile) {
    return Container(
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
      child: Column(
        children: [
          // Search and Add button row
          isMobile
              ? Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 12),
              _buildAddButton(true),
            ],
          )
              : Row(
            children: [
              Expanded(child: _buildSearchField()),
              const SizedBox(width: 16),
              _buildAddButton(false),
            ],
          ),

          const SizedBox(height: 16),

          // Filter toggle
          Row(
            children: [
              Switch(
                value: showInactive,
                onChanged: (value) {
                  setState(() {
                    showInactive = value;
                  });
                },
                activeColor: const Color(0xFF2E7D32),
              ),
              const SizedBox(width: 8),
              const Text(
                'Show inactive items',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: _tabController.index == 0 ? 'Search visa types...' : 'Search occupations...',
        prefixIcon: const Icon(Icons.search, color: Color(0xFF2E7D32)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildAddButton(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          _tabController.index == 0 ? 'Add Visa Type' : 'Add Occupation',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  Widget _buildTabContent(bool isMobile) {
    return SizedBox(
      height: 600,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildVisaTypesList(isMobile),
          _buildOccupationsList(isMobile),
        ],
      ),
    );
  }

  Widget _buildVisaTypesList(bool isMobile) {
    final visaTypesState = ref.watch(visaTypesProvider);
    final filteredVisaTypes = _getFilteredVisaTypes(visaTypesState.visaTypes);

    if (visaTypesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (visaTypesState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text('Error: ${visaTypesState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(visaTypesProvider.notifier).loadVisaTypes(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return _buildContentList(
      items: filteredVisaTypes,
      emptyMessage: 'No visa types found',
      itemBuilder: (visa) => _buildVisaTypeCard(visa, isMobile),
    );
  }

  Widget _buildOccupationsList(bool isMobile) {
    final occupationsState = ref.watch(occupationsProvider);
    final filteredOccupations = _getFilteredOccupations(occupationsState.occupations);

    if (occupationsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (occupationsState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text('Error: ${occupationsState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(occupationsProvider.notifier).loadOccupations(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return _buildContentList(
      items: filteredOccupations,
      emptyMessage: 'No occupations found',
      itemBuilder: (occupation) => _buildOccupationCard(occupation, isMobile),
    );
  }

  Widget _buildContentList<T>({
    required List<T> items,
    required String emptyMessage,
    required Widget Function(T) itemBuilder,
  }) {
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
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
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
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
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => itemBuilder(items[index]),
      ),
    );
  }

  Widget _buildVisaTypeCard(VisaType visa, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVisaTypeInfo(visa),
          const SizedBox(height: 16),
          _buildVisaTypeActions(visa, true),
        ],
      )
          : Row(
        children: [
          Expanded(child: _buildVisaTypeInfo(visa)),
          const SizedBox(width: 16),
          _buildVisaTypeActions(visa, false),
        ],
      ),
    );
  }

  Widget _buildVisaTypeInfo(VisaType visa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                visa.name,
                style: const TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (visa.assessmentType != null) // Only show if available
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Type ${visa.assessmentType}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (visa.assessmentType != null) const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: visa.isActive
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                visa.isActive ? 'ACTIVE' : 'INACTIVE',
                style: TextStyle(
                  color: visa.isActive ? Colors.green : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          visa.category,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Status: ${visa.status}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildVisaTypeActions(VisaType visa, bool isMobile) {
    return isMobile
        ? Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _toggleVisaStatus(visa),
            icon: Icon(
              visa.isActive ? Icons.visibility_off : Icons.visibility,
              size: 16,
            ),
            label: Text(visa.isActive ? 'Disable' : 'Enable'),
            style: OutlinedButton.styleFrom(
              foregroundColor: visa.isActive ? Colors.orange : Colors.green,
              side: BorderSide(
                color: visa.isActive ? Colors.orange : Colors.green,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showDeleteVisaDialog(visa),
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _toggleVisaStatus(visa),
          icon: Icon(
            visa.isActive ? Icons.visibility_off : Icons.visibility,
          ),
          style: IconButton.styleFrom(
            foregroundColor: visa.isActive ? Colors.orange : Colors.green,
            backgroundColor: (visa.isActive ? Colors.orange : Colors.green)
                .withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showDeleteVisaDialog(visa),
          icon: const Icon(Icons.delete_outline),
          style: IconButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOccupationCard(Occupation occupation, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOccupationInfo(occupation),
          const SizedBox(height: 16),
          _buildOccupationActions(occupation, true),
        ],
      )
          : Row(
        children: [
          Expanded(child: _buildOccupationInfo(occupation)),
          const SizedBox(width: 16),
          _buildOccupationActions(occupation, false),
        ],
      ),
    );
  }

  Widget _buildOccupationInfo(Occupation occupation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'ANZSCO ${occupation.anzscoCode}',
                style: const TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: occupation.isActive
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                occupation.isActive ? 'ACTIVE' : 'INACTIVE',
                style: TextStyle(
                  color: occupation.isActive ? Colors.green : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          occupation.occupationName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          occupation.skillsRequirement,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildOccupationActions(Occupation occupation, bool isMobile) {
    return isMobile
        ? Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showEditOccupationDialog(occupation),
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2E7D32),
              side: const BorderSide(color: Color(0xFF2E7D32)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _toggleOccupationStatus(occupation),
            icon: Icon(
              occupation.isActive ? Icons.visibility_off : Icons.visibility,
              size: 16,
            ),
            label: Text(occupation.isActive ? 'Disable' : 'Enable'),
            style: OutlinedButton.styleFrom(
              foregroundColor: occupation.isActive ? Colors.orange : Colors.green,
              side: BorderSide(
                color: occupation.isActive ? Colors.orange : Colors.green,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showDeleteOccupationDialog(occupation),
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _showEditOccupationDialog(occupation),
          icon: const Icon(Icons.edit_outlined),
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF2E7D32),
            backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _toggleOccupationStatus(occupation),
          icon: Icon(
            occupation.isActive ? Icons.visibility_off : Icons.visibility,
          ),
          style: IconButton.styleFrom(
            foregroundColor: occupation.isActive ? Colors.orange : Colors.green,
            backgroundColor: (occupation.isActive ? Colors.orange : Colors.green)
                .withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showDeleteOccupationDialog(occupation),
          icon: const Icon(Icons.delete_outline),
          style: IconButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  List<VisaType> _getFilteredVisaTypes(List<VisaType> visaTypes) {
    return visaTypes.where((visa) {
      final matchesSearch = searchQuery.isEmpty ||
          visa.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          visa.category.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus = showInactive || visa.isActive;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  List<Occupation> _getFilteredOccupations(List<Occupation> occupations) {
    return occupations.where((occupation) {
      final matchesSearch = searchQuery.isEmpty ||
          occupation.occupationName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          occupation.anzscoCode.toLowerCase().contains(searchQuery.toLowerCase()) ||
          occupation.skillsRequirement.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesStatus = showInactive || occupation.isActive;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _showAddDialog() {
    if (_tabController.index == 0) {
      _showVisaDialog();
    } else {
      _showOccupationDialog();
    }
  }

  void _showEditOccupationDialog(Occupation occupation) {
    _showOccupationDialog(occupation);
  }

  void _showVisaDialog([VisaType? visa]) {
    final isEditing = visa != null;

    // Use dropdown for category instead of text controller
    String selectedCategory = visa?.category ?? VisaConstants.categories.first;

    // Use dropdown for assessment type instead of text controller
    String selectedAssessmentType = visa?.assessmentType != null
        ? VisaConstants.assessmentTypeLabels[visa!.assessmentType] ?? VisaConstants.assessmentTypeLabels.values.first
        : VisaConstants.assessmentTypeLabels.values.first;

    final visaNameController = TextEditingController(text: visa?.name ?? '');
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEditing ? 'Edit Visa Type' : 'Add New Visa Type',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category Dropdown
             /*   DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category *',
                    prefixIcon: const Icon(Icons.category, color: Color(0xFF2E7D32)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  dropdownColor: Colors.white,
                  items: VisaConstants.categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setDialogState(() {
                        selectedCategory = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),*/
                const SizedBox(height: 16),

                // Assessment Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedAssessmentType,
                  decoration: InputDecoration(
                    labelText: 'Assessment Type *',
                    prefixIcon: const Icon(Icons.assessment, color: Color(0xFF2E7D32)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  dropdownColor: Colors.white,
                  items: VisaConstants.assessmentTypes.keys.map((String assessmentType) {
                    return DropdownMenuItem<String>(
                      value: assessmentType,
                      child: Text(
                        assessmentType,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setDialogState(() {
                        selectedAssessmentType = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an assessment type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Visa Name Field
                TextField(
                  controller: visaNameController,
                  decoration: InputDecoration(
                    labelText: 'Visa Name *',
                    hintText: 'e.g., SA1',
                    prefixIcon: const Icon(Icons.description, color: Color(0xFF2E7D32)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                if (selectedCategory.isEmpty ||
                    visaNameController.text.trim().isEmpty ||
                    selectedAssessmentType.isEmpty) {
                  _showSnackBar('Please fill in all required fields', Colors.red);
                  return;
                }

                setDialogState(() {
                  isLoading = true;
                });

                try {
                  final success = await ref.read(visaTypesProvider.notifier).addVisaTypes(
                    category: selectedCategory, // Use selected category instead of text input
                    assessmentType: VisaConstants.assessmentTypes[selectedAssessmentType] ?? 0, // Use mapped assessment type value
                    visaNames: [visaNameController.text.trim()],
                  );

                  if (success) {
                    Navigator.pop(context);
                    _showSnackBar('Visa type added successfully', Colors.green);
                  } else {
                    _showSnackBar('Failed to add visa type', Colors.red);
                  }
                } catch (e) {
                  _showSnackBar('Error: ${e.toString()}', Colors.red);
                } finally {
                  setDialogState(() {
                    isLoading = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : Text(
                isEditing ? 'Update' : 'Add',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOccupationDialog([Occupation? occupation]) {
    final isEditing = occupation != null;
    final occupationNameController = TextEditingController(text: occupation?.occupationName ?? '');
    final anzscoCodeController = TextEditingController(text: occupation?.anzscoCode ?? '');
    final skillsRequirementController = TextEditingController(text: occupation?.skillsRequirement ?? '');
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEditing ? 'Edit Occupation' : 'Add New Occupation',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: occupationNameController,
                    decoration: InputDecoration(
                      labelText: 'Occupation Name *',
                      hintText: 'e.g., Actor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: anzscoCodeController,
                    decoration: InputDecoration(
                      labelText: 'ANZSCO Code *',
                      hintText: 'e.g., 211111',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: skillsRequirementController,
                    decoration: InputDecoration(
                      labelText: 'Skills Requirement *',
                      hintText: 'e.g., Training in performing arts...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                if (occupationNameController.text.trim().isEmpty ||
                    anzscoCodeController.text.trim().isEmpty ||
                    skillsRequirementController.text.trim().isEmpty) {
                  _showSnackBar('Please fill in all required fields', Colors.red);
                  return;
                }

                setDialogState(() {
                  isLoading = true;
                });

                try {
                  if (isEditing) {
                    // Update existing occupation
                    final updatedOccupation = occupation!.copyWith(
                      occupationName: occupationNameController.text.trim(),
                      anzscoCode: anzscoCodeController.text.trim(),
                      skillsRequirement: skillsRequirementController.text.trim(),
                    );
                    ref.read(occupationsProvider.notifier).updateOccupation(updatedOccupation);
                    Navigator.pop(context);
                    _showSnackBar('Occupation updated successfully', Colors.green);
                  } else {
                    // Add new occupation
                    final success = await ref.read(occupationsProvider.notifier).addSingleOccupation(
                      occupationName: occupationNameController.text.trim(),
                      anzscoCode: anzscoCodeController.text.trim(),
                      skillsRequirement: skillsRequirementController.text.trim(),
                    );

                    if (success) {
                      Navigator.pop(context);
                      _showSnackBar('Occupation added successfully', Colors.green);
                    } else {
                      _showSnackBar('Failed to add occupation', Colors.red);
                    }
                  }
                } catch (e) {
                  _showSnackBar('Error: ${e.toString()}', Colors.red);
                } finally {
                  setDialogState(() {
                    isLoading = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : Text(
                isEditing ? 'Update' : 'Add',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleVisaStatus(VisaType visa) {
    ref.read(visaTypesProvider.notifier).toggleVisaStatus(visa.id!);
    _showSnackBar(
      'Visa type ${visa.isActive ? 'disabled' : 'enabled'} successfully',
      Colors.green,
    );
  }

  void _toggleOccupationStatus(Occupation occupation) {
    ref.read(occupationsProvider.notifier).toggleOccupationStatus(occupation.id!);
    _showSnackBar(
      'Occupation ${occupation.isActive ? 'disabled' : 'enabled'} successfully',
      Colors.green,
    );
  }

  void _showDeleteVisaDialog(VisaType visa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Visa Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete "${visa.name}" from ${visa.category}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(visaTypesProvider.notifier).deleteVisaType(visa.id!);
              Navigator.pop(context);
              _showSnackBar('Visa type deleted successfully', Colors.green);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteOccupationDialog(Occupation occupation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Occupation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete "${occupation.occupationName}" (${occupation.anzscoCode})? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(occupationsProvider.notifier).deleteOccupation(occupation.id!);
              Navigator.pop(context);
              _showSnackBar('Occupation deleted successfully', Colors.green);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}