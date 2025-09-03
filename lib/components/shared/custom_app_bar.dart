import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        ResponsiveUtils.isMobile(context) ? title.split(' ').first : title,
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
        onPressed: onBackPressed ?? () => Navigator.pop(context),
        iconSize: ResponsiveUtils.isMobile(context) ? 22 : 24,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
