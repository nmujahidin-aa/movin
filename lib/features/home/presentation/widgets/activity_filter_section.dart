import 'package:flutter/material.dart';
import 'activity_filter_chip.dart';

class ActivityFilterSection extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onChanged;

  const ActivityFilterSection({
    super.key,
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return ActivityFilterChip(
            label: category,
            selected: selected == category,
            onTap: () => onChanged(category),
          );
        },
      ),
    );
  }
}
