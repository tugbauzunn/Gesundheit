import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/care_level_request.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  /// Bakım düzeyi artış talebini gönder
  static Future<Map<String, dynamic>> submitCareLevelRequest(
      CareLevelRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/care-level-requests'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toCreateJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  /// PDF dosyasını sunucuya yükle
  static Future<Map<String, dynamic>> uploadPdfFile(
      List<int> fileBytes, String fileName) async {
    try {
      final uri = Uri.parse('$baseUrl/upload-pdf');
      final request = http.MultipartRequest('POST', uri);

      // PDF dosyasını ekle
      request.files.add(
        http.MultipartFile.fromBytes(
          'pdf',
          fileBytes,
          filename: fileName,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(responseBody),
        };
      } else {
        return {
          'success': false,
          'message': 'PDF upload failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'PDF upload error: $e',
      };
    }
  }

  /// PDF dosyasını sunucudan sil
  static Future<void> deletePdfFile(String pdfId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pdf/$pdfId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('PDF delete failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF delete error: $e');
    }
  }

  /// Bakım düzeyi taleplerini getir
  static Future<Map<String, dynamic>> getCareLevelRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/care-level-requests'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch requests: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  /// Sunucu sağlık kontrolü
  static Future<bool> checkServerHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// PDF indirme URL'ini al
  static String getPdfDownloadUrl(String pdfId) {
    return '$baseUrl/download/$pdfId';
  }
}
