import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../utils/responsive_utils.dart';

class PdfUploadField extends StatelessWidget {
  final String? selectedFileName;
  final String? uploadedPdfId;
  final bool isUploading;
  final VoidCallback onSelectFile;
  final VoidCallback onRemoveFile;

  const PdfUploadField({
    super.key,
    required this.selectedFileName,
    required this.uploadedPdfId,
    required this.isUploading,
    required this.onSelectFile,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ResponsiveUtils.isMobile(context)
              ? 'Dokumente (PDF)'
              : 'Unterstützende Dokumente (PDF)',
          style: AppStyles.headingSmall(context),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: AppColors.lightBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getSmallBorderRadius(context),
            ),
          ),
          child: _buildUploadContent(context),
        ),
      ],
    );
  }

  Widget _buildUploadContent(BuildContext context) {
    if (selectedFileName != null) {
      return _buildSelectedFileView(context);
    } else {
      return _buildUploadButton(context);
    }
  }

  Widget _buildSelectedFileView(BuildContext context) {
    return Container(
      padding: AppStyles.cardPadding(context) * 0.7,
      decoration: BoxDecoration(
        color: AppColors.withAlpha(AppColors.primary, 0.1),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getSmallBorderRadius(context) * 0.7,
        ),
        border: Border.all(color: AppColors.withAlpha(AppColors.primary, 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.picture_as_pdf,
            color: AppColors.primary,
            size: ResponsiveUtils.getIconSize(context) * 0.85,
          ),
          SizedBox(width: ResponsiveUtils.getHorizontalPadding(context) * 0.75),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedFileName!,
                  style: AppStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                  maxLines: ResponsiveUtils.isMobile(context) ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  uploadedPdfId != null
                      ? 'PDF hochgeladen ✓'
                      : 'Wird hochgeladen...',
                  style: AppStyles.bodySmall(context).copyWith(
                    color: uploadedPdfId != null
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: isUploading ? null : onRemoveFile,
            icon: Icon(
              Icons.close,
              color: AppColors.textSecondary,
              size: ResponsiveUtils.getIconSize(context) * 0.7,
            ),
            constraints: BoxConstraints(
              minWidth: ResponsiveUtils.isSmallMobile(context) ? 32 : 36,
              minHeight: ResponsiveUtils.isSmallMobile(context) ? 32 : 36,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : onSelectFile,
      child: Container(
        width: double.infinity,
        padding: AppStyles.cardPadding(context),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.withAlpha(AppColors.primary, 0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getSmallBorderRadius(context),
          ),
          color: AppColors.lightBackground,
        ),
        child: Column(
          children: [
            if (isUploading)
              SizedBox(
                width: ResponsiveUtils.getIconSize(context) * 1.5,
                height: ResponsiveUtils.getIconSize(context) * 1.5,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 3,
                ),
              )
            else ...[
              Icon(
                Icons.cloud_upload_outlined,
                size: ResponsiveUtils.getIconSize(context) * 1.7,
                color: AppColors.withAlpha(AppColors.primary, 0.7),
              ),
              SizedBox(
                height: ResponsiveUtils.getVerticalSpacing(context) * 0.6,
              ),
              Text(
                ResponsiveUtils.isMobile(context)
                    ? 'PDF wählen'
                    : 'PDF-Dokument wählen',
                style: AppStyles.headingSmall(context),
              ),
              SizedBox(height: ResponsiveUtils.isMobile(context) ? 2 : 4),
              Text(
                ResponsiveUtils.isMobile(context)
                    ? 'PDF-Datei auswählen (Max 10MB)'
                    : 'Klicken Sie, um eine PDF-Datei auszuwählen (Maximal 10MB)',
                textAlign: TextAlign.center,
                style: AppStyles.bodySmall(context).copyWith(
                  color: AppColors.withAlpha(AppColors.textSecondary, 0.8),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
