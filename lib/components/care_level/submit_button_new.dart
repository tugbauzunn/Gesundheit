import 'package:flutter/material.dart';
import '../../theme/app_styles.dart';
import '../../utils/responsive_utils.dart';

class SubmitButton extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onPressed;
  final String text;

  const SubmitButton({
    super.key,
    required this.isSubmitting,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context),
        ),
        boxShadow: AppStyles.buttonShadow(context),
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: AppStyles.primaryButtonStyle(context),
        child: isSubmitting
            ? SizedBox(
                height: ResponsiveUtils.getLoadingSize(context),
                width: ResponsiveUtils.getLoadingSize(context),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: AppStyles.buttonText(context)),
      ),
    );
  }
}
