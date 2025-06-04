import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/uploadmodel.dart';

class UploadProvider extends StateNotifier<UploadModel> {
  UploadProvider() : super(UploadModel.initial());

  // Instance method for uploading file
  Future<Map<String, dynamic>> uploadFile({
    required String description,
    required int docCategoryId,
    required int docTypeId,
    required int userId,
    File? file,
    PlatformFile? platformFile, // Add this parameter for web support
  }) async {
    // Update state to loading
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      const String apiUrl = 'http://103.98.12.226:5100';
      
      // Prepare multipart request
      final headers = await AuthService.getAuthHeaders();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/user/upload'),
      );
      
      // Add headers
      request.headers.addAll(headers);
      
      // Add form fields - matching your required keys
      request.fields['description'] = description.trim();
      request.fields['docCategoryid'] = docCategoryId.toString();
      request.fields['docTypeid'] = docTypeId.toString();
      request.fields['userId'] = userId.toString();
      
      // Add file if provided - Handle both web and mobile platforms
      if (kIsWeb) {
        // Web platform - use PlatformFile
        if (platformFile != null && platformFile.bytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'uploadfile',
              platformFile.bytes!,
              filename: platformFile.name,
            ),
          );
          print('File added (Web): ${platformFile.name}, Size: ${platformFile.bytes!.length} bytes');
        }
      } else {
        // Mobile platform - use File
        if (file != null) {
          String fileName = file.path.split('/').last;
          
          // Read file as bytes for cross-platform compatibility
          Uint8List fileBytes = await file.readAsBytes();
          
          request.files.add(
            http.MultipartFile.fromBytes(
              'uploadfile',
              fileBytes,
              filename: fileName,
            ),
          );
          
          print('File added (Mobile): $fileName, Size: ${fileBytes.length} bytes');
        }
      }
    
      // Debug: Print request details
      print('Upload Request Details:');
      print('URL: ${request.url}');
      print('Platform: ${kIsWeb ? "Web" : "Mobile"}');
      print('Fields: ${request.fields}');
      print('Files: ${request.files.map((f) => '${f.field}: ${f.filename}')}');
     
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      // Debug: Print response
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final responseData = json.decode(response.body);
        
        // Update state with success
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          uploadResponse: responseData,
          error: null,
        );
        
        return {
          'success': true,
          'data': responseData,
          'message': responseData['message'] ?? 'File uploaded successfully!'
        };
      } else {
        // Handle error
        String errorMessage = 'Upload failed. Please try again.';
        
        try {
          final errorData = json.decode(response.body);
          if (errorData['message'] != null) {
            errorMessage = errorData['message'];
          } else if (errorData['error'] != null) {
            errorMessage = errorData['error'];
          }
        } catch (e) {
          errorMessage = 'Server returned status ${response.statusCode}';
        }
        
        // Update state with error
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: errorMessage,
        );
        
        return {
          'success': false,
          'message': errorMessage,
          'statusCode': response.statusCode,
          'responseBody': response.body
        };
      }
    } catch (e) {
      print('Upload Error: $e');
      
      String errorMessage = 'Network error. Please check your connection and try again.';
      
      // Update state with error
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: errorMessage,
      );
      
      return {
        'success': false,
        'message': errorMessage,
        'error': e.toString()
      };
    }
  }

  // Reset state method
  void resetState() {
    state = UploadModel.initial();
  }
}

final uploadProvider = StateNotifierProvider<UploadProvider, UploadModel>((ref) {
  return UploadProvider();
});