import 'package:flutter/material.dart';
import '../../theme/app_styles.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive_utils.dart';

class ReasonTextField extends StatelessWidget {
  final TextEditingController controller;

  const ReasonTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Begründung', style: AppStyles.headingSmall(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: ResponsiveUtils.isSmallMobile(context) ? 4 : 5,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          decoration:
              AppStyles.textFieldDecoration(
                context,
                hintText: ResponsiveUtils.isMobile(context)
                    ? 'Erklären Sie Ihre Begründung für die Pflegegrad-Erhöhung...'
                    : 'Erklären Sie detailliert Ihre Begründung für die Pflegegrad-Erhöhung...',
              ).copyWith(
                counterText: '',
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getSmallBorderRadius(context),
                  ),
                  borderSide: BorderSide(color: AppColors.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getSmallBorderRadius(context),
                  ),
                  borderSide: BorderSide(color: AppColors.error),
                ),
              ),
          style: AppStyles.bodyLarge(context),
          maxLength: 500,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Bitte geben Sie eine Begründung ein';
            }
            if (value.trim().length < 20) {
              return 'Die Begründung muss mindestens 20 Zeichen lang sein';
            }
            return null;
          },
        ),
      ],
    );
  }
}
