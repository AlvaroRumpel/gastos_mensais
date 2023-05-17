import '../models/expense_model.dart';

abstract class ExpensesService {
  Future<int> addExpense(ExpenseModel model);
  Future<List<ExpenseModel>> findAllExpenses();
  Future<void> removeExpense(int id);
  Future<void> updateExpense(ExpenseModel expense);
}
