// Web-compatible GetAllformsProviders using shared_preferences for web storage
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/services/auth_service.dart';
import 'dart:convert';
import 'package:vetassess/utils/vetassess_api.dart';

class GetAllformsProviders extends StateNotifier<GetAllFormsModel> {
  final Ref ref;
  static const String _cacheKey = 'cached_all_forms_json';

  GetAllformsProviders(this.ref) : super(GetAllFormsModel.initial());

  Future<void> fetchallCategories() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      const url = VetassessApi.allform_upload_doc;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('user all documents...${response.body}');
        
        // ✅ Save JSON to storage (works on all platforms)
        await _saveJsonToStorage(jsonData);
        
        // Update state
        final getAllFormsModel = GetAllFormsModel.fromJson(jsonData);
        state = getAllFormsModel;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to load all forms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching all Forms: $e');
      // Try to load from cached storage if API fails
      await _loadFromCachedStorage();
    }
  }

  /// Save JSON data using platform-appropriate storage
  Future<void> _saveJsonToStorage(dynamic jsonData) async {
    try {
      final jsonString = json.encode(jsonData);
      print('saved json data....$jsonData');
      
      if (kIsWeb) {
        // Use SharedPreferences for web
        final prefs = await SharedPreferences.getInstance();
        
        // Check if data has changed
        final currentData = prefs.getString(_cacheKey);
        if (currentData == jsonString) {
          print("No change in data, skipping storage write.");
          return;
        }
        
        await prefs.setString(_cacheKey, jsonString);
        print('JSON data saved to web storage');
      } else {
        // Use file system for mobile/desktop
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/cached_all_forms.json');
        
        // Check if file already has same content
        if (await file.exists()) {
          final currentData = await file.readAsString();
          if (currentData == jsonString) {
            print("No change in data, skipping file write.");
            return;
          }
        }
        
        await file.writeAsString(jsonString);
        print('JSON data saved to ${file.path}');
      }
    } catch (e) {
      print('Error saving JSON data: $e');
    }
  }

  /// Load data from cached storage
  Future<void> _loadFromCachedStorage() async {
    try {
      String? jsonString;
      
      if (kIsWeb) {
        // Load from SharedPreferences for web
        final prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString(_cacheKey);
      } else {
        // Load from file system for mobile/desktop
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/cached_all_forms.json');
        
        if (await file.exists()) {
          jsonString = await file.readAsString();
        }
      }
      
      if (jsonString != null && jsonString.isNotEmpty) {
        final jsonData = json.decode(jsonString);
        final getAllFormsModel = GetAllFormsModel.fromJson(jsonData);
        state = getAllFormsModel;
        print('Data loaded from cached storage');
      } else {
        print('No cached data found');
        state = GetAllFormsModel.initial();
      }
    } catch (e) {
      print('Error loading from cached storage: $e');
      state = GetAllFormsModel.initial();
    }
  }

  /// Get cached JSON data for PDF generation
  Future<Map<String, dynamic>?> getCachedJsonData() async {
    try {
      String? jsonString;
      
      if (kIsWeb) {
        // Load from SharedPreferences for web
        final prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString(_cacheKey);
      } else {
        // Load from file system for mobile/desktop
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/cached_all_forms.json');
        
        if (await file.exists()) {
          jsonString = await file.readAsString();
        }
      }
      
      if (jsonString != null && jsonString.isNotEmpty) {
        return json.decode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Error reading cached JSON data: $e');
      return null;
    }
  }

  /// Clear cached data
  Future<void> clearCache() async {
    try {
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_cacheKey);
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/cached_all_forms.json');
        if (await file.exists()) {
          await file.delete();
        }
      }
      print('Cache cleared successfully');
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }
}

final getAllformsProviders =
    StateNotifierProvider<GetAllformsProviders, GetAllFormsModel>((ref) {
      return GetAllformsProviders(ref);
    });