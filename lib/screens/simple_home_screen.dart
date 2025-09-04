import 'package:flutter/material.dart';
import 'care_level_request_screen.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_utils.dart';

class SimpleHomeScreen extends StatelessWidget {
  const SimpleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              ResponsiveUtils.getHorizontalPadding(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arama Çubuğu ve Simgeler
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: ResponsiveUtils.getButtonHeight(context),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.homeBlueSecondary,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: ResponsiveUtils.getHorizontalPadding(
                                  context,
                                ),
                              ),
                              child: Icon(
                                Icons.search,
                                color: AppColors.homeBlueSecondary,
                                size: ResponsiveUtils.getIconSize(context),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical:
                                        ResponsiveUtils.getVerticalPadding(
                                          context,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: ResponsiveUtils.getButtonHeight(context),
                      height: ResponsiveUtils.getButtonHeight(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.homeBlueSecondary),
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        color: AppColors.homeBlueSecondary,
                        size: ResponsiveUtils.getIconSize(context),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: ResponsiveUtils.getButtonHeight(context),
                      height: ResponsiveUtils.getButtonHeight(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.homeBlueSecondary),
                      ),
                      child: Icon(
                        Icons.mail_outline,
                        color: AppColors.homeBlueSecondary,
                        size: ResponsiveUtils.getIconSize(context),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),

                // Karşılama
                Text(
                  'Hallo,',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getTitleFontSize(context) + 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.homeBlue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Wie kann ich Ihnen heute helfen?',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
                    color: AppColors.homeBlue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '15.08.2025',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
                    color: Colors.grey.shade600,
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),

                // Servisler Grid
                GridView.count(
                  crossAxisCount: ResponsiveUtils.isMobile(context) ? 3 : 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildServiceCard(
                      context,
                      'Termine',
                      Icons.home_outlined,
                      false,
                    ),
                    _buildServiceCard(
                      context,
                      'Ambulante\nBehandlung',
                      Icons.accessibility_new,
                      false,
                    ),
                    _buildServiceCard(
                      context,
                      'Stationäre\nPflege',
                      Icons.business_outlined,
                      false,
                    ),
                    _buildServiceCard(
                      context,
                      'Pflegeheim',
                      Icons.home_outlined,
                      false,
                    ),
                    _buildServiceCard(
                      context,
                      'Pflegestufe',
                      Icons.trending_up,
                      true,
                    ),
                    _buildServiceCard(
                      context,
                      'Pflegekraft',
                      Icons.local_drink_outlined,
                      false,
                    ),
                  ],
                ),

                SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),

                // Laufende Transaktionen
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    ResponsiveUtils.getCardPadding(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.yellowNotification,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Laufende Transaktionen',
                        style: TextStyle(
                          fontSize:
                              ResponsiveUtils.getBodyFontSize(context) + 2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.yellowNotificationText,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.yellowNotificationBackground,
                          borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getSmallBorderRadius(context),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.yellowNotificationDot,
                              size: 8,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Dr. .........Termin',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.getBodyFontSize(
                                    context,
                                  ),
                                  color: AppColors.yellowNotificationItemText,
                                ),
                              ),
                            ),
                            Text(
                              '17:00',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.getBodyFontSize(
                                  context,
                                ),
                                color: AppColors.yellowNotificationItemText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Erinnerung
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    ResponsiveUtils.getCardPadding(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.orangeNotification,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Erinnerung',
                        style: TextStyle(
                          fontSize:
                              ResponsiveUtils.getBodyFontSize(context) + 2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orangeNotificationText,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.orangeNotificationBackground,
                          borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getSmallBorderRadius(context),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.orangeNotification,
                              size: 8,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Wechsel der Bezugsperson',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.getBodyFontSize(
                                    context,
                                  ),
                                  color: AppColors.orangeNotificationItemText,
                                ),
                              ),
                            ),
                            Text(
                              '18:00',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.getBodyFontSize(
                                  context,
                                ),
                                color: AppColors.orangeNotificationItemText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.orangeNotificationBackground,
                          borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getSmallBorderRadius(context),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppColors.orangeNotification,
                              size: 8,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Medizinzeit',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.getBodyFontSize(
                                    context,
                                  ),
                                  color: AppColors.orangeNotificationItemText,
                                ),
                              ),
                            ),
                            Text(
                              '19:30',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.getBodyFontSize(
                                  context,
                                ),
                                color: AppColors.orangeNotificationItemText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Startseite'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Anruf'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: AppColors.emergency,
              radius: 35,
              child: Text(
                'Dringend',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveUtils.getBodyFontSize(context),
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Nachrichten',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        selectedItemColor: AppColors.homeBlueSecondary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pflegestufe') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CareLevelRequestScreen(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.homeCardBackground,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context),
          ),
          border: Border.all(
            color: isActive
                ? AppColors.homeServiceActive
                : AppColors.homeServiceInactive,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ResponsiveUtils.getButtonHeight(context) * 0.8,
              height: ResponsiveUtils.getButtonHeight(context) * 0.8,
              decoration: BoxDecoration(
                color:
                    (isActive ? AppColors.homeServiceActive : AppColors.primary)
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getSmallBorderRadius(context),
                ),
              ),
              child: Icon(
                icon,
                color: isActive
                    ? AppColors.homeServiceActive
                    : AppColors.primary,
                size: ResponsiveUtils.getIconSize(context),
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getBodyFontSize(context),
                fontWeight: FontWeight.bold,
                color: isActive
                    ? AppColors.homeServiceActive
                    : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
