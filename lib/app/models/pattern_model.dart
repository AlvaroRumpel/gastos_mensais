import 'dart:convert';

import '../core/database/columns_variables_names/columns_variables_names.dart';
import 'expense_model.dart';

class PatternModel {
  final int? id;
  final String name;
  List<int>? expensesId;
  final DateTime createDate;
  final DateTime? deletedDate;
  List<ExpenseModel>? expenses;

  PatternModel({
    this.id,
    required this.name,
    this.expensesId,
    required this.createDate,
    this.deletedDate,
    this.expenses,
  });

  Map<String, dynamic> toMap() {
    return {
      PatternsTable.ID: id,
      PatternsTable.NAME: name,
      PatternsTable.EXPENSES_ID:
          expenses?.map((x) => x.id).toList().join(',') ?? expensesId,
      PatternsTable.CREATE_DATE: createDate.toIso8601String(),
      PatternsTable.DELETED_DATE: deletedDate?.toIso8601String(),
    };
  }

  factory PatternModel.fromMap(Map<String, dynamic> map) {
    return PatternModel(
      id: map[PatternsTable.ID]?.toInt(),
      name: map[PatternsTable.NAME] ?? '',
      expensesId: (map[PatternsTable.EXPENSES_ID] as String)
          .split(',')
          .map<int>((e) => int.parse(e))
          .toList(),
      createDate: DateTime.parse(map[PatternsTable.CREATE_DATE]),
      deletedDate: map[PatternsTable.DELETED_DATE] != null
          ? DateTime.parse(map[PatternsTable.DELETED_DATE])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatternModel.fromJson(String source) =>
      PatternModel.fromMap(json.decode(source));

  PatternModel copyWith({
    int? id,
    String? name,
    List<int>? expensesId,
    DateTime? createDate,
    DateTime? deletedDate,
    List<ExpenseModel>? expenses,
  }) {
    return PatternModel(
      id: id ?? this.id,
      name: name ?? this.name,
      expensesId: expensesId ?? this.expensesId,
      createDate: createDate ?? this.createDate,
      deletedDate: deletedDate ?? this.deletedDate,
      expenses: expenses ?? this.expenses,
    );
  }
}
