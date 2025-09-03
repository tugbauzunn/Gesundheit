import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive_utils.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopBar(context),
        SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),
        _buildWelcomeText(context),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: ResponsiveUtils.getButtonHeight(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.homeBlueSecondary),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: ResponsiveUtils.getHorizontalPadding(context),
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppColors.homeBlueSecondary,
                    size: ResponsiveUtils.getIconSize(context),
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildIconButton(context, Icons.notifications_none),
        const SizedBox(width: 12),
        _buildIconButton(context, Icons.mail_outline),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon) {
    return Container(
      width: ResponsiveUtils.getButtonHeight(context),
      height: ResponsiveUtils.getButtonHeight(context),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.homeBlueSecondary),
      ),
      child: Icon(
        icon,
        color: AppColors.homeBlueSecondary,
        size: ResponsiveUtils.getIconSize(context),
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hallo,',
          style: TextStyle(
            fontSize: ResponsiveUtils.getTitleFontSize(context) + 8,
            fontWeight: FontWeight.bold,
            color: AppColors.homeBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Wie kann ich Ihnen heute helfen?',
          style: TextStyle(
            fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
            color: AppColors.homeBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '15.08.2025',
          style: TextStyle(
            fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
