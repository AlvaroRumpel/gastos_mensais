import 'package:flutter/material.dart';
import 'package:gastos_mensais/models/historic.dart';

class _HistoricNotifier extends ValueNotifier<List<Historic>> {
  _HistoricNotifier(super.value);

  addItem({
    String? name,
    required String value,
  }) {
    value = value.replaceAll(RegExp(r'(R\$) |\.'), '').replaceAll(',', '.');
    this.value.add(
          Historic(
            expenseName: name ?? 'Sem nome',
            expenseValue: double.parse(value),
          ),
        );
    notifyListeners();
  }

  removeItem(int index) {
    value.removeAt(index);
    notifyListeners();
  }
}

final historicNotifier = _HistoricNotifier([]);
