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
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'dart:html' as html;
import 'package:vetassess/providers/login_provider.dart';

class PdfDownloadService {

static Future<void> downloadApplicationRecordPdf(
  BuildContext context,
  WidgetRef ref,
  Users user,
) async {
  try {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final ttf = pw.Font.ttf(await rootBundle.load('assets/fonts/Axiforma-Regular.ttf'));

    // Convert user object to Map<String, dynamic>
    final filteredData = user.toJson(); // You must ensure Users model has toJson()

    Navigator.of(context).pop(); // Hide loading

    if (filteredData.isEmpty) {
      _showErrorMessage(context, "No user data available.");
      return;
    }

    final pdf = pw.Document();

    // 1. Summary page
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (_) => [_buildStaticSummaryPage(filteredData, user.userId.toString(), ttf)],
      ),
    );

    // 2. Individual form pages
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

    // Save PDF
    if (kIsWeb) {
      await _saveForWeb(context, pdf, user.userId.toString());
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _saveForMobile(context, pdf, user.userId.toString());
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await _saveForDesktop(context, pdf, user.userId.toString());
    } else {
      _showErrorMessage(context, "Platform not supported");
    }

  } catch (e) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    print('PDF Generation Error: $e');
    _showErrorMessage(context, "Error generating PDF: ${e.toString()}");
  }
}


  static Map<String, dynamic> filterDataByUserId(Map<String, dynamic> jsonData, int userId) {
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
    // Count different types of data
    int totalForms = 0;
    List<List<String>> summaryData = [];

    jsonData.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        totalForms += value.length;
        summaryData.add([
          _formatSectionName(key),
          value.length.toString(),
          'List of ${value.length} items'
        ]);
      } else if (value is Map<String, dynamic> && value.isNotEmpty) {
        totalForms += 1;
        summaryData.add([
          _formatSectionName(key),
          '1',
          'Single record'
        ]);
      } else if (value != null && value.toString().isNotEmpty &&
          !['userId', 'id', 'createdAt', 'updatedAt'].contains(key)) {
        summaryData.add([
          _formatSectionName(key),
          '1',
          _truncateText(value.toString(), 30)
        ]);
      }
    });

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header Section
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.teal50,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: PdfColors.teal200),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'My Application Record Summary',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.teal800,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Generated: ${DateTime.now().toString().split('.')[0]}',
                  style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.teal700),
                ),
                pw.Text(
                  'Total Records: $totalForms',
                  style: pw.TextStyle(font: font, fontSize: 12, color: PdfColors.teal700),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // Summary Table
          pw.Text(
            'Data Summary',
            style: pw.TextStyle(font: font, fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),

          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400, width: 1),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              // Header row
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildTableCell('Section', font, isHeader: true),
                  _buildTableCell('Count', font, isHeader: true),
                  _buildTableCell('Description', font, isHeader: true),
                ],
              ),
              // Data rows
              ...summaryData.map((row) => pw.TableRow(
                children: row.map((cell) => _buildTableCell(cell, font)).toList(),
              )),
            ],
          ),

          pw.SizedBox(height: 20),

          // Privacy Notice
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              borderRadius: pw.BorderRadius.circular(4),
              border: pw.Border.all(color: PdfColors.blue200),
            ),
            child: pw.Row(
              children: [
                pw.Text('🔒 ', style: pw.TextStyle(font: font, fontSize: 14)),
                pw.Expanded(
                  child: pw.Text(
                    'Privacy: This report contains only your personal data, filtered by your user ID ($userId)',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 11,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.blue800,
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

  static pw.Widget _buildIndividualFormSection(String title, dynamic form, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Section Header
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.teal100,
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                font: font,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.teal800,
              ),
            ),
          ),

          pw.SizedBox(height: 12),

          // Data Table
          if (form is Map<String, dynamic> && form.isNotEmpty) ...[
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(3),
              },
              children: [
                // Header row
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _buildTableCell('Field', font, isHeader: true),
                    _buildTableCell('Value', font, isHeader: true),
                  ],
                ),
                // Data rows
                ...form.entries
                    .where((entry) => _shouldIncludeField(entry.key, entry.value))
                    .map((entry) => pw.TableRow(
                  children: [
                    _buildTableCell(_formatFieldName(entry.key), font),
                    _buildTableCell(_formatFieldValue(entry.value), font),
                  ],
                )),
              ],
            ),
          ] else ...[
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                borderRadius: pw.BorderRadius.circular(4),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Center(
                child: pw.Text(
                  'No data available for this section',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildTableCell(String text, pw.Font font, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.black : PdfColors.grey800,
        ),
      ),
    );
  }

  static String _formatSectionName(String key) {
    // Convert camelCase or snake_case to readable format
    return key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ')
        .trim();
  }

  static String _formatFieldName(String key) {
    // Format field names to be more readable
    return _formatSectionName(key);
  }

  static String _formatFieldValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is bool) return value ? 'Yes' : 'No';
    if (value is List) return 'List with ${value.length} items';
    if (value is Map) return 'Object with ${value.length} properties';

    String stringValue = value.toString();

    // Format dates
    if (RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(stringValue)) {
      try {
        DateTime date = DateTime.parse(stringValue);
        return '${date.day}/${date.month}/${date.year}';
      } catch (e) {
        // If parsing fails, return original string
      }
    }

    return _truncateText(stringValue, 100);
  }

  static bool _shouldIncludeField(String key, dynamic value) {
    // Skip technical fields and empty values
    final skipFields = ['id', 'userId', 'createdAt', 'updatedAt', '__v'];

    if (skipFields.contains(key)) return false;
    if (value == null) return false;
    if (value is String && value.trim().isEmpty) return false;
    if (value is List && value.isEmpty) return false;
    if (value is Map && value.isEmpty) return false;

    return true;
  }

  static String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Keep all the existing save methods unchanged
  static Future<void> _saveForWeb(BuildContext context, pw.Document pdf, String userId) async {
    try {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'my_application_record_${userId}_$timestamp.pdf')
        ..click();

      html.Url.revokeObjectUrl(url);

      _showSuccessMessage(context, "PDF downloaded successfully!");
    } catch (e) {
      throw Exception('Web download failed: $e');
    }
  }

  static Future<void> _saveForMobile(BuildContext context, pw.Document pdf, String userId) async {
    try {
      if (Platform.isAndroid) {
        final hasPermission = await _requestStoragePermission();
        if (!hasPermission) {
          throw Exception('Storage permission denied');
        }
      }

      final Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File("${directory.path}/my_application_record_${userId}_$timestamp.pdf");
      await file.writeAsBytes(await pdf.save());

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

  Widget build(BuildContext context, WidgetRef ref,Users user) {
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
                      Icons.table_view,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Generate Application Record PDF (Table Format)',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your data will be displayed in professional table format with proper formatting and styling.',
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
                  ? () => downloadApplicationRecordPdf(context, ref,user)
                  : null,
              icon: const Icon(Icons.table_chart),
              label: const Text('Generate Table Format PDF'),
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

            _buildTableFormatInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableFormatInfo() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.table_view, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Table Format Features',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('📊 Professional table layout'),
            const Text('🎨 Color-coded sections'),
            const Text('📋 Summary page with overview'),
            const Text('📝 Field name formatting'),
            const Text('📅 Date formatting'),
            const Text('🔍 Data filtering and validation'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '✨ New: Data is now displayed in organized tables with headers, borders, and proper formatting for better readability!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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