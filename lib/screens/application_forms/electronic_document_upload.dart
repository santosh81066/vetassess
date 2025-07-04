import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/application_forms/selectfile.dart';
import 'package:vetassess/widgets/upload_layout.dart';
import 'package:vetassess/providers/download_user_doc_provider.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/models/admin_download_doc_model.dart';

class VetassessUploadPage extends ConsumerStatefulWidget {
  @override
  _VetassessUploadPageState createState() => _VetassessUploadPageState();
}

class _VetassessUploadPageState extends ConsumerState<VetassessUploadPage> {
  bool isInstructionsExpanded = true;
  bool isLoadingDocuments = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserDocuments();
    });
  }

  Future<void> _fetchUserDocuments() async {
    try {
      final loginState = ref.read(loginProvider);
      final userId = loginState.response?.userId;

      if (userId != null) {
        await ref.read(downloadUserDocProvider.notifier)
            .getUserDocDownloadsByUserId(userId.toString());
      }
    } catch (e) {
      print('Error fetching user documents: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load documents: $e')),
      );
    } finally {
      setState(() {
        isLoadingDocuments = false;
      });
    }
  }

  Future<void> _refreshDocuments() async {
    setState(() {
      isLoadingDocuments = true;
    });
    await _fetchUserDocuments();
  }

  // Group documents by category
  Map<String, List<Documents>> _groupDocumentsByCategory(List<Documents> documents) {
    Map<String, List<Documents>> groupedDocs = {
      'Identification': [],
      'Qualification': [],
      'Employment': [],
      'Other/Fees and Payment': [],
    };

    for (Documents doc in documents) {
      String categoryName = doc.docCategory?.name?.toLowerCase() ?? '';

      if (categoryName.contains('identification') || categoryName.contains('identity')) {
        groupedDocs['Identification']!.add(doc);
      } else if (categoryName.contains('qualification') || categoryName.contains('education')) {
        groupedDocs['Qualification']!.add(doc);
      } else if (categoryName.contains('employment') || categoryName.contains('work')) {
        groupedDocs['Employment']!.add(doc);
      } else {
        groupedDocs['Other/Fees and Payment']!.add(doc);
      }
    }

    return groupedDocs;
  }

  @override
  Widget build(BuildContext context) {
    final userDocDownload = ref.watch(downloadUserDocProvider);
    final documents = userDocDownload.documents ?? [];
    final groupedDocuments = _groupDocumentsByCategory(documents);

    return UploadLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Instructions Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isInstructionsExpanded = !isInstructionsExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isInstructionsExpanded ? Icons.remove : Icons.add,
                            size: 18,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Instructions for upload',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isInstructionsExpanded)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBulletPoint(
                            'If a document has multiple pages, please scan all relevant pages into one file for uploading.',
                          ),
                          _buildBulletPoint(
                            'All pages in a document need to be uploaded in sequence.',
                          ),
                          _buildBulletPoint(
                            'When naming your files to be uploaded to VETASSESS, only use numbers 0 – 9 and letters A – Z (upper and lower case), dashes \'-\' and underscores \'_\'.',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 4,
                              bottom: 4,
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'You must avoid ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    'using spaces \' \', periods \'.\', ampersand \'&\', hash \'#\', star \'*\', exclamation marks \'!\', quotations \'\"\' and any other character that is not a letter, a number, a dash or an underscore.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 4,
                              bottom: 8,
                            ),
                            child: Text(
                              'For example: CompanyName_Payslip2017',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          _buildBulletPoint(
                            'You can upload up to 60 documents.',
                            highlight: '60',
                          ),
                          _buildBulletPoint(
                            'All uploaded documents need to be high quality colour scans of the original documents. Resolution must be at least 300 dpi.',
                          ),
                          _buildBulletPoint(
                            'After attaching all documents, you must press the "Submit & Finish Uploading" button to complete the submission process.',
                            highlight: '"Submit & Finish Uploading"',
                          ),
                          _buildBulletPoint(
                            'All documents must be high quality colour scans of the original document/s. If your documents are not issued in the English language, you must submit scans of both the original language documents as well as the English translations made by a registered translation services.',
                            highlights: [
                              'documents are not issued in the English language',
                              'submit scans of both the original language documents as well as the English translations',
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Action Buttons Row
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Show the file selection dialog
                    Map<String, dynamic>? result = await showFileSelectionDialog(
                      context,
                    );

                    if (result != null && result['success'] == true) {
                      // Refresh the documents list after successful upload
                      await _refreshDocuments();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Document uploaded successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Select file',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: isLoadingDocuments ? null : _refreshDocuments,
                  icon: isLoadingDocuments
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                      : Icon(Icons.refresh, color: Colors.blue[600]),
                  tooltip: 'Refresh documents',
                ),
              ],
            ),

            SizedBox(height: 40),

            // Save & Continue Later Section
            Text(
              'To upload more documents at a later date, click "Save & Continue Later"',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),

            SizedBox(height: 16),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle save and continue later
                    context.go('/get_all_forms');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'SAVE & CONTINUE LATER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            // Document Categories Section
            if (isLoadingDocuments)
              Center(
                child: CircularProgressIndicator(),
              )
            else ...[
              _buildDocumentCategory(
                'Uploaded Identification Documents',
                groupedDocuments['Identification']!,
                'Documents yet to upload or already submitted to Vetassess',
              ),
              SizedBox(height: 16),
              _buildDocumentCategory(
                'Uploaded Qualification Documents',
                groupedDocuments['Qualification']!,
                'Documents yet to upload or already submitted to Vetassess',
              ),
              SizedBox(height: 16),
              _buildDocumentCategory(
                'Uploaded Employment Documents',
                groupedDocuments['Employment']!,
                'Documents yet to upload or already submitted to Vetassess',
              ),
              SizedBox(height: 16),
              _buildDocumentCategory(
                'Uploaded Other/Fees and Payment Documents',
                groupedDocuments['Other/Fees and Payment']!,
                'Documents yet to upload or already submitted to Vetassess',
              ),
            ],

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(
      String text, {
        String? highlight,
        List<String>? highlights,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _buildTextWithHighlights(
              text,
              highlight: highlight,
              highlights: highlights,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithHighlights(
      String text, {
        String? highlight,
        List<String>? highlights,
      }) {
    if (highlight != null) {
      return RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black87),
          children: _getTextSpansWithHighlight(text, highlight),
        ),
      );
    } else if (highlights != null) {
      return RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black87),
          children: _getTextSpansWithMultipleHighlights(text, highlights),
        ),
      );
    } else {
      return Text(text, style: TextStyle(fontSize: 14, color: Colors.black87));
    }
  }

  List<TextSpan> _getTextSpansWithHighlight(String text, String highlight) {
    List<TextSpan> spans = [];
    int start = 0;
    int index = text.indexOf(highlight);

    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      spans.add(
        TextSpan(
          text: highlight,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      start = index + highlight.length;
      index = text.indexOf(highlight, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }

  List<TextSpan> _getTextSpansWithMultipleHighlights(
      String text,
      List<String> highlights,
      ) {
    List<TextSpan> spans = [];
    String remainingText = text;

    for (String highlight in highlights) {
      List<TextSpan> tempSpans = [];
      for (TextSpan span
      in spans.isEmpty ? [TextSpan(text: remainingText)] : spans) {
        if (span.text != null && span.style?.fontWeight != FontWeight.bold) {
          tempSpans.addAll(_getTextSpansWithHighlight(span.text!, highlight));
        } else {
          tempSpans.add(span);
        }
      }
      spans = tempSpans;
    }

    return spans.isEmpty ? [TextSpan(text: text)] : spans;
  }

  Widget _buildDocumentCategory(
      String title,
      List<Documents> documents,
      String subtitle,
      ) {
    IconData iconData;
    switch (title) {
      case 'Uploaded Identification Documents':
        iconData = Icons.person;
        break;
      case 'Uploaded Qualification Documents':
        iconData = Icons.school;
        break;
      case 'Uploaded Employment Documents':
        iconData = Icons.work;
        break;
      case 'Uploaded Other/Fees and Payment Documents':
        iconData = Icons.receipt;
        break;
      default:
        iconData = Icons.folder;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(iconData, size: 16, color: Colors.black87),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: documents.isEmpty ? Colors.grey[600] : Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    documents.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Documents list
          if (documents.isNotEmpty)
            ...documents.map((document) => _buildDocumentItem(document))
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(Documents document) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.description, size: 16, color: Colors.blue[600]),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.filename ?? 'Unknown file',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (document.description != null && document.description!.isNotEmpty)
                  Text(
                    document.description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (document.docType?.name != null)
                  Text(
                    'Type: ${document.docType!.name}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await ref.read(downloadUserDocProvider.notifier)
                    .downloadDocument(context, document);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to download: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: Icon(Icons.download, size: 18, color: Colors.green[600]),
            tooltip: 'Download document',
            padding: EdgeInsets.all(4),
            constraints: BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}