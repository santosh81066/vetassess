import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/document_category_modal.dart';
import '../../providers/document_category_provider.dart';
import 'admin_layout.dart';


class DocumentManagementScreen extends ConsumerStatefulWidget {
  const DocumentManagementScreen({super.key});

  @override
  ConsumerState<DocumentManagementScreen> createState() => _DocumentManagementScreenState();
}

class _DocumentManagementScreenState extends ConsumerState<DocumentManagementScreen>
    with SingleTickerProviderStateMixin {

  // Tab controller for switching between categories and types
  late TabController _tabController;

  // Search controllers
  final TextEditingController _categorySearchController = TextEditingController();
  final TextEditingController _typeSearchController = TextEditingController();

  // State variables
  bool _isRefreshing = false;
  bool _showCategoryHierarchyView = true;
  bool _showTypeGroupedView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch both categories and types
      ref.read(documentManagementProvider.notifier).fetchAllData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _categorySearchController.dispose();
    _typeSearchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await ref.read(documentManagementProvider.notifier).refresh();
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AdminLayout(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 40.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isMobile),
                const SizedBox(height: 24),
                _buildTabBar(isMobile),
                const SizedBox(height: 24),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildCategoriesTab(isMobile),
                      _buildTypesTab(isMobile),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    final state = ref.watch(documentManagementProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6A1B9A),
            Color(0xFF8E24AA),
            Color(0xFF2E7D32),
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
              Icons.admin_panel_settings,
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
                  'Document Management',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${state.categories.length} categories • ${state.documentTypes.length} types',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (_isRefreshing)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isMobile) {
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
          gradient: const LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2E7D32)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(
            icon: Icon(Icons.folder_outlined),
            text: 'Categories',
          ),
          Tab(
            icon: Icon(Icons.description_outlined),
            text: 'Types',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(bool isMobile) {
    final state = ref.watch(documentManagementProvider);
    final filteredCategories = ref.watch(filteredCategoriesProvider);

    return Column(
      children: [
        if (state.error != null)
          _buildErrorBanner(state.error!, true),
        _buildCategoryControls(isMobile),
        const SizedBox(height: 24),
        Expanded(
          child: state.isLoading && !_isRefreshing
              ? _buildLoadingIndicator('Loading categories...')
              : _showCategoryHierarchyView
              ? _buildCategoryHierarchyView(state.categoriesHierarchy, isMobile)
              : _buildCategoryFlatList(filteredCategories, isMobile),
        ),
      ],
    );
  }

  Widget _buildTypesTab(bool isMobile) {
    final state = ref.watch(documentManagementProvider);
    final filteredTypes = ref.watch(filteredDocumentTypesProvider);

    return Column(
      children: [
        if (state.error != null)
          _buildErrorBanner(state.error!, false),
        _buildTypeControls(isMobile),
        const SizedBox(height: 24),
        Expanded(
          child: state.isLoading && !_isRefreshing
              ? _buildLoadingIndicator('Loading document types...')
              : _showTypeGroupedView
              ? _buildTypeGroupedView(state.typesByCategory, isMobile)
              : _buildTypeFlatList(filteredTypes, isMobile),
        ),
      ],
    );
  }

  Widget _buildErrorBanner(String error, bool isCategory) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: Colors.red.shade800),
            ),
          ),
          IconButton(
            onPressed: () => ref.read(documentManagementProvider.notifier).clearError(),
            icon: Icon(Icons.close, color: Colors.red.shade600, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryControls(bool isMobile) {
    return isMobile
        ? Column(
      children: [
        _buildCategorySearchField(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCategoryViewToggle()),
            const SizedBox(width: 12),
            Expanded(child: _buildAddCategoryButton()),
          ],
        ),
      ],
    )
        : Row(
      children: [
        Expanded(child: _buildCategorySearchField()),
        const SizedBox(width: 16),
        _buildCategoryViewToggle(),
        const SizedBox(width: 16),
        _buildAddCategoryButton(),
      ],
    );
  }

  Widget _buildTypeControls(bool isMobile) {
    return isMobile
        ? Column(
      children: [
        _buildTypeSearchField(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTypeViewToggle()),
            const SizedBox(width: 12),
            Expanded(child: _buildAddTypeButton()),
          ],
        ),
      ],
    )
        : Row(
      children: [
        Expanded(child: _buildTypeSearchField()),
        const SizedBox(width: 16),
        _buildTypeViewToggle(),
        const SizedBox(width: 16),
        _buildAddTypeButton(),
      ],
    );
  }

  Widget _buildCategorySearchField() {
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
      child: TextField(
        controller: _categorySearchController,
        onChanged: (value) {
          ref.read(categorySearchProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: 'Search categories...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _categorySearchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _categorySearchController.clear();
              ref.read(categorySearchProvider.notifier).state = '';
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildTypeSearchField() {
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
      child: TextField(
        controller: _typeSearchController,
        onChanged: (value) {
          ref.read(documentTypeSearchProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: 'Search document types...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _typeSearchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _typeSearchController.clear();
              ref.read(documentTypeSearchProvider.notifier).state = '';
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCategoryViewToggle() {
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
      child: ToggleButtons(
        isSelected: [_showCategoryHierarchyView, !_showCategoryHierarchyView],
        onPressed: (index) {
          setState(() {
            _showCategoryHierarchyView = index == 0;
          });
        },
        borderRadius: BorderRadius.circular(12),
        selectedColor: Colors.white,
        fillColor: const Color(0xFF9C27B0),
        color: Colors.grey[600],
        constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
        children: const [
          Tooltip(
            message: 'Hierarchy View',
            child: Icon(Icons.account_tree),
          ),
          Tooltip(
            message: 'Flat View',
            child: Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeViewToggle() {
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
      child: ToggleButtons(
        isSelected: [_showTypeGroupedView, !_showTypeGroupedView],
        onPressed: (index) {
          setState(() {
            _showTypeGroupedView = index == 0;
          });
        },
        borderRadius: BorderRadius.circular(12),
        selectedColor: Colors.white,
        fillColor: const Color(0xFF2E7D32),
        color: Colors.grey[600],
        constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
        children: const [
          Tooltip(
            message: 'Grouped View',
            child: Icon(Icons.folder_open),
          ),
          Tooltip(
            message: 'Flat View',
            child: Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCategoryButton() {
    return ElevatedButton.icon(
      onPressed: () => _showAddCategoryDialog(),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Add Category', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9C27B0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildAddTypeButton() {
    return ElevatedButton.icon(
      onPressed: () => _showAddDocumentTypeDialog(),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Add Type', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D32),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildLoadingIndicator(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category-specific build methods
  Widget _buildCategoryHierarchyView(Map<DocumentCategory, List<DocumentCategory>> hierarchy, bool isMobile) {
    if (hierarchy.isEmpty) {
      return _buildEmptyState(true);
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
      child: Column(
        children: [
          if (!isMobile) _buildCategoryHierarchyTableHeader(),
          Expanded(
            child: ListView(
              children: hierarchy.entries.expand((entry) {
                final mainCategory = entry.key;
                final subCategories = entry.value;

                return [
                  _buildMainCategoryItem(mainCategory, isMobile),
                  ...subCategories.map((subCategory) =>
                      _buildSubCategoryItem(subCategory, isMobile)
                  ),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFlatList(List<DocumentCategory> categories, bool isMobile) {
    if (categories.isEmpty) {
      return _buildEmptyState(true);
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
      child: Column(
        children: [
          if (!isMobile) _buildCategoryTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isLast = index == categories.length - 1;
                return _buildCategoryItem(category, isLast, isMobile);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Type-specific build methods
  Widget _buildTypeGroupedView(Map<DocumentCategory, List<DocumentType>> groupedTypes, bool isMobile) {
    if (groupedTypes.isEmpty) {
      return _buildEmptyState(false);
    }

    return ListView(
      children: groupedTypes.entries.map((entry) {
        final category = entry.key;
        final types = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
              _buildCategoryHeader(category, types.length),
              ...types.asMap().entries.map((typeEntry) {
                final index = typeEntry.key;
                final type = typeEntry.value;
                final isLast = index == types.length - 1;

                return _buildDocumentTypeItem(type, isLast, isMobile, isGrouped: true);
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypeFlatList(List<DocumentType> types, bool isMobile) {
    if (types.isEmpty) {
      return _buildEmptyState(false);
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
      child: Column(
        children: [
          if (!isMobile) _buildTypeTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                final type = types[index];
                final isLast = index == types.length - 1;
                return _buildDocumentTypeItem(type, isLast, isMobile);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isCategory) {
    final searchQuery = isCategory
        ? ref.watch(categorySearchProvider)
        : ref.watch(documentTypeSearchProvider);

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            searchQuery.isNotEmpty
                ? Icons.search_off
                : (isCategory ? Icons.folder_open_outlined : Icons.description_outlined),
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? 'No ${isCategory ? "categories" : "types"} found'
                : 'No ${isCategory ? "categories" : "document types"} yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty
                ? 'Try adjusting your search terms'
                : 'Add your first ${isCategory ? "category" : "document type"} to get started',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          if (searchQuery.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => isCategory
                  ? _showAddCategoryDialog()
                  : _showAddDocumentTypeDialog(),
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'Add ${isCategory ? "Category" : "Document Type"}',
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCategory
                    ? const Color(0xFF9C27B0)
                    : const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Category-specific item builders
  Widget _buildCategoryHierarchyTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 40), // Space for hierarchy indicator
          Expanded(
            flex: 3,
            child: Text(
              'Category Hierarchy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Created Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Actions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Category Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Created Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Actions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCategoryItem(DocumentCategory category, bool isMobile) {
    final notifier = ref.read(documentManagementProvider.notifier);
    final canDelete = notifier.canDeleteCategory(category.id);

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
          color: Colors.blue.shade50.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.folder,
                  color: Color(0xFF1976D2),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.documentCategory,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ),
                _buildCategoryActionButtons(category, canDelete),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Main Category',
                    style: TextStyle(
                      color: Color(0xFF1976D2),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Created: ${_formatDate(category.createdAt)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    // Desktop version
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        ),
        color: Colors.blue.shade50.withOpacity(0.3),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 40,
            child: Icon(
              Icons.folder,
              color: Color(0xFF1976D2),
              size: 20,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              category.documentCategory,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF1976D2),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Main',
                style: TextStyle(
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(category.createdAt),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          SizedBox(
            width: 100,
            child: _buildCategoryActionButtons(category, canDelete),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryItem(DocumentCategory category, bool isMobile) {
    final notifier = ref.read(documentManagementProvider.notifier);
    final canDelete = notifier.canDeleteCategory(category.id);

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.fromLTRB(32, 16, 16, 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.subdirectory_arrow_right,
                  color: Color(0xFF9C27B0),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.documentCategory,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                _buildCategoryActionButtons(category, canDelete),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9C27B0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Sub of ${category.parentCategoryName}',
                    style: const TextStyle(
                      color: Color(0xFF9C27B0),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Created: ${_formatDate(category.createdAt)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    // Desktop version
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 40,
            child: Icon(
              Icons.subdirectory_arrow_right,
              color: Color(0xFF9C27B0),
              size: 18,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              category.documentCategory,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Sub',
                style: TextStyle(
                  color: Color(0xFF9C27B0),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(category.createdAt),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          SizedBox(
            width: 100,
            child: _buildCategoryActionButtons(category, canDelete),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(DocumentCategory category, bool isLast, bool isMobile) {
    final notifier = ref.read(documentManagementProvider.notifier);
    final canDelete = notifier.canDeleteCategory(category.id);

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        category.isMainCategory ? Icons.folder : Icons.subdirectory_arrow_right,
                        color: category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          category.fullCategoryPath,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: category.isMainCategory ? const Color(0xFF1976D2) : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildCategoryActionButtons(category, canDelete),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0)).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category.isMainCategory ? 'Main Category' : 'Subcategory',
                    style: TextStyle(
                      color: category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Created: ${_formatDate(category.createdAt)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(
                  category.isMainCategory ? Icons.folder : Icons.subdirectory_arrow_right,
                  color: category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.fullCategoryPath,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: category.isMainCategory ? const Color(0xFF1976D2) : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                category.isMainCategory ? 'Main' : 'Sub',
                style: TextStyle(
                  color: category.isMainCategory ? const Color(0xFF1976D2) : const Color(0xFF9C27B0),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(category.createdAt),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          SizedBox(
            width: 100,
            child: _buildCategoryActionButtons(category, canDelete),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryActionButtons(DocumentCategory category, bool canDelete) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 20),
          onPressed: () => _showEditCategoryDialog(category),
          tooltip: 'Edit',
          color: const Color(0xFF3282B8),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: 20,
            color: canDelete ? Colors.red.shade400 : Colors.grey.shade400,
          ),
          onPressed: canDelete ? () => _showDeleteCategoryConfirmation(category) : null,
          tooltip: canDelete ? 'Delete' : 'Cannot delete - has subcategories',
        ),
      ],
    );
  }

  // Type-specific item builders
  Widget _buildTypeTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Document Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Created Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'Actions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(DocumentCategory category, int typeCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.folder,
              color: Color(0xFF2E7D32),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category.documentCategory,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$typeCount ${typeCount == 1 ? 'type' : 'types'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTypeItem(DocumentType type, bool isLast, bool isMobile, {bool isGrouped = false}) {
    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.description,
                        color: Color(0xFF2E7D32),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          type.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTypeActionButtons(type),
              ],
            ),
            if (!isGrouped) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  type.categoryName,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              'Created: ${_formatDate(type.createdAt)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const Icon(
                  Icons.description,
                  color: Color(0xFF2E7D32),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    type.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          if (!isGrouped)
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  type.categoryName,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            const Expanded(flex: 2, child: SizedBox()), // Spacer for grouped view
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(type.createdAt),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          SizedBox(
            width: 100,
            child: _buildTypeActionButtons(type),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeActionButtons(DocumentType type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 20),
          onPressed: () => _showEditDocumentTypeDialog(type),
          tooltip: 'Edit',
          color: const Color(0xFF3282B8),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: 20),
          onPressed: () => _showDeleteTypeConfirmation(type),
          tooltip: 'Delete',
          color: Colors.red.shade400,
        ),
      ],
    );
  }

  // Dialog methods
  void _showAddCategoryDialog() {
    final formKey = GlobalKey<FormState>();
    final categoryController = TextEditingController();
    DocumentCategory? selectedParent;
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final mainCategories = ref.read(mainCategoriesProvider);

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Add Document Category'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: categoryController,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a category name';
                      }
                      if (value.trim().length < 2) {
                        return 'Category name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<DocumentCategory?>(
                    value: selectedParent,
                    decoration: InputDecoration(
                      hintText: 'Select parent category (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      const DropdownMenuItem<DocumentCategory?>(
                        value: null,
                        child: Text('Main Category (no parent)'),
                      ),
                      ...mainCategories.map((category) =>
                          DropdownMenuItem<DocumentCategory?>(
                            value: category,
                            child: Text('Sub of: ${category.documentCategory}'),
                          ),
                      ),
                    ],
                    onChanged: isSubmitting ? null : (value) {
                      setState(() {
                        selectedParent = value;
                      });
                    },
                  ),
                  if (selectedParent != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'This will create a subcategory under "${selectedParent!.documentCategory}"',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });

                    final success = await ref
                        .read(documentManagementProvider.notifier)
                        .addDocumentCategory(
                      categoryName: categoryController.text.trim(),
                      parentCategoryId: selectedParent?.id,
                    );

                    if (success && mounted) {
                      Navigator.pop(context);
                      _showSuccessSnackBar(
                          selectedParent != null
                              ? 'Subcategory added successfully'
                              : 'Main category added successfully'
                      );
                    } else {
                      setState(() {
                        isSubmitting = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditCategoryDialog(DocumentCategory category) {
    final formKey = GlobalKey<FormState>();
    final categoryController = TextEditingController(text: category.documentCategory);
    DocumentCategory? selectedParent = category.parentCategory != null
        ? ref.read(documentManagementProvider.notifier).getCategoryById(category.subtype)
        : null;
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final mainCategories = ref.read(mainCategoriesProvider)
              .where((cat) => cat.id != category.id)
              .toList();

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Edit Document Category'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: categoryController,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a category name';
                      }
                      if (value.trim().length < 2) {
                        return 'Category name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<DocumentCategory?>(
                    value: selectedParent,
                    decoration: InputDecoration(
                      hintText: 'Select parent category (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: [
                      const DropdownMenuItem<DocumentCategory?>(
                        value: null,
                        child: Text('Main Category (no parent)'),
                      ),
                      ...mainCategories.map((cat) =>
                          DropdownMenuItem<DocumentCategory?>(
                            value: cat,
                            child: Text('Sub of: ${cat.documentCategory}'),
                          ),
                      ),
                    ],
                    onChanged: isSubmitting ? null : (value) {
                      setState(() {
                        selectedParent = value;
                      });
                    },
                  ),
                  if (selectedParent != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'This will make it a subcategory under "${selectedParent!.documentCategory}"',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });

                    final success = await ref
                        .read(documentManagementProvider.notifier)
                        .updateDocumentCategory(
                      id: category.id,
                      categoryName: categoryController.text.trim(),
                      parentCategoryId: selectedParent?.id,
                    );

                    if (success && mounted) {
                      Navigator.pop(context);
                      _showSuccessSnackBar('Document category updated successfully');
                    } else {
                      setState(() {
                        isSubmitting = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3282B8),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text('Update'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteCategoryConfirmation(DocumentCategory category) {
    final notifier = ref.read(documentManagementProvider.notifier);
    final subCategories = notifier.searchCategories('').where((cat) => cat.subtype == category.id).toList();

    if (subCategories.isNotEmpty) {
      _showCannotDeleteDialog(category, subCategories);
      return;
    }

    bool isDeleting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Document Category'),
          content: Text(
            'Are you sure you want to delete "${category.documentCategory}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: isDeleting ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isDeleting
                  ? null
                  : () async {
                setState(() {
                  isDeleting = true;
                });

                final success = await ref
                    .read(documentManagementProvider.notifier)
                    .deleteDocumentCategory(category.id);

                if (success && mounted) {
                  Navigator.pop(context);
                  _showSuccessSnackBar('Document category deleted successfully');
                } else {
                  setState(() {
                    isDeleting = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: isDeleting
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCannotDeleteDialog(DocumentCategory category, List<DocumentCategory> subCategories) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cannot Delete Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cannot delete "${category.documentCategory}" because it has the following subcategories:'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subCategories.map((subCategory) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.subdirectory_arrow_right, size: 16),
                          const SizedBox(width: 8),
                          Text(subCategory.documentCategory),
                        ],
                      ),
                    ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Please delete all subcategories first, then try again.'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9C27B0),
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAddDocumentTypeDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    DocumentCategory? selectedCategory;
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final availableCategories = ref.read(availableCategoriesProvider);

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Add Document Type'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      labelText: 'Document Type Name',
                      hintText: 'e.g., Passport, License, Certificate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.description),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a document type name';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<DocumentCategory>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Document Category',
                      hintText: 'Select a category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.folder),
                    ),
                    items: availableCategories
                        .map((category) => DropdownMenuItem<DocumentCategory>(
                      value: category,
                      child: Text(category.documentCategory),
                    ))
                        .toList(),
                    onChanged: isSubmitting
                        ? null
                        : (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a document category';
                      }
                      return null;
                    },
                  ),
                  if (selectedCategory != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: Colors.green.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'This type will be added to "${selectedCategory!.documentCategory}" category',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });

                    try {
                      final success = await ref
                          .read(documentManagementProvider.notifier)
                          .addDocumentType(
                        name: nameController.text.trim(),
                        docCategoryId: selectedCategory!.id,
                      );

                      if (success && mounted) {
                        Navigator.pop(context);
                        _showSuccessSnackBar('Document type added successfully');
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          isSubmitting = false;
                        });
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditDocumentTypeDialog(DocumentType type) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: type.name);
    DocumentCategory? selectedCategory = ref.read(documentManagementProvider.notifier).getCategoryById(type.docCategoryId);
    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final availableCategories = ref.read(availableCategoriesProvider);

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Edit Document Type'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      labelText: 'Document Type Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.description),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a document type name';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<DocumentCategory>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Document Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.folder),
                    ),
                    items: availableCategories
                        .map((category) => DropdownMenuItem<DocumentCategory>(
                      value: category,
                      child: Text(category.documentCategory),
                    ))
                        .toList(),
                    onChanged: isSubmitting
                        ? null
                        : (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a document category';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });

                    try {
                      final success = await ref
                          .read(documentManagementProvider.notifier)
                          .updateDocumentType(
                        id: type.id,
                        name: nameController.text.trim(),
                        docCategoryId: selectedCategory!.id,
                      );

                      if (success && mounted) {
                        Navigator.pop(context);
                        _showSuccessSnackBar('Document type updated successfully');
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          isSubmitting = false;
                        });
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3282B8),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text('Update'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteTypeConfirmation(DocumentType type) {
    bool isDeleting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Document Type'),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87),
              children: [
                const TextSpan(text: 'Are you sure you want to delete "'),
                TextSpan(
                  text: type.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '" from the "'),
                TextSpan(
                  text: type.categoryName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '" category? This action cannot be undone.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isDeleting ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: isDeleting
                  ? null
                  : () async {
                setState(() {
                  isDeleting = true;
                });

                try {
                  final success = await ref
                      .read(documentManagementProvider.notifier)
                      .deleteDocumentType(type.id);

                  if (success && mounted) {
                    Navigator.pop(context);
                    _showSuccessSnackBar('Document type deleted successfully');
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      isDeleting = false;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: isDeleting
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    try {
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }
}