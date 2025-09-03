import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

// Alt navigasyon çubuğu öğesi widget'ı
class BottomNavItem extends StatelessWidget {
  final IconData icon; // Normal durum ikonu
  final IconData activeIcon; // Seçili durum ikonu
  final String label; // Metin etiketi
  final int index; // Öğe indeksi
  final int selectedIndex; // Seçili öğe indeksi
  final Color activeColor; // Aktif renk
  final Color inactiveColor; // Pasif renk
  final Function(int) onTap; // Dokunma olayı

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final isMobile = ResponsiveUtils.isMobile(context);

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 4 : 8,
          horizontal: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? activeColor : inactiveColor,
              size: ResponsiveUtils.getIconSize(context),
            ),
            SizedBox(height: isMobile ? 2 : 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  fontSize: ResponsiveUtils.getBodyFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
