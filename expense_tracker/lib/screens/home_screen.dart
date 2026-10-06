import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import '../widgets/add_expense_sheet.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/common/adaptive_layout.dart';
import '../widgets/common/centered_content.dart';
import '../widgets/expense_list_section.dart';
import '../widgets/total_card.dart';

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

  void _selectCategory(ExpenseCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) {
        return AddExpenseSheet(onAddExpense: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: AdaptiveLayout(
          compact: _buildCompactBody(),
          wide: _buildWideBody(),
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

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  /// Phone portrait: everything in one scrolling column.
  Widget _buildCompactBody() {
    return CenteredContent(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalCard(total: _total),
            const SizedBox(height: 24),
            _buildFilterSection(wrap: false),
            const SizedBox(height: 24),
            _buildExpenseSection(),
          ],
        ),
      ),
    );
  }

  /// Landscape / tablet: summary on the left, list on the right.
  Widget _buildWideBody() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 360,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalCard(total: _total),
                    const SizedBox(height: 24),
                    _buildFilterSection(wrap: true),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 12, 20, 100),
                child: _buildExpenseSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({required bool wrap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by category',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        CategoryFilterBar(
          selectedCategory: _selectedCategory,
          onSelected: _selectCategory,
          wrap: wrap,
        ),
      ],
    );
  }

  Widget _buildExpenseSection() {
    return ExpenseListSection(
      expenses: _filteredExpenses,
      onDelete: _deleteExpense,
    );
  }
}
