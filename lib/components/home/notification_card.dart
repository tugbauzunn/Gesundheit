import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/responsive_utils.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color itemBackgroundColor;
  final Color dotColor;
  final Color itemTextColor;
  final List<NotificationItem> items;

  const NotificationCard({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.itemBackgroundColor,
    required this.dotColor,
    required this.itemTextColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveUtils.getCardPadding(context)),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 12),
          ...items.map((item) => _buildNotificationItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveUtils.getBodyFontSize(context) + 2,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, NotificationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: itemBackgroundColor,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getSmallBorderRadius(context),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.circle, color: dotColor, size: 8),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.text,
                style: TextStyle(
                  fontSize: ResponsiveUtils.getBodyFontSize(context),
                  color: itemTextColor,
                ),
              ),
            ),
            Text(
              item.time,
              style: TextStyle(
                fontSize: ResponsiveUtils.getBodyFontSize(context),
                color: itemTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String text;
  final String time;

  const NotificationItem({required this.text, required this.time});
}

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationCard(
          title: 'Laufende Transaktionen',
          backgroundColor: AppColors.yellowNotification,
          textColor: AppColors.yellowNotificationText,
          itemBackgroundColor: AppColors.yellowNotificationBackground,
          dotColor: AppColors.yellowNotificationDot,
          itemTextColor: AppColors.yellowNotificationItemText,
          items: const [
            NotificationItem(text: 'Dr. .........Termin', time: '17:00'),
          ],
        ),
        const SizedBox(height: 16),
        NotificationCard(
          title: 'Erinnerung',
          backgroundColor: AppColors.orangeNotification,
          textColor: AppColors.orangeNotificationText,
          itemBackgroundColor: AppColors.orangeNotificationBackground,
          dotColor: AppColors.orangeNotification,
          itemTextColor: AppColors.orangeNotificationItemText,
          items: const [
            NotificationItem(text: 'Wechsel der Bezugsperson', time: '18:00'),
            NotificationItem(text: 'Medizinzeit', time: '19:30'),
          ],
        ),
      ],
    );
  }
}
