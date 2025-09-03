import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PdfService {
  static const String baseUrl = 'http://localhost:3000/api';

  /// PDF dosyasını sunucuya yükle
  static Future<Map<String, dynamic>> uploadPdf({
    required PlatformFile file,
    String? requestId,
    String? description,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/upload-pdf');
      final request = http.MultipartRequest('POST', uri);

      // PDF dosyasını ekle
      if (file.bytes != null) {
        // Web için
        request.files.add(
          http.MultipartFile.fromBytes('pdf', file.bytes!, filename: file.name),
        );
      } else if (file.path != null) {
        // Mobile için
        request.files.add(
          await http.MultipartFile.fromPath(
            'pdf',
            file.path!,
            filename: file.name,
          ),
        );
      }

      // Metadata ekle
      if (requestId != null) {
        request.fields['requestId'] = requestId;
      }
      if (description != null) {
        request.fields['description'] = description;
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception('PDF upload failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF upload error: $e');
    }
  }

  /// PDF bilgilerini getir
  static Future<Map<String, dynamic>> getPdfInfo(String pdfId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pdf/$pdfId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('PDF info fetch failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF info error: $e');
    }
  }

  /// PDF dosyasını sil
  static Future<Map<String, dynamic>> deletePdf(String pdfId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pdf/$pdfId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('PDF delete failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF delete error: $e');
    }
  }

  /// PDF download URL'ini al
  static String getPdfDownloadUrl(String pdfId) {
    return '$baseUrl/download/$pdfId';
  }

  /// Tüm PDF'leri listele
  static Future<Map<String, dynamic>> getAllPdfs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pdfs'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('PDF list fetch failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('PDF list error: $e');
    }
  }

  /// Sunucu health check
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
}
