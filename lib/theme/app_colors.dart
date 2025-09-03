import 'package:flutter/material.dart';

class AppColors {
  // Ana Renkler
  static const Color primary = Color(0xFF4A6FA5);
  static const Color primaryLight = Color(0xFF6B8DD6);
  static const Color primaryDark = Color(0xFF2E4A8E);

  // Metin Renkleri
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textLight = Color(0xFF9CA3AF);

  // Background Renkleri
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF7FAFC);

  // Border Renkleri
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);

  // Status Renkleri
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Acil Durum Renkleri
  static const Color emergency = Color(0xFFB91C1C);
  static const Color emergencyLight = Color(0xFFDC2626);

  // Özel Renkler (Home Screen'den)
  static const Color blueTheme = Color(0xFF2196F3);
  static const Color homeBlue = Color(0xFF173C94);
  static const Color homeBlueSecondary = Color(0xFF3B5595);
  static const Color homeCardBackground = Color(0xFFEBF1FF);
  static const Color homeServiceActive = Color(0xFF1976D2);
  static const Color homeServiceInactive = Color(0xFF7892D2);

  // Notification Renkleri
  static const Color yellowNotification = Color(0xFFDED577);
  static const Color yellowNotificationText = Color(0xFF56521D);
  static const Color yellowNotificationBackground = Color(0xFFF5F2D1);
  static const Color yellowNotificationDot = Color(0xFF6A6634);
  static const Color yellowNotificationItemText = Color(0xFF6D693B);

  static const Color orangeNotification = Color(0xFFE07000);
  static const Color orangeNotificationText = Color(0xFF653607);
  static const Color orangeNotificationBackground = Color(0xFFFFE6CE);
  static const Color orangeNotificationItemText = Color(0xFF865D35);

  // Transparency yardımcıları
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  // Gradient renkler
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
