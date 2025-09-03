import 'package:flutter/material.dart';
import 'service_card.dart';

class ServicesGrid extends StatelessWidget {
  final VoidCallback? onPflegestufeTap;

  const ServicesGrid({super.key, this.onPflegestufeTap});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        // Termine
        const ServiceCard(
          icon: Icons.home_outlined,
          title: 'Termine',
          isActive: false,
        ),
        // Ambulante Behandlung
        const ServiceCard(
          icon: Icons.accessibility_new,
          title: 'Ambulante\nBehandlung',
          isActive: false,
        ),
        // Stationäre Pflege
        const ServiceCard(
          icon: Icons.business,
          title: 'Stationäre\nPflege',
          isActive: false,
        ),
        // Pflegeheim
        const ServiceCard(
          icon: Icons.home_work,
          title: 'Pflegeheim',
          isActive: false,
        ),
        // Pflegestufe (Çalışan buton)
        ServiceCard(
          icon: Icons.trending_up,
          title: 'Pflegestufe',
          isActive: true,
          onTap: onPflegestufeTap,
        ),
        // Pflegekraft
        const ServiceCard(
          icon: Icons.medical_services,
          title: 'Pflegekraft',
          isActive: false,
        ),
      ],
    );
  }
}
