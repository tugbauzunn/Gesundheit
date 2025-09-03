import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../utils/responsive_utils.dart';

class HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const HeaderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppStyles.cardPadding(context),
      decoration: AppStyles.cardDecoration(context),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              ResponsiveUtils.getHorizontalPadding(context) * 0.75,
            ),
            decoration: BoxDecoration(
              color: AppColors.withAlpha(AppColors.primary, 0.1),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getHorizontalPadding(context) * 0.75,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: ResponsiveUtils.getIconSize(context),
            ),
          ),
          SizedBox(width: ResponsiveUtils.getHorizontalPadding(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.headingMedium(context),
                  maxLines: ResponsiveUtils.isMobile(context) ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveUtils.isMobile(context) ? 2 : 4),
                Text(
                  subtitle,
                  style: AppStyles.bodyMedium(context),
                  maxLines: ResponsiveUtils.isMobile(context) ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
