import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import '../models/care_level_request.dart';
import '../services/api_service.dart';
import '../components/care_level/header_card.dart';
import '../components/care_level/care_level_dropdown.dart';
import '../components/care_level/reason_text_field.dart';
import '../components/care_level/pdf_upload_field.dart';
import '../components/care_level/submit_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../utils/responsive_utils.dart';

class CareLevelRequestScreen extends StatefulWidget {
  const CareLevelRequestScreen({super.key});

  @override
  State<CareLevelRequestScreen> createState() => _CareLevelRequestScreenState();
}

class _CareLevelRequestScreenState extends State<CareLevelRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();

  int? _currentLevel;
  int? _desiredLevel;
  bool _isSubmitting = false;
  String? _selectedFileName;
  bool _isUploading = false;
  String? _uploadedPdfId;

  final List<int> _careLevels = [1, 2, 3, 4, 5];
  final Map<int, String> _levelDescriptions = {
    1: 'Pflegegrad 1 - Geringe Beeinträchtigung (Az Bağımlılık)',
    2: 'Pflegegrad 2 - Erhebliche Beeinträchtigung (Orta Bağımlılık)',
    3: 'Pflegegrad 3 - Schwere Beeinträchtigung (Ağır Bağımlılık)',
    4: 'Pflegegrad 4 - Schwerste Beeinträchtigung (Çok Ağır Bağımlılık)',
    5: 'Pflegegrad 5 - Schwerste Beeinträchtigung mit besonderen Anforderungen (Özel Bakım)',
  };

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectPdfFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.single;

        setState(() {
          _isUploading = true;
        });

        final uploadResult = await ApiService.uploadPdfFile(
          file.bytes!,
          file.name,
        );

        if (uploadResult['success'] == true) {
          setState(() {
            _selectedFileName = file.name;
            _uploadedPdfId = uploadResult['data']['file']['id'];
            _isUploading = false;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${file.name} auf Server hochgeladen'),
                backgroundColor: AppColors.success,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } else {
          setState(() {
            _isUploading = false;
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('PDF-Upload-Fehler: ${uploadResult['message']}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Auswählen der PDF-Datei: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _removePdfFile() async {
    if (_uploadedPdfId != null) {
      try {
        await ApiService.deletePdfFile(_uploadedPdfId!);
      } catch (e) {
        // Fehler beim Löschen der PDF vom Server
        // print('Fehler beim Löschen der PDF vom Server: $e'); // Remove print for production
      }
    }

    setState(() {
      _selectedFileName = null;
      _uploadedPdfId = null;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_desiredLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte wählen Sie den gewünschten Pflegegrad aus'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = CareLevelRequest(
        id: const Uuid().v4(),
        currentLevel: _currentLevel ?? 0,
        desiredLevel: _desiredLevel!,
        reason: _reasonController.text.trim(),
        createdAt: DateTime.now(),
        attachedPdfId: _uploadedPdfId,
      );

      final result = await ApiService.submitCareLevelRequest(request);

      if (result['success']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Antrag erfolgreich gesendet'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Antragsfehler: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          ResponsiveUtils.isMobile(context)
              ? 'Pflegegrad'
              : 'Pflegegrad Erhöhung',
          style: TextStyle(
            fontSize: ResponsiveUtils.isMobile(context) ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: ResponsiveUtils.isMobile(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          iconSize: ResponsiveUtils.isMobile(context) ? 22 : 24,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getHorizontalPadding(context),
            vertical: ResponsiveUtils.isMobile(context) ? 12 : 16,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.isTablet(context)
                  ? 800
                  : double.infinity,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeaderCard(
                    title: ResponsiveUtils.isMobile(context)
                        ? 'Pflegegrad Antrag'
                        : 'Pflegegrad Erhöhung Antrag',
                    subtitle: ResponsiveUtils.isMobile(context)
                        ? 'Pflegegrad erhöhen'
                        : 'Beantragen Sie eine Erhöhung Ihres Pflegegrades',
                    icon: Icons.trending_up,
                  ),
                  SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),
                  Container(
                    width: double.infinity,
                    padding: AppStyles.cardPadding(context),
                    decoration: AppStyles.cardDecoration(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CareLevelDropdown(
                          label: 'Aktueller Pflegegrad',
                          value: _currentLevel,
                          items: _careLevels,
                          descriptions: _levelDescriptions,
                          onChanged: (value) {
                            setState(() {
                              _currentLevel = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Bitte wählen Sie den aktuellen Pflegegrad aus';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ResponsiveUtils.getVerticalSpacing(context),
                        ),
                        CareLevelDropdown(
                          label: 'Gewünschter Pflegegrad',
                          value: _desiredLevel,
                          items: _careLevels
                              .where(
                                (level) =>
                                    _currentLevel == null ||
                                    level > _currentLevel!,
                              )
                              .toList(),
                          descriptions: _levelDescriptions,
                          onChanged: (value) {
                            setState(() {
                              _desiredLevel = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Bitte wählen Sie den gewünschten Pflegegrad aus';
                            }
                            if (_currentLevel != null &&
                                value <= _currentLevel!) {
                              return 'Der gewünschte Grad muss höher als der aktuelle sein';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ResponsiveUtils.getVerticalSpacing(context),
                        ),
                        ReasonTextField(controller: _reasonController),
                        SizedBox(
                          height: ResponsiveUtils.getVerticalSpacing(context),
                        ),
                        PdfUploadField(
                          selectedFileName: _selectedFileName,
                          uploadedPdfId: _uploadedPdfId,
                          isUploading: _isUploading,
                          onSelectFile: _selectPdfFile,
                          onRemoveFile: _removePdfFile,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveUtils.getVerticalSpacing(context) + 8,
                  ),
                  SubmitButton(
                    isSubmitting: _isSubmitting,
                    onPressed: _submitForm,
                    text: 'Antrag senden',
                  ),
                  // Bottom padding for safe scrolling
                  SizedBox(height: ResponsiveUtils.isMobile(context) ? 20 : 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
