import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/models/getdocument_category.dart' show Data;
import 'package:vetassess/providers/getdocument_category_provider.dart';
import 'package:vetassess/providers/document_type_provider.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/providers/upload_documents_provider.dart';
import 'dart:io';
import 'package:vetassess/models/document_type.dart' as DocType;

class FileSelectionDialog extends ConsumerStatefulWidget {
  @override
  _FileSelectionDialogState createState() => _FileSelectionDialogState();
}

class _FileSelectionDialogState extends ConsumerState<FileSelectionDialog> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedDocumentType;
  String? selectedFileName;
  File? selectedFile;
  PlatformFile? selectedPlatformFile;
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = true;
  bool isDocumentTypesLoading = false;
  bool isUploading = false;

  // Store selected IDs for API calls
  int? selectedCategoryId;
  int? selectedSubCategoryId;
  int? selectedDocumentTypeId;

  // Get user ID from login state
  int? get _currentUserId {
    final loginState = ref.read(loginProvider);
    return loginState.response?.userId;
  }

  @override
  void initState() {
    super.initState();
    // Fetch document categories when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCategories();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDocumentTypes();
    });
  }

  Future<void> _fetchCategories() async {
    await ref.read(documentCategoryProvider.notifier).fetchDocumentCategories();
    setState(() {
      isLoading = false;
    });
  }

  // Fetch document types when needed
  Future<void> _fetchDocumentTypes() async {
    setState(() {
      isDocumentTypesLoading = true;
    });
    await ref.read(documentTypeProvider.notifier).getDocumentTypes();
    setState(() {
      isDocumentTypesLoading = false;
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  // Get parent categories (categories without parent)
  List<Data> _getParentCategories(List<Data> allCategories) {
    return allCategories.where((category) => category.parentCategory == null).toList();
  }

  // Get subcategories for a specific parent category
  List<Data> _getSubCategories(List<Data> allCategories, int parentCategoryId) {
    return allCategories
        .where((category) => 
            category.parentCategory != null && 
            category.parentCategory!.id == parentCategoryId)
        .toList();
  }

  // Get document types for a specific subcategory
  List<DocType.Data> _getDocumentTypes(List<DocType.Data> allDocumentTypes, int subCategoryId) {
    return allDocumentTypes
        .where((docType) => docType.docCategoryId == subCategoryId)
        .toList();
  }


  // Build dropdown widget
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    bool isLoading = false,
  }) {
    // Ensure the value exists in items, if not set to null
    String? safeValue = value;
    if (value != null && !items.any((item) => item.value == value)) {
      safeValue = null;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: isLoading
          ? Container(
              height: 48,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
                  ),
                ),
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: safeValue,
                hint: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    hint,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ),
                isExpanded: true,
                items: items,
                onChanged: onChanged,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final documentCategory = ref.watch(documentCategoryProvider);
    final documentTypes = ref.watch(documentTypeProvider);

    // Get parent categories
    List<Data> parentCategories = [];
    if (documentCategory.data != null && documentCategory.data!.isNotEmpty) {
      parentCategories = _getParentCategories(documentCategory.data!);
    }

    // Get subcategories based on selected parent category
    List<Data> subCategories = [];
    if (selectedCategoryId != null && documentCategory.data != null) {
      subCategories = _getSubCategories(documentCategory.data!, selectedCategoryId!);
    }

    // Get document types based on selected subcategory
    List<DocType.Data> documentTypesList = [];
if (documentTypes.data != null) {
  if (selectedSubCategoryId != null) {
    documentTypesList = _getDocumentTypes(documentTypes.data!, selectedSubCategoryId!);
  } else if (selectedCategoryId != null &&
      (subCategories.isEmpty ||
       parentCategories.firstWhere((cat) => cat.id == selectedCategoryId!).subtype == null ||
       parentCategories.firstWhere((cat) => cat.id == selectedCategoryId!).subtype == 0)) {
    // Show document types directly for parent category if there are no subcategories
    documentTypesList = _getDocumentTypes(documentTypes.data!, selectedCategoryId!);
  }
}


    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 500,
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select a file',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Document Category Section
              Text(
                'Document Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),

              // First Dropdown - Parent Document Category
              _buildDropdown(
                value: selectedCategory,
                hint: 'Select one',
                isLoading: isLoading,
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Select one',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  ...parentCategories.map((Data category) {
                    return DropdownMenuItem<String>(
                      value: category.documentCategory,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          category.documentCategory ?? '',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    );
                  }).toList(),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                    selectedSubCategory = null;
                    selectedDocumentType = null;
                    selectedSubCategoryId = null;
                    selectedDocumentTypeId = null;
                    
                    // Find and store the selected category ID
                    if (newValue != null) {
                      final selectedCat = parentCategories.firstWhere(
                        (cat) => cat.documentCategory == newValue,
                      );
                      selectedCategoryId = selectedCat.id;
                    } else {
                      selectedCategoryId = null;
                    }
                  });
                },
              ),

              // Second Dropdown - Subcategories
              if (selectedCategoryId != null && subCategories.isNotEmpty) ...[
                SizedBox(height: 16),
                _buildDropdown(
                  value: selectedSubCategory,
                  hint: 'Select subcategory',
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Select one',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    ...subCategories.map((Data subCategory) {
                      return DropdownMenuItem<String>(
                        value: subCategory.documentCategory,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            subCategory.documentCategory ?? '',
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubCategory = newValue;
                      selectedDocumentType = null;
                      selectedDocumentTypeId = null;
                      
                      // Find and store the selected subcategory ID
                      if (newValue != null) {
                        final selectedSubCat = subCategories.firstWhere(
                          (subCat) => subCat.documentCategory == newValue,
                        );
                        selectedSubCategoryId = selectedSubCat.id;
                      } else {
                        selectedSubCategoryId = null;
                      }
                    });
                  },
                ),
              ],

                              // Third Dropdown - Document Types
              if ((selectedSubCategoryId != null ||
     (selectedCategoryId != null &&
      (subCategories.isEmpty ||
       parentCategories.firstWhere((cat) => cat.id == selectedCategoryId!).subtype == null ||
       parentCategories.firstWhere((cat) => cat.id == selectedCategoryId!).subtype == 0))
    ) && documentTypesList.isNotEmpty) ...
[
                SizedBox(height: 16),
                Text(
                  'Document type',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),

                _buildDropdown(
                  value: selectedDocumentType,
                  hint: 'Select document type',
                  isLoading: isDocumentTypesLoading,
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Select one',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    // Remove duplicates and null values
                    ...documentTypesList
                        .where((docType) => docType.name != null && docType.name!.isNotEmpty)
                        .toSet() // Remove duplicates
                        .map((DocType.Data docType) {
                      return DropdownMenuItem<String>(
                        value: "${docType.id}_${docType.name}", // Use unique identifier
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            docType.name ?? '',
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null && newValue.contains('_')) {
                        // Extract ID and name from the combined value
                        final parts = newValue.split('_');
                        final docId = int.tryParse(parts[0]);
                        final docName = parts.sublist(1).join('_'); // In case name contains underscore
                        
                        selectedDocumentType = newValue;
                        selectedDocumentTypeId = docId;
                      } else {
                        selectedDocumentType = null;
                        selectedDocumentTypeId = null;
                      }
                    });
                  },
                ),

                SizedBox(height: 16),

                // Information text
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Text(
                    'All documents must be high quality colour scans of the original documents. If your documents are not issued in the English language, you must submit scans of both the original language documents as well as the English translations made by a registered translation services.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[800],
                      height: 1.4,
                    ),
                  ),
                ),
              ],

              // Show additional fields ONLY when document type is selected
              if (selectedDocumentTypeId != null) ...[
                SizedBox(height: 24),

                // Description Section
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Please add a description advising what you are uploading.',
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // File Format and Size Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Acceptable Formats',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '.pdf, .png, .jpg, .jpeg, .gif, .tiff',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Acceptable Size',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '5 MB',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // File Selection Section
                Text(
                  'Select file',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),

                // File selection input
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border(right: BorderSide(color: Colors.grey[300]!)),
                          ),
                          child: Text(
                            'Choose File',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              selectedFileName ?? 'No file chosen',
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedFileName != null
                                    ? Colors.black87
                                    : Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Upload button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isUploading ? null : _uploadFormData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUploading ? Colors.grey : Colors.green[600],
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: isUploading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Upload',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }



  // Method to handle file picking
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'gif', 'tiff'],
      );

      if (result != null) {
        setState(() {
          selectedFileName = result.files.single.name;
          selectedPlatformFile = result.files.single;

          // For mobile platforms, create File object
          if (result.files.single.path != null) {
            selectedFile = File(result.files.single.path!);
          }
        });

        // Validate file size (5 MB = 5 * 1024 * 1024 bytes)
        if (selectedPlatformFile!.size > 5 * 1024 * 1024) {
          setState(() {
            selectedFileName = null;
            selectedPlatformFile = null;
            selectedFile = null;
          });
          _showErrorDialog(
            'File size exceeds 5 MB limit. Please select a smaller file.',
          );
        }
      }
    } catch (e) {
      print('Error picking file: $e');
      _showErrorDialog('Error selecting file. Please try again.');
    }
  }

  // Updated _uploadFormData method
  Future<void> _uploadFormData() async {
    // Validate required fields
    if (selectedCategoryId == null) {
      _showErrorDialog('Please select a document category');
      return;
    }

    final docCategoryIdToUse = selectedSubCategoryId ?? selectedCategoryId;
if (docCategoryIdToUse == null) {
  _showErrorDialog('Please select a document category or subcategory');
  return;
}


    if (selectedDocumentTypeId == null) {
      _showErrorDialog('Please select a document type');
      return;
    }

    if (selectedPlatformFile == null) {
      _showErrorDialog('Please select a file to upload');
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      _showErrorDialog('Please add a description');
      return;
    }

    if (_currentUserId == null) {
      _showErrorDialog('User not logged in. Please login again.');
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      // Upload the document
      final result = await ref.read(uploadProvider.notifier).uploadFile(
            description: descriptionController.text.trim(),
            docCategoryId: docCategoryIdToUse,
            docTypeId: selectedDocumentTypeId!,
            userId: _currentUserId!,
            file: selectedFile, // For mobile platforms
            platformFile: selectedPlatformFile, // For web platforms
          );

      if (result['success']) {
        // Show success dialog and wait for user to dismiss
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(result['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // After the success dialog is dismissed, close the parent dialog
        Navigator.of(context).pop({
          'success': true,
          'category': selectedCategory,
          'subCategory': selectedSubCategory,
          'documentType': selectedDocumentType,
          'fileName': selectedFileName,
          'description': descriptionController.text,
          'response': result['data'],
        });
      } else {
        _showErrorDialog(result['message']);
      }
    } catch (e) {
      print('Error during upload: $e');
      _showErrorDialog('An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Function to show the dialog
Future<Map<String, dynamic>?> showFileSelectionDialog(BuildContext context) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FileSelectionDialog();
    },
  );
}