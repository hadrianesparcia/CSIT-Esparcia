import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyExpensesView extends StatelessWidget {
  const EmptyExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'No expenses found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap "Add expense" to create one.',
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}