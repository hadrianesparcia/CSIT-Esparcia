import 'package:expense_tracker/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Expense Tracker home screen loads', (tester) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    await tester.pump();

    expect(find.text('Expense Tracker'), findsOneWidget);

    expect(find.text('Total expenses'), findsOneWidget);

    expect(find.text('Add expense'), findsOneWidget);
  });
}
