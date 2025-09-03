import 'package:flutter/material.dart';
import 'bottom_nav_item.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive_utils.dart';

// Özel alt navigasyon çubuğu widget'ı
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex; // Seçili öğe indeksi
  final Function(int) onTap; // Dokunma olayı fonksiyonu

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isSmallMobile = ResponsiveUtils.isSmallMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: isSmallMobile ? 75 : (isMobile ? 85 : 95),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getHorizontalPadding(context),
            vertical: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Eşit dağıtım
            children: [
              // Ana Sayfa
              Expanded(
                child: BottomNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Startseite',
                  index: 0,
                  selectedIndex: selectedIndex,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primary,
                  onTap: onTap,
                ),
              ),
              // Arama
              Expanded(
                child: BottomNavItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search,
                  label: 'Suche',
                  index: 1,
                  selectedIndex: selectedIndex,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primary,
                  onTap: onTap,
                ),
              ),
              // Acil Durum (Orta buton)
              Container(
                width: isSmallMobile ? 65 : (isMobile ? 80 : 100),
                height: isSmallMobile ? 65 : (isMobile ? 80 : 100),
                decoration: BoxDecoration(
                  color: AppColors.emergency,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emergency.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dringend',
                      style: TextStyle(
                        color: AppColors.cardBackground,
                        fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Mesajlar
              Expanded(
                child: BottomNavItem(
                  icon: Icons.chat_bubble_outline,
                  activeIcon: Icons.chat_bubble,
                  label: isSmallMobile ? 'Chat' : 'Nachrichten',
                  index: 3,
                  selectedIndex: selectedIndex,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primary,
                  onTap: onTap,
                ),
              ),
              // Profil
              Expanded(
                child: BottomNavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profil',
                  index: 4,
                  selectedIndex: selectedIndex,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primary,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
