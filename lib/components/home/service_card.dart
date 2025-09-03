import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../utils/responsive_utils.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        padding: AppStyles.cardPadding(context),
        decoration:
            AppStyles.cardDecoration(
              context,
              backgroundColor: AppColors.homeCardBackground,
            ).copyWith(
              border: Border.all(
                color: AppColors.withAlpha(AppColors.primary, 0.3),
                width: 1,
              ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: ResponsiveUtils.getIconSize(context) + 4,
              color: isActive ? AppColors.homeServiceActive : AppColors.primary,
            ),
            SizedBox(height: ResponsiveUtils.getVerticalSpacing(context) * 0.4),
            Text(
              title,
              style: AppStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.homeServiceActive
                    : AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
