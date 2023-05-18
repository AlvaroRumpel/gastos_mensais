import '../../models/expense_model.dart';

extension MoneyParse on double {
  String toMoney() {
    String initalValue = toStringAsFixed(2).replaceFirst('.', ',');
    return initalValue;
  }
}

extension ListSumExpenseValue on List<ExpenseModel> {
  double toSumExpenseValue() {
    double sum = 0.0;
    for (ExpenseModel item in this) {
      sum += item.expenseValue;
    }
    return sum;
  }
}
