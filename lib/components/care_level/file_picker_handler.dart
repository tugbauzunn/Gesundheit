import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/api_service.dart';
import '../../theme/app_colors.dart';

class FilePickerHandler {
  static Future<Map<String, dynamic>> selectPdfFile({
    required BuildContext context,
    required Function(bool) setUploading,
    required Function(String, String) onFileSelected,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.single;

        setUploading(true);

        final uploadResult = await ApiService.uploadPdfFile(
          file.bytes!,
          file.name,
        );

        if (uploadResult['success'] == true) {
          onFileSelected(file.name, uploadResult['data']['file']['id']);
          setUploading(false);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${file.name} auf Server hochgeladen'),
                backgroundColor: AppColors.success,
                duration: const Duration(seconds: 3),
              ),
            );
          }
          return {'success': true};
        } else {
          setUploading(false);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PDF-Upload-Fehler: ${uploadResult['message']}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return {'success': false, 'message': uploadResult['message']};
        }
      }
      return {'success': false, 'message': 'Keine Datei ausgewählt'};
    } catch (e) {
      setUploading(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Auswählen der PDF-Datei: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<void> removePdfFile({
    required String? uploadedPdfId,
    required Function() onFileRemoved,
  }) async {
    if (uploadedPdfId != null) {
      try {
        await ApiService.deletePdfFile(uploadedPdfId);
      } catch (e) {
        // Silme hatası, sessizce devam et
      }
    }
    onFileRemoved();
  }
}
