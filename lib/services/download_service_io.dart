import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<void> downloadFile(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
  }
}
