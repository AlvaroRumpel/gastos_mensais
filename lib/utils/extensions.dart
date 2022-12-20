import 'package:gastos_mensais/models/historic.dart';

extension MoneyParse on double {
  String toMoney() {
    String initalValue = toStringAsFixed(2).replaceFirst('.', ',');
    return initalValue;
  }
}

extension ListSum on List<Historic> {
  double toListSum() {
    double sum = 0.0;
    for (Historic item in this) {
      sum += item.expenseValue;
    }
    return sum;
  }
}
