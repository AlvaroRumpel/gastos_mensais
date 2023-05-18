import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import './expenses_repository.dart';
import '../core/database/columns_variables_names/columns_variables_names.dart';
import '../core/database/sqlite_connection_factory.dart';
import '../core/exceptions/expense_exception.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  ExpensesRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<int> addExpense(Map<String, dynamic> expense) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      var response = await conn.insert(
        ExpenseTable.EXPENSES,
        expense,
      );

      if (response > 0) {
        log('Despesa adicionada com sucesso');
      }

      return response;
    } on ArgumentError catch (e, s) {
      throw ExpenseException(
        message: 'Error to add a expense',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao adicionar uma despesa', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Map<String, Object?>>> findAllExpenses() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      var response = await conn.query(
        ExpenseTable.EXPENSES,
        where: '${ExpenseTable.DELETED_DATE} is null',
      );
      return response;
    } on DatabaseException catch (e, s) {
      throw ExpenseException(
        message: 'Error to search the expenses',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao buscar as despesas', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeExpense(int id) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      var response = await conn.update(
        ExpenseTable.EXPENSES,
        {
          ExpenseTable.DELETED_DATE: DateTime.now().toIso8601String(),
        },
        where: '${ExpenseTable.ID} = ?',
        whereArgs: [id],
      );

      if (response > 0) {
        log('Despesa deletada com sucesso');
      }
    } on ArgumentError catch (e, s) {
      throw ExpenseException(
        message: 'Error to delete a expense',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao deletar uma despesa', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateExpense(Map<String, dynamic> expense, int id) async {
    try {
      var conn = await _sqliteConnectionFactory.openConnection();
      var response = await conn.update(
        ExpenseTable.EXPENSES,
        expense,
        where: '${ExpenseTable.ID} = ?',
        whereArgs: [id],
      );

      if (response > 0) {
        log('Despesa atualizada com sucesso');
      }
    } on ArgumentError catch (e, s) {
      throw ExpenseException(
        message: 'Error to update a expense',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao atualizar uma despesa', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }
}
