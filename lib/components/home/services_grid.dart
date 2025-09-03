import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';
import 'service_card.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: ResponsiveUtils.isMobile(context) ? 3 : 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ServiceCard(
          title: 'Termine',
          icon: Icons.home_outlined,
          isActive: false,
        ),
        ServiceCard(
          title: 'Ambulante\nBehandlung',
          icon: Icons.accessibility_new,
          isActive: false,
        ),
        ServiceCard(
          title: 'Stationäre\nPflege',
          icon: Icons.business_outlined,
          isActive: false,
        ),
        ServiceCard(
          title: 'Pflegeheim',
          icon: Icons.home_outlined,
          isActive: false,
        ),
        ServiceCard(
          title: 'Pflegestufe',
          icon: Icons.trending_up,
          isActive: true,
        ),
        ServiceCard(
          title: 'Pflegekraft',
          icon: Icons.local_drink_outlined,
          isActive: false,
        ),
      ],
    );
  }
}
