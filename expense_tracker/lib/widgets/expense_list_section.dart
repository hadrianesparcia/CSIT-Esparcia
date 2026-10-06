import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import 'empty_expenses_view.dart';
import 'expense_tile.dart';

class ExpenseListSection extends StatelessWidget {
  const ExpenseListSection({
    super.key,
    required this.expenses,
    required this.onDelete,
  });

  final List<Expense> expenses;
  final ValueChanged<Expense> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent expenses',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${expenses.length} item(s)',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (expenses.isEmpty)
          const EmptyExpensesView()
        else
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Column(
              key: ValueKey(expenses.length),
              children: [
                for (final expense in expenses)
                  ExpenseTile(
                    expense: expense,
                    onDelete: () => onDelete(expense),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
