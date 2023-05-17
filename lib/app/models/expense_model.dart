import 'dart:convert';

import '../core/database/columns_variables_names/columns_variables_names.dart';

class ExpenseModel {
  final int? id;
  String expenseName;
  final double expenseValue;
  final DateTime createDate;
  final DateTime? deleteDate;
  final bool paid;

  ExpenseModel({
    this.id,
    required this.expenseName,
    required this.expenseValue,
    required this.createDate,
    this.deleteDate,
    this.paid = false,
  }) {
    expenseName = expenseName.isEmpty ? 'Without name' : expenseName;
  }

  Map<String, dynamic> toMap() {
    return {
      ExpenseTable.NAME: expenseName,
      ExpenseTable.VALUE: expenseValue,
      ExpenseTable.CREATE_DATE: createDate.toIso8601String(),
      ExpenseTable.DELETED_DATE: deleteDate?.toIso8601String(),
      ExpenseTable.PAID: paid ? 1 : 0,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map[ExpenseTable.ID],
      expenseName: map[ExpenseTable.NAME] ?? '',
      expenseValue: map[ExpenseTable.VALUE]?.toDouble() ?? 0.0,
      createDate: DateTime.parse(map[ExpenseTable.CREATE_DATE]),
      deleteDate: map[ExpenseTable.DELETED_DATE] != null
          ? DateTime.parse(map[ExpenseTable.DELETED_DATE])
          : null,
      paid: map[ExpenseTable.PAID] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  ExpenseModel copyWith({
    int? id,
    String? expenseName,
    double? expenseValue,
    DateTime? createDate,
    DateTime? deleteDate,
    bool? paid,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      expenseName: expenseName ?? this.expenseName,
      expenseValue: expenseValue ?? this.expenseValue,
      createDate: createDate ?? this.createDate,
      deleteDate: deleteDate ?? this.deleteDate,
      paid: paid ?? this.paid,
    );
  }
}
