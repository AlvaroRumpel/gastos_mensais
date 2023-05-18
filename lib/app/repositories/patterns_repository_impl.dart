import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import './patterns_repository.dart';
import '../core/database/columns_variables_names/columns_variables_names.dart';
import '../core/database/sqlite_connection_factory.dart';
import '../core/dtos/pattern_and_expense_dto.dart';
import '../core/exceptions/expense_exception.dart';

class PatternsRepositoryImpl implements PatternsRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  PatternsRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<int> addPattern(Map<String, dynamic> pattern) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      var response = await conn.insert(
        PatternsTable.PATTERNS,
        pattern,
      );

      if (response > 0) {
        log('Padrão adicionado com sucesso');
      }

      return response;
    } on ArgumentError catch (e, s) {
      throw ExpenseException(
        message: 'Error to create a pattern',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao criar um padrão', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }

  @override
  Future<PatternAndExpenseDto> findAllPatterns() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      var responsePatterns = await conn.query(
        PatternsTable.PATTERNS,
        where: '${PatternsTable.DELETED_DATE} is null',
      );

      var responseExpenses = await conn.query(
        ExpenseTable.EXPENSES,
        where: '${ExpenseTable.DELETED_DATE} is null',
      );

      return PatternAndExpenseDto(
        patterns: responsePatterns,
        expenses: responseExpenses,
      );
    } on DatabaseException catch (e, s) {
      throw ExpenseException(
        message: 'Error to search the patterns',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao buscar os padrões', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updatePattern(Map<String, dynamic> pattern, int id) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final response = await conn.update(
        PatternsTable.PATTERNS,
        pattern,
        where: '${PatternsTable.ID} = ?',
        whereArgs: [id],
      );

      if (response > 0) {
        log('Padrão atualizado com sucesso');
      }
    } on ArgumentError catch (e, s) {
      throw ExpenseException(
        message: 'Error to update a pattern',
        error: e,
        stackTrace: s,
      );
    } catch (e, s) {
      log('Erro ao atualizar um padrão', error: e, stackTrace: s);
      throw Exception(e.toString());
    }
  }
}
