import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import '../widgets/add_expense_sheet.dart';
import '../widgets/expense_tile.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Lunch',
      amount: 180,
      category: ExpenseCategory.food,
      date: DateTime(2026, 9, 29),
    ),
    Expense(
      title: 'Jeepney Fare',
      amount: 30,
      category: ExpenseCategory.transport,
      date: DateTime(2026, 9, 29),
    ),
    Expense(
      title: 'School Supplies',
      amount: 250,
      category: ExpenseCategory.shopping,
      date: DateTime(2026, 9, 28),
    ),
  ];

  ExpenseCategory? _selectedCategory;

  double get _total {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  List<Expense> get _filteredExpenses {
    if (_selectedCategory == null) {
      return _expenses;
    }

    return _expenses
        .where((expense) => expense.category == _selectedCategory)
        .toList();
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.insert(0, expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final index = _expenses.indexOf(expense);

    setState(() {
      _expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} deleted', style: GoogleFonts.poppins()),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return AddExpenseSheet(onAddExpense: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Tracker',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Manage your daily spending',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: widget.onThemeToggle,
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalCard(colorScheme),
                const SizedBox(height: 24),
                Text(
                  'Filter by category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _buildCategoryFilters(),
                const SizedBox(height: 24),
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
                      '${_filteredExpenses.length} item(s)',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_filteredExpenses.isEmpty)
                  const EmptyState()
                else
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      key: ValueKey(_filteredExpenses.length),
                      children: _filteredExpenses.map((expense) {
                        return ExpenseTile(
                          expense: expense,
                          onDelete: () => _deleteExpense(expense),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddExpenseSheet,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'Add expense',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTotalCard(ColorScheme colorScheme) {
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
              '₱${_total.toStringAsFixed(2)}',
              key: ValueKey(_total),
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

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ChoiceChip(
            label: Text(
              'All',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            selected: _selectedCategory == null,
            onSelected: (_) {
              setState(() {
                _selectedCategory = null;
              });
            },
          ),
          const SizedBox(width: 8),
          ...ExpenseCategory.values.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                avatar: Icon(category.icon, size: 17, color: category.color),
                label: Text(
                  category.label,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                selected: _selectedCategory == category,
                onSelected: (_) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
