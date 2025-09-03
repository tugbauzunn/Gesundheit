import 'package:health/screens/simple_home_screen.dart';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const HealthCareApp());
}

class HealthCareApp extends StatelessWidget {
  const HealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakım Düzeyi Artışı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.blueTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blueTheme,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blueTheme,
          foregroundColor: AppColors.cardBackground,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueTheme,
            foregroundColor: AppColors.cardBackground,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const SimpleHomeScreen(), // Simple Home Screen kullan
      debugShowCheckedModeBanner: false,
    );
  }
}
