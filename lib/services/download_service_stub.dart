import 'dart:typed_data';

class DownloadService {
  static Future<void> downloadFile(Uint8List bytes, String fileName) async {
    throw UnsupportedError('Download not supported on this platform');
  }
}
