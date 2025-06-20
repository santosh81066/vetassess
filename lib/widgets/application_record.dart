import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'dart:html' as html;

import 'package:vetassess/providers/login_provider.dart';

class PdfGenerationService  {
  
  //int targetUser = 1 ;

static Future<void> generateApplicationRecordPdf(BuildContext context, WidgetRef ref) async {
  try {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Get logged-in user ID
    final loginUserId = ref.read(loginProvider).response?.userId;
    
    if (loginUserId == null) {
      Navigator.of(context).pop();
      _showErrorMessage(context, "User not logged in. Please login first.");
      return;
    }

    final ttf = pw.Font.ttf(await rootBundle.load('assets/fonts/Axiforma-Regular.ttf'));

    // Get dynamic JSON data
    final formsProvider = ref.read(getAllformsProviders.notifier);
    final jsonData = await formsProvider.getCachedJsonData();

    Navigator.of(context).pop(); // Hide loading

    if (jsonData == null) {
      _showErrorMessage(context, "No data available. Please fetch data first.");
      return;
    }

    // Filter data for the logged-in user only
    final filteredData = filterDataByUserId(jsonData, loginUserId);
    
    if (filteredData.isEmpty) {
      _showErrorMessage(context, "No data found for the current user.");
      return;
    }

    // Create PDF with page limit protection
    final pdf = pw.Document();
    
    
      // 1. Static Summary Page
        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(32),
            build: (_) => [_buildStaticSummaryPage(filteredData, loginUserId.toString() , ttf)],
          ),
        );

        // 2. Individual Form Pages
    filteredData.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(32),
              build: (_) => [
                _buildIndividualFormSection('$key - Item ${i + 1}', value[i], ttf),
              ],
            ),
          );
        }
      } else if (value is Map<String, dynamic> && value.isNotEmpty) {
        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(32),
            build: (_) => [
              _buildIndividualFormSection(key, value, ttf),
            ],
          ),
        );
      }
    });


    // 3. Save PDF
    if (kIsWeb) {
      await _saveForWeb(context, pdf, loginUserId.toString());
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _saveForMobile(context, pdf, loginUserId.toString());
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await _saveForDesktop(context, pdf, loginUserId.toString());
    } else {
      _showErrorMessage(context, "Platform not supported");
    }

  } catch (e) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    print('PDF Generation Error: $e');
    _showErrorMessage(context, "Error generating PDF: ${e.toString()}");
  }
}
// Also make these helper methods static:
  static Map<String, dynamic> filterDataByUserId(Map<String, dynamic> jsonData, int userId) {
    // Find the specific user from the users array
   
    List users = jsonData['users'] ?? [];
    Map<String, dynamic>? targetUser;
    
    for (var user in users) {
      if (user['userId'] == userId) {
        targetUser = user;
        break;
      }
    }
    
    if (targetUser == null) {
      print('User with ID $userId not found');
      return {};
    }
    
    print('Found user: ${targetUser['givenNames']} ${targetUser['surname']}');
    print('User has the following data categories:');
    
    // Log what data categories exist for this user
    targetUser.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        print('- $key: ${value.length} items');
      } else if (value is List) {
        print('- $key: empty array');
      }
    });
    
    return targetUser;
  }

static pw.Widget _buildStaticSummaryPage(Map<String, dynamic> jsonData, String userId, pw.Font font) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(16),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('My Application Record Summary',
            style: pw.TextStyle(font: font, fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        //pw.Text('User ID: $userId', style: pw.TextStyle(font: font)),
       // pw.Text('Total Forms: ${(jsonData['formDetails'] as List?)?.length ?? 0}', style: pw.TextStyle(font: font)),
        pw.Text('Generated: ${DateTime.now().toString().split('.')[0]}', style: pw.TextStyle(font: font)),
        pw.SizedBox(height: 10),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Text(
            'This report contains only your personal data',
            style: pw.TextStyle(
              font: font,
              fontStyle: pw.FontStyle.italic,
              color: PdfColors.blue800,
            ),
          ),
        ),
      ],
    ),
  );
}
static pw.Widget _buildIndividualFormSection(String title, dynamic form, pw.Font font) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(12),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(font: font, fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        if (form is Map<String, dynamic>)
          ...form.entries.map((entry) => pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Text(
              '${entry.key}: ${_truncateText(entry.value.toString(), 150)}',
              style: pw.TextStyle(font: font),
            ),
          )),
      ],
    ),
  );
}


static
String _truncateText(String text, int maxLength) {
  return text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
}

  /// Web-specific PDF download
  static Future<void> _saveForWeb(BuildContext context, pw.Document pdf, String userId) async {
    try {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      
      // Create download link
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'my_application_record_${userId}_$timestamp.pdf')
        ..click();
      
      // Clean up
      html.Url.revokeObjectUrl(url);
      
      _showSuccessMessage(context, "PDF downloaded successfully!");
    } catch (e) {
      throw Exception('Web download failed: $e');
    }
  }

  /// Mobile-specific PDF save
  static Future<void> _saveForMobile(BuildContext context, pw.Document pdf, String userId) async {
    try {
      // Request permissions
      if (Platform.isAndroid) {
        final hasPermission = await _requestStoragePermission();
        if (!hasPermission) {
          throw Exception('Storage permission denied');
        }
      }

      // Get directory
      final Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Save file
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File("${directory.path}/my_application_record_${userId}_$timestamp.pdf");
      await file.writeAsBytes(await pdf.save());

      // Show success message with open option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF saved: ${file.path}"),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => OpenFile.open(file.path),
          ),
        ),
      );
    } catch (e) {
      throw Exception('Mobile save failed: $e');
    }
  }

  /// Desktop-specific PDF save
 static Future<void> _saveForDesktop(BuildContext context, pw.Document pdf, String userId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File("${directory.path}/my_application_record_${userId}_$timestamp.pdf");
      
      await file.writeAsBytes(await pdf.save());
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF saved: ${file.path}"),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Open Folder',
            onPressed: () => OpenFile.open(directory.path),
          ),
        ),
      );
    } catch (e) {
      throw Exception('Desktop save failed: $e');
    }
  }

  /// Request storage permission for Android
 static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isDenied) {
        final manageStatus = await Permission.manageExternalStorage.request();
        return manageStatus.isGranted;
      }
      return status.isGranted;
    }
    return true;
  }

  static void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  static void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Widget build(BuildContext context,WidgetRef ref) {  // Fixed - removed WidgetRef parameter
    final loginUserId = ref.watch(loginProvider).response?.userId;
    
    return Scaffold(
      appBar: AppBar(title: const Text('My PDF Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      kIsWeb ? Icons.download : Icons.save,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      kIsWeb 
                        ? 'Generate & Download My PDF' 
                        : 'Generate & Save My PDF',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getPlatformDescription(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    if (loginUserId != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Text(
                          'Logged in as: $loginUserId',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton.icon(
              onPressed: () => ref.read(getAllformsProviders.notifier).fetchallCategories(),
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Data'),
            ),
            
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: loginUserId != null 
                ? () => generateApplicationRecordPdf(context,ref)  // Fixed - removed ref parameter
                : null,
              icon: Icon(kIsWeb ? Icons.download : Icons.picture_as_pdf),
              label: Text(kIsWeb ? 'Download My PDF' : 'Generate My PDF'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            
            if (loginUserId == null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Please login to generate your personal PDF',
                        style: TextStyle(color: Colors.orange.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 20),
            
            _buildPlatformInfo(),
          ],
        ),
      ),
    );
  }

  String _getPlatformDescription() {
    if (kIsWeb) {
      return 'Your personal PDF will be downloaded to your browser\'s download folder';
    } else if (Platform.isAndroid) {
      return 'Your personal PDF will be saved to external storage and can be opened directly';
    } else if (Platform.isIOS) {
      return 'Your personal PDF will be saved to app documents and can be shared';
    } else {
      return 'Your personal PDF will be saved to your documents folder';
    }
  }

  Widget _buildPlatformInfo() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Personal PDF Features',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('✅ Only your data is included'),
            const Text('✅ User ID verification'),
            const Text('✅ Personalized filename'),
            const Text('✅ Cross-platform support'),
            const SizedBox(height: 8),
            Text(
              'Current Platform: ${_getCurrentPlatform()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '🔒 Privacy: PDF contains only your personal data, filtered by your user ID',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentPlatform() {
    if (kIsWeb) return 'Web Browser';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }
}