import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyExpensesView extends StatelessWidget {
  const EmptyExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 50,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'No expenses found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another category or add a new expense.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
