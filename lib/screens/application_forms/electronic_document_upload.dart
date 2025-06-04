import 'package:flutter/material.dart';
import 'package:vetassess/screens/application_forms/selectfile.dart';
import 'package:vetassess/widgets/upload_layout.dart';

class VetassessUploadPage extends StatefulWidget {
  @override
  _VetassessUploadPageState createState() => _VetassessUploadPageState();
}

class _VetassessUploadPageState extends State<VetassessUploadPage> {
  bool isInstructionsExpanded = true;

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove,
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
                              'If a document has multiple pages, please scan all relevant pages into one file for uploading.'),
                          _buildBulletPoint(
                              'All pages in a document need to be uploaded in sequence.'),
                          _buildBulletPoint(
                              'When naming your files to be uploaded to VETASSESS, only use numbers 0 – 9 and letters A – Z (upper and lower case), dashes \'-\' and underscores \'_\'.'),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 4, bottom: 4),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 14, color: Colors.black87),
                                children: [
                                  TextSpan(
                                    text: 'You must avoid ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text:
                                          'using spaces \' \', periods \'.\', ampersand \'&\', hash \'#\', star \'*\', exclamation marks \'!\', quotations \'\"\' and any other character that is not a letter, a number, a dash or an underscore.'),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 4, bottom: 8),
                            child: Text(
                              'For example: CompanyName_Payslip2017',
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ),
                          _buildBulletPoint('You can upload up to 60 documents.',
                              highlight: '60'),
                          _buildBulletPoint(
                              'All uploaded documents need to be high quality colour scans of the original documents. Resolution must be at least 300 dpi.'),
                          _buildBulletPoint(
                              'After attaching all documents, you must press the "Submit & Finish Uploading" button to complete the submission process.',
                              highlight: '"Submit & Finish Uploading"'),
                          _buildBulletPoint(
                              'All documents must be high quality colour scans of the original document/s. If your documents are not issued in the English language, you must submit scans of both the original language documents as well as the English translations made by a registered translation service.',
                              highlights: [
                                'documents are not issued in the English language',
                                'submit scans of both the original language documents as well as the English translations'
                              ]),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        
            SizedBox(height: 16),

Container(
  child: ElevatedButton(
    onPressed: () async {
      // Show the file selection dialog
      Map<String, dynamic>? result = await showFileSelectionDialog(context);
      
      if (result != null) {
        // Handle the selected data
        String? selectedCategory = result['category'];
        String? selectedSubCategory = result['subCategory'];
        String? selectedDocumentType = result['documentType'];
        String? description = result['description'];
        String? fileName = result['fileName'];
        
        print('Selected category: $selectedCategory');
        if (selectedSubCategory != null) {
          print('Selected sub-category: $selectedSubCategory');
        }
        if (selectedDocumentType != null) {
          print('Selected document type: $selectedDocumentType');
        }
        if (description != null && description.isNotEmpty) {
          print('Description: $description');
        }
        if (fileName != null) {
          print('Selected file: $fileName');
        }
        
        // Here you can process the collected data
        // For example, upload the file, save the data, etc.
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
            _buildDocumentCategory('Uploaded Identification Documents', 0,
                'Documents yet to upload or already submitted to Vetassess'),
            SizedBox(height: 16),
            _buildDocumentCategory('Uploaded Qualification Documents', 0,
                'Documents yet to upload or already submitted to Vetassess',
                fileName: 'hgcrs - outds5ezx'),
            SizedBox(height: 16),
            _buildDocumentCategory('Uploaded Employment Documents', 0,
                'Documents yet to upload or already submitted to Vetassess',
                fileName: 'ouilykuyzstufrgh - tharun - (2024-2025)'),
            SizedBox(height: 16),
            _buildDocumentCategory('Uploaded Other/Fees and Payment Documents', 0,
                'Documents yet to upload or already submitted to Vetassess'),
        
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text,
      {String? highlight, List<String>? highlights}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold)),
          Expanded(
            child: _buildTextWithHighlights(text,
                highlight: highlight, highlights: highlights),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithHighlights(String text,
      {String? highlight, List<String>? highlights}) {
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
      return Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      );
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
      spans.add(TextSpan(
        text: highlight,
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      start = index + highlight.length;
      index = text.indexOf(highlight, start);
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return spans;
  }

  List<TextSpan> _getTextSpansWithMultipleHighlights(
      String text, List<String> highlights) {
    List<TextSpan> spans = [];
    String remainingText = text;

    for (String highlight in highlights) {
      List<TextSpan> tempSpans = [];
      for (TextSpan span in spans.isEmpty ? [TextSpan(text: remainingText)] : spans) {
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

  Widget _buildDocumentCategory(String title, int count, String subtitle,
      {String? fileName}) {
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
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count.toString(),
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
          if (fileName != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.remove, size: 16, color: Colors.black87),
                  SizedBox(width: 8),
                  Text(
                    fileName,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}