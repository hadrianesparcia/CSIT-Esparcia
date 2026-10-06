import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 10),
            color: colorScheme.primary.withValues(alpha: 0.20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total expenses',
            style: GoogleFonts.poppins(
              color: colorScheme.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: Text(
              '₱${total.toStringAsFixed(2)}',
              key: ValueKey(total),
              style: GoogleFonts.poppins(
                color: colorScheme.onPrimary,
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Keep track of where your money goes.',
            style: GoogleFonts.poppins(
              color: colorScheme.onPrimary.withValues(alpha: 0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}