import 'dart:io';
import 'dart:html' as html; // Add this for web support
import 'package:flutter/foundation.dart'; // Add this for kIsWeb

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vetassess/models/admin_download_doc_model.dart';
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/models/document_type.dart';
import 'dart:convert';

import 'package:vetassess/utils/vetassess_api.dart';

class DownloadUserDocProvider extends StateNotifier<UserDocDownload> {
  DownloadUserDocProvider() : super(UserDocDownload.initial());

  /// Fetches user documents from the API
  Future<void> getUserDocDownloadsByUserId(String userId) async {
    try {
      final headers = await AuthService.getAuthHeaders();
      
      final url = '${VetassessApi.download_user_doc}/$userId';
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final userDocDownloads = UserDocDownload.fromJson(jsonData);
        state = userDocDownloads;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception(
          'Failed to load user documents: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching user documents: $e');
      state = UserDocDownload.initial();
      rethrow;
    }
  }

Future<void> downloadDocument(BuildContext context, Documents document) async {
  final filePath = document.filePath;
  final fileName = document.filename ?? 'document.jpg';

  if (filePath == null || filePath.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Invalid file path")),
    );
    return;
  }

  final url = 'https://vetassess.com.co/$filePath';

  try {
    // ✅ For Web
   if (kIsWeb) {
  final anchor = html.AnchorElement(href: url)
    ..target = '_blank'
    ..download = fileName
    ..style.display = 'none';

  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
  return;
}


    // ✅ Request permissions for Android
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        status = await Permission.manageExternalStorage.request();
      }

      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission denied to access storage")),
        );
        return;
      }
    }

    // ✅ Choose download directory
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS || Platform.isMacOS) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows || Platform.isLinux) {
      directory = await getDownloadsDirectory();
    }

    if (directory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to access storage")),
      );
      return;
    }

    final savePath = '${directory.path}/$fileName';

    final dio = Dio();
    final response = await dio.download(
      url,
      savePath,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to: $savePath")),
      );
      OpenFile.open(savePath);
    } else {
      throw Exception('Download failed: ${response.statusCode}');
    }
   } catch (e) {
    debugPrint('Download error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download failed: ${e.toString()}')),
    );
  }
}
Future<Directory?> getDownloadsDirectory() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final directory = await getDownloadsDirectory();
    return directory;
  }
  return null;
}


}

final downloadUserDocProvider =
    StateNotifierProvider<DownloadUserDocProvider, UserDocDownload>((ref) {
      return DownloadUserDocProvider();
    });