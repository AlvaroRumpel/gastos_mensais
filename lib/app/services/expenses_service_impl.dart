import '../models/expense_model.dart';
import '../repositories/expenses_repository.dart';
import 'expenses_service.dart';

class ExpensesServiceImpl implements ExpensesService {
  final ExpensesRepository _repository;

  ExpensesServiceImpl({
    required ExpensesRepository repository,
  }) : _repository = repository;

  @override
  Future<int> addExpense(ExpenseModel model) =>
      _repository.addExpense(model.toMap());

  @override
  Future<List<ExpenseModel>> findAllExpenses() async {
    var response = await _repository.findAllExpenses();
    return response.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  @override
  Future<void> removeExpense(int id) => _repository.removeExpense(id);

  @override
  Future<void> updateExpense(ExpenseModel expense) =>
      _repository.updateExpense(expense.toMap(), expense.id!);
}
