import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/services/download_service.dart';

class PdfDownloaduserService {
  // Map MIME types to file extensions
  static const Map<String, String> _mimeToExtension = {
    // Images
    'image/jpeg': '.jpg',
    'image/jpg': '.jpg',
    'image/png': '.png',
    'image/gif': '.gif',
    'image/bmp': '.bmp',
    'image/webp': '.webp',
    'image/svg+xml': '.svg',
    'image/tiff': '.tiff',
    'image/x-icon': '.ico',
    
    // Documents
    'application/pdf': '.pdf',
    'application/msword': '.doc',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': '.docx',
    'application/vnd.ms-excel': '.xls',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': '.xlsx',
    'application/vnd.ms-powerpoint': '.ppt',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': '.pptx',
    'text/plain': '.txt',
    'text/csv': '.csv',
    'application/rtf': '.rtf',
    
    // Archives
    'application/zip': '.zip',
    'application/x-rar-compressed': '.rar',
    'application/x-7z-compressed': '.7z',
    'application/x-tar': '.tar',
    'application/gzip': '.gz',
    
    // Audio
    'audio/mpeg': '.mp3',
    'audio/wav': '.wav',
    'audio/ogg': '.ogg',
    'audio/mp4': '.m4a',
    
    // Video
    'video/mp4': '.mp4',
    'video/mpeg': '.mpeg',
    'video/quicktime': '.mov',
    'video/x-msvideo': '.avi',
    'video/webm': '.webm',
    
    // Other common formats
    'application/json': '.json',
    'application/xml': '.xml',
    'text/html': '.html',
    'text/css': '.css',
    'application/javascript': '.js',
  };

  // Detect file extension from MIME type
  static String _getExtensionFromMimeType(String? mimeType) {
    if (mimeType == null) return '';
    
    // Clean up MIME type (remove charset info if present)
    final cleanMimeType = mimeType.split(';').first.trim().toLowerCase();
    
    return _mimeToExtension[cleanMimeType] ?? '';
  }

  // Detect file extension from magic bytes (file signature)
  static String _getExtensionFromMagicBytes(Uint8List bytes) {
    if (bytes.length < 8) return '';

    // Convert first few bytes to hex string for comparison
    final hexSignature = bytes.take(8).map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
    
    // Common file signatures
    if (hexSignature.startsWith('ffd8ff')) return '.jpg'; // JPEG
    if (hexSignature.startsWith('89504e47')) return '.png'; // PNG
    if (hexSignature.startsWith('47494638')) return '.gif'; // GIF
    if (hexSignature.startsWith('25504446')) return '.pdf'; // PDF
    if (hexSignature.startsWith('504b0304') || hexSignature.startsWith('504b0506') || hexSignature.startsWith('504b0708')) {
      return '.zip'; // ZIP (also used by docx, xlsx, etc.)
    }
    if (hexSignature.startsWith('d0cf11e0')) return '.doc'; // DOC/XLS/PPT
    if (hexSignature.startsWith('52494646')) return '.wav'; // WAV
    if (hexSignature.startsWith('49443303') || hexSignature.startsWith('fff3') || hexSignature.startsWith('fffb')) {
      return '.mp3'; // MP3
    }
    if (hexSignature.startsWith('00000018') || hexSignature.startsWith('00000020')) return '.mp4'; // MP4
    if (hexSignature.startsWith('424d')) return '.bmp'; // BMP
    if (hexSignature.startsWith('52494646') && bytes.length > 12) {
      final format = String.fromCharCodes(bytes.sublist(8, 12));
      if (format == 'WEBP') return '.webp'; // WebP
    }

    return '';
  }

  // Get appropriate file extension using multiple detection methods
  static String _detectFileExtension(http.Response response, String fallbackName) {
    final bytes = response.bodyBytes;
    
    // Method 1: Try to get extension from Content-Disposition header filename
    final contentDisposition = response.headers['content-disposition'];
    if (contentDisposition != null) {
      final regex = RegExp(r'filename="?([^"]+)"?');
      final match = regex.firstMatch(contentDisposition);
      if (match != null) {
        final fileName = match.group(1)!;
        final dotIndex = fileName.lastIndexOf('.');
        if (dotIndex != -1 && dotIndex < fileName.length - 1) {
          return fileName.substring(dotIndex);
        }
      }
    }

    // Method 2: Try to get extension from Content-Type header
    final contentType = response.headers['content-type'];
    final mimeExtension = _getExtensionFromMimeType(contentType);
    if (mimeExtension.isNotEmpty) {
      return mimeExtension;
    }

    // Method 3: Try to detect from file magic bytes
    final magicExtension = _getExtensionFromMagicBytes(bytes);
    if (magicExtension.isNotEmpty) {
      return magicExtension;
    }

    // Method 4: Check URL path for extension
    try {
      final uri = Uri.parse(response.request?.url.toString() ?? '');
      final path = uri.path;
      final dotIndex = path.lastIndexOf('.');
      if (dotIndex != -1 && dotIndex < path.length - 1) {
        final urlExtension = path.substring(dotIndex);
        if (urlExtension.length <= 5) { // Reasonable extension length
          return urlExtension;
        }
      }
    } catch (e) {
      // Ignore URL parsing errors
    }

    // Fallback: return empty string (no extension)
    return '';
  }

  // Get human-readable file type description
  static String _getFileTypeDescription(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'JPEG Image';
      case '.png':
        return 'PNG Image';
      case '.gif':
        return 'GIF Image';
      case '.pdf':
        return 'PDF Document';
      case '.doc':
        return 'Word Document';
      case '.docx':
        return 'Word Document';
      case '.xls':
        return 'Excel Spreadsheet';
      case '.xlsx':
        return 'Excel Spreadsheet';
      case '.zip':
        return 'ZIP Archive';
      case '.mp3':
        return 'MP3 Audio';
      case '.mp4':
        return 'MP4 Video';
      default:
        return 'File';
    }
  }

  static Future<void> downloadCertificatePdf(
    BuildContext context,
    WidgetRef ref,
    Users user,
  ) async {
    try {
      final userId = user.userId;
      final url = 'https://vetassess.com.co/user/download/$userId';
      final headers = await AuthService.getAuthHeaders();

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Auto-detect file extension
        final detectedExtension = _detectFileExtension(response, 'certificate_$userId');
        
        // Build filename
        String fileName;
        final contentDisposition = response.headers['content-disposition'];
        if (contentDisposition != null) {
          final regex = RegExp(r'filename="?([^"]+)"?');
          final match = regex.firstMatch(contentDisposition);
          if (match != null) {
            fileName = match.group(1)!;
          } else {
            fileName = 'certificate_$userId$detectedExtension';
          }
        } else {
          fileName = 'certificate_$userId$detectedExtension';
        }

        // Ensure filename has an extension
        if (!fileName.contains('.') && detectedExtension.isNotEmpty) {
          fileName += detectedExtension;
        }

        // If still no extension, add a generic one
        if (!fileName.contains('.')) {
          fileName += '.bin'; // Binary file as fallback
        }

        await DownloadService.downloadFile(bytes, fileName);

        // Get file type for user-friendly message
        final extension = fileName.substring(fileName.lastIndexOf('.'));
        final fileType = _getFileTypeDescription(extension);
        final fileSize = _formatFileSize(bytes.length);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded $fileType successfully\n$fileName ($fileSize)'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      } else {
        throw Exception('Failed to download. Status: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download failed: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  // Helper method to format file size
  static String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}