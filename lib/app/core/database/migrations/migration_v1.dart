import 'package:sqflite/sqflite.dart';

import '../columns_variables_names/columns_variables_names.dart';
import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(
      '''
      create table ${ExpenseTable.EXPENSES}(
        ${ExpenseTable.ID} Integer primary key autoincrement,
        ${ExpenseTable.NAME} varchar(500) not null,
        ${ExpenseTable.VALUE} double not null,
        ${ExpenseTable.CREATE_DATE} datetime not null,
        ${ExpenseTable.DELETED_DATE} datetime,
        ${ExpenseTable.PAID} Integer not null default 0
      )
      ''',
    );
    batch.execute(
      '''
      create table ${PatternsTable.PATTERNS}(
        ${PatternsTable.ID} Integer primary key autoincrement,
        ${PatternsTable.NAME} varchar(500) not null,
        ${PatternsTable.EXPENSES_ID} Text not null,
        ${PatternsTable.CREATE_DATE} datetime not null,
        ${PatternsTable.DELETED_DATE} datetime
      )
      ''',
    );
  }

  @override
  void update(Batch batch) {}
}
