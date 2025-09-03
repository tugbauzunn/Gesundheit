import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/care_level_request.dart';
import '../../services/api_service.dart';
import '../../theme/app_colors.dart';

class FormSubmissionHandler {
  static Future<void> submitCareLevelRequest({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required int? currentLevel,
    required int? desiredLevel,
    required String reason,
    required String? uploadedPdfId,
    required Function(bool) setSubmitting,
    required VoidCallback onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (desiredLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte wählen Sie den gewünschten Pflegegrad aus'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setSubmitting(true);

    try {
      final request = CareLevelRequest(
        id: const Uuid().v4(),
        currentLevel: currentLevel ?? 0,
        desiredLevel: desiredLevel,
        reason: reason.trim(),
        createdAt: DateTime.now(),
        attachedPdfId: uploadedPdfId,
      );

      final result = await ApiService.submitCareLevelRequest(request);

      if (result['success']) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Antrag erfolgreich gesendet'),
              backgroundColor: AppColors.success,
            ),
          );
          onSuccess();
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result['message'] ?? 'Fehler beim Senden des Antrags',
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Antragsfehler: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (context.mounted) {
        setSubmitting(false);
      }
    }
  }
}
