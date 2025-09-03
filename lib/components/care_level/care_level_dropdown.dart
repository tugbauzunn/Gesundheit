import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../utils/responsive_utils.dart';

class CareLevelDropdown extends StatelessWidget {
  final String label;
  final int? value;
  final List<int> items;
  final Map<int, String> descriptions;
  final Function(int?) onChanged;
  final String? Function(int?)? validator;

  const CareLevelDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.descriptions,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.headingSmall(context)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          initialValue: value,
          isExpanded: true,
          decoration: AppStyles.textFieldDecoration(
            context,
            hintText: ResponsiveUtils.isMobile(context)
                ? 'Auswählen'
                : 'Pflegegrad auswählen',
          ),
          items: items.map((level) {
            final description = descriptions[level]!;
            final displayText = ResponsiveUtils.isMobile(context)
                ? 'Pflegegrad $level'
                : description;

            return DropdownMenuItem<int>(
              value: level,
              child: Text(
                displayText,
                style: AppStyles.bodyMedium(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
          dropdownColor: AppColors.cardBackground,
          style: AppStyles.bodyMedium(context),
        ),
      ],
    );
  }
}
