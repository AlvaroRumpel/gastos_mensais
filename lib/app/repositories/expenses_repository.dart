abstract class ExpensesRepository {
  Future<int> addExpense(Map<String, dynamic> expense);
  Future<List<Map<String, Object?>>> findAllExpenses();
  Future<void> removeExpense(int id);
  Future<void> updateExpense(Map<String, dynamic> expense, int id);
}
