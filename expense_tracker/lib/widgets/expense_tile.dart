import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseTile({super.key, required this.expense, required this.onDelete});

  /// Below this width the delete button is hidden (swipe still works).
  static const double _compactWidth = 380;

  String get _formattedDate {
    final date = expense.date;
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(expense),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: const _DeleteBackground(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < _compactWidth;
            return _buildTile(context, isCompact: isCompact);
          },
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, {required bool isCompact}) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 16,
        vertical: 6,
      ),
      leading: CircleAvatar(
        backgroundColor: expense.category.color.withValues(alpha: 0.15),
        child: Icon(expense.category.icon, color: expense.category.color),
      ),
      title: Text(
        expense.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '${expense.category.label} • $_formattedDate',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₱${expense.amount.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (!isCompact)
            IconButton(
              tooltip: 'Delete',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
    );
  }
}

/// Red background shown while swiping a tile to delete it.
class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.delete_rounded, color: Colors.white),
    );
  }
}
