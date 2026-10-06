import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import 'common/adaptive_dialog.dart';
import 'common/breakpoints.dart';

class AddExpenseSheet extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const AddExpenseSheet({super.key, required this.onAddExpense});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  String get _formattedDate {
    return '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      showAdaptiveMessageDialog(
        context: context,
        title: 'Invalid input',
        message: 'Please enter a title and an amount greater than zero.',
      );
      return;
    }

    final amount = double.parse(_amountController.text.trim());

    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: amount,
        category: _selectedCategory,
        date: _selectedDate,
      ),
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Expense added successfully!',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.tablet;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Expense',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isWide)
                    ..._buildWideFields()
                  else
                    ..._buildCompactFields(),
                  const SizedBox(height: 22),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Phone portrait: one field per row.
  List<Widget> _buildCompactFields() {
    return [
      _buildTitleField(),
      const SizedBox(height: 14),
      _buildAmountField(),
      const SizedBox(height: 14),
      _buildCategoryField(),
      const SizedBox(height: 14),
      _buildDateField(),
    ];
  }

  /// Landscape / tablet: two fields per row.
  List<Widget> _buildWideFields() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildTitleField()),
          const SizedBox(width: 14),
          Expanded(child: _buildAmountField()),
        ],
      ),
      const SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildCategoryField()),
          const SizedBox(width: 14),
          Expanded(child: _buildDateField()),
        ],
      ),
    ];
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Expense title',
        prefixIcon: Icon(Icons.edit_rounded),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a title.';
        }
        return null;
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixIcon: Icon(Icons.payments_rounded),
        prefixText: '₱ ',
      ),
      validator: (value) {
        final amount = double.tryParse(value?.trim() ?? '');
        if (amount == null || amount <= 0) {
          return 'Enter a valid amount.';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField<ExpenseCategory>(
      initialValue: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category_rounded),
      ),
      items: [
        for (final category in ExpenseCategory.values)
          DropdownMenuItem<ExpenseCategory>(
            value: category,
            child: Text(category.label, style: GoogleFonts.poppins()),
          ),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedCategory = value;
          });
        }
      },
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          prefixIcon: Icon(Icons.calendar_month_rounded),
        ),
        child: Text(_formattedDate, style: GoogleFonts.poppins()),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: _submit,
        icon: const Icon(Icons.check_rounded),
        label: Text(
          'Save expense',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
