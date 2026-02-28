import 'package:flutter/material.dart';

class ActivityFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ActivityFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 1,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF1565C0)
                : const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF1565C0),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      )
    );
  }
}
