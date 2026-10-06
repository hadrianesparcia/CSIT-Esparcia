import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
    this.wrap = false,
  });

  final ExpenseCategory? selectedCategory;
  final ValueChanged<ExpenseCategory?> onSelected;

  /// true = chips wrap onto several lines (wide screens),
  /// false = chips scroll sideways (phones).
  final bool wrap;

  List<Widget> _buildChips() {
    return [
      ChoiceChip(
        label: Text(
          'All',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        selected: selectedCategory == null,
        onSelected: (_) => onSelected(null),
      ),
      for (final category in ExpenseCategory.values)
        ChoiceChip(
          avatar: Icon(category.icon, size: 17, color: category.color),
          label: Text(
            category.label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          selected: selectedCategory == category,
          onSelected: (_) => onSelected(category),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final chips = _buildChips();

    if (wrap) {
      return Wrap(spacing: 8, runSpacing: 8, children: chips);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final chip in chips)
            Padding(padding: const EdgeInsets.only(right: 8), child: chip),
        ],
      ),
    );
  }
}