import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/providers/getdocument_category_provider.dart';
import 'package:vetassess/providers/document_type_provider.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/providers/upload_documents_provider.dart';
import 'dart:io';

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

  final List<String> tertiaryEducationOptions = [
    'Select one',
    'hgcrs - outds5ezx',
  ];

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
  }

  Future<void> _fetchCategories() async {
    await ref.read(documentCategoryProvider.notifier).fetchDocumentCategories();
    setState(() {
      isLoading = false;
    });
  }

  // New method to fetch document types when needed
  Future<void> _fetchDocumentTypes() async {
    setState(() {
      isDocumentTypesLoading = true;
    });
    await ref.read(documentTypeProvider.notifier).fetchDocumentCategories();
    setState(() {
      isDocumentTypesLoading = false;
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentCategory = ref.watch(documentCategoryProvider);
    final documentTypes = ref.watch(documentTypeProvider);

    // Create dropdown items from API data
    List<String> documentCategories = ['Select one'];
    if (documentCategory.data != null && documentCategory.data!.isNotEmpty) {
      documentCategories.addAll(
        documentCategory.data!
            .map((data) => data.documentCategory ?? '')
            .where((cat) => cat.isNotEmpty),
      );
    }

    // Create document type dropdown items from API data
    List<String> documentTypesList = ['Select one'];
    if (documentTypes.data != null && documentTypes.data!.isNotEmpty) {
      documentTypesList.addAll(
        documentTypes.data!
            .map((data) => data.name ?? '')
            .where((name) => name.isNotEmpty),
      );
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

              // Document Category Label
              Text(
                'Document Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8),

              // First Dropdown - Document Category
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                    isLoading
                        ? Container(
                          height: 48,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey[600]!,
                                ),
                              ),
                            ),
                          ),
                        )
                        : DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            hint: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Select one',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey[600],
                              ),
                            ),
                            isExpanded: true,
                            items:
                                documentCategories.map((String category) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        category == 'Select one'
                                            ? null
                                            : category,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              category == 'Select one'
                                                  ? Colors.grey[600]
                                                  : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                                // Reset sub-category and document type when main category changes
                                selectedSubCategory = null;
                                selectedDocumentType = null;
                              });
                            },
                          ),
                        ),
              ),

              // Second Dropdown - Show only when Tertiary Education is selected
              if (selectedCategory == 'Tertiary Education') ...[
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSubCategory,
                      hint: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Select one',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                        ),
                      ),
                      isExpanded: true,
                      items:
                          tertiaryEducationOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option == 'Select one' ? null : option,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        option == 'Select one'
                                            ? Colors.grey[600]
                                            : Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubCategory = newValue;
                          // Reset document type when sub-category changes
                          selectedDocumentType = null;
                        });
                        // Fetch document types when subcategory is selected
                        if (newValue == 'hgcrs - outds5ezx') {
                          _fetchDocumentTypes();
                        }
                      },
                    ),
                  ),
                ),
              ],

              // Third Dropdown - Show only when "hgcrs - outds5ezx" is selected
              if (selectedCategory == 'Tertiary Education' &&
                  selectedSubCategory == 'hgcrs - outds5ezx') ...[
                SizedBox(height: 16),

                // Document type Label
                Text(
                  'Document type',
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
                  child:
                      isDocumentTypesLoading
                          ? Container(
                            height: 48,
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey[600]!,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedDocumentType,
                              hint: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Select one',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey[600],
                                ),
                              ),
                              isExpanded: true,
                              items:
                                  documentTypesList.map((String type) {
                                    return DropdownMenuItem<String>(
                                      value: type == 'Select one' ? null : type,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          type,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                type == 'Select one'
                                                    ? Colors.grey[600]
                                                    : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDocumentType = newValue;
                                });
                              },
                            ),
                          ),
                ),

                SizedBox(height: 16),

                // Information text (moved to correct position - right after document type dropdown)
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

              // Additional fields when any document type is selected
              if (selectedCategory == 'Tertiary Education' &&
                  selectedSubCategory == 'hgcrs - outds5ezx' &&
                  selectedDocumentType != null) ...[
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
                      hintText:
                          'Please add a description advising what you are uploading.',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
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
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
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
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
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

                // File selection input (clickable to open file picker)
                GestureDetector(
                  onTap: () {
                    _pickFile();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border(
                              right: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Text(
                            'Choose File',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              selectedFileName ?? 'No file chosen',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    selectedFileName != null
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

                // Upload button (for submitting all form data)
                SizedBox(
                  width: 60,
                  child: ElevatedButton(
                    onPressed:
                        isUploading
                            ? null
                            : () {
                              _uploadFormData();
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isUploading ? Colors.grey : Colors.green[600],
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child:
                        isUploading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
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

  // Updated _uploadFormData method for your FileSelectionDialog class
  Future<void> _uploadFormData() async {
    // Validate required fields
    if (selectedCategory == null) {
      _showErrorDialog('Please select a document category');
      return;
    }

    if (selectedCategory == 'Tertiary Education' &&
        selectedSubCategory == null) {
      _showErrorDialog('Please select a subcategory');
      return;
    }

    if (selectedCategory == 'Tertiary Education' &&
        selectedSubCategory == 'hgcrs - outds5ezx' &&
        selectedDocumentType == null) {
      _showErrorDialog('Please select a document type');
      return;
    }

    if (selectedCategory == 'Tertiary Education' &&
        selectedSubCategory == 'hgcrs - outds5ezx' &&
        selectedDocumentType != null &&
        selectedPlatformFile == null) {
      _showErrorDialog('Please select a file to upload');
      return;
    }

    if (selectedCategory == 'Tertiary Education' &&
        selectedSubCategory == 'hgcrs - outds5ezx' &&
        selectedDocumentType != null &&
        descriptionController.text.trim().isEmpty) {
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
      // Get document category ID
      int? docCategoryId = _getDocumentCategoryId();
      if (docCategoryId == null) {
        _showErrorDialog('Could not find document category ID');
        return;
      }

      // Get document type ID
      int? docTypeId = _getDocumentTypeId();
      if (docTypeId == null) {
        _showErrorDialog('Could not find document type ID');
        return;
      }

      // Use the instance method from UploadProvider with both file parameters
      final result = await ref
          .read(uploadProvider.notifier)
          .uploadFile(
            description: descriptionController.text.trim(),
            docCategoryId: docCategoryId,
            docTypeId: docTypeId,
            userId: _currentUserId!,
            file: selectedFile, // For mobile platforms
            platformFile: selectedPlatformFile, // For web platforms
          );

      if (result['success']) {
        // Show success message
        _showSuccessDialog(result['message']);

        // Close dialog with result
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

  // Helper method to get document category ID
  int? _getDocumentCategoryId() {
    final documentCategory = ref.read(documentCategoryProvider);
    if (documentCategory.data != null && selectedCategory != null) {
      for (var data in documentCategory.data!) {
        if (data.documentCategory == selectedCategory) {
          return data.id;
        }
      }
    }
    return null;
  }

  // Helper method to get document type ID
  int? _getDocumentTypeId() {
    final documentTypes = ref.read(documentTypeProvider);
    if (documentTypes.data != null && selectedDocumentType != null) {
      for (var data in documentTypes.data!) {
        if (data.name == selectedDocumentType) {
          return data.id;
        }
      }
    }
    return null;
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
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
