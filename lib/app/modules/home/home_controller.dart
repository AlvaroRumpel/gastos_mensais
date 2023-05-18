import '../../core/exceptions/expense_exception.dart';
import '../../core/notifier/change_notifier_controller.dart';
import '../../core/utils/extensions.dart';
import '../../models/expense_model.dart';
import '../../models/pattern_model.dart';
import '../../services/expenses_service.dart';
import '../../services/patterns_service.dart';

class HomeController extends ChangeNotifierController {
  final ExpensesService _expensesService;
  final PatternsService _patternsService;

  HomeController({
    required ExpensesService expensesService,
    required PatternsService patternsService,
  })  : _expensesService = expensesService,
        _patternsService = patternsService;

  var expensesList = <ExpenseModel>[];
  var totalValue = 0.0;
  var resultValue = 0.0;
  var divisionValue = 1.0;
  PatternModel? _patternModel;

  set patternModel(PatternModel? value) {
    _patternModel = value;
    if (_patternModel != null) {
      updateExpensesList();
    }
  }

  void updateExpensesList() {
    showLoadingAndResetState();
    notifyListeners();
    expensesList = _patternModel!.expenses!;
    updateTotalValue();
    hideLoading();
    notifyListeners();
  }

  Future<void> addNewExpense({
    required String name,
    required String value,
  }) async {
    value = value.replaceAll(RegExp(r'(\$) |\.'), '').replaceAll(',', '.');

    try {
      showLoadingAndResetState();
      notifyListeners();

      var expenseModel = ExpenseModel(
        expenseName: name,
        expenseValue: double.parse(value),
        createDate: DateTime.now(),
      );
      var response = await _expensesService.addExpense(expenseModel);

      if (response > 0) {
        expenseModel = expenseModel.copyWith(id: response);
      }

      expensesList.add(expenseModel);
      updateTotalValue();

      hideLoading();
    } on ExpenseException catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.message);
    } on Exception catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeExpense(int? id) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (id == null) {
        hideLoadingAndSetStatus(errorMessage: 'Error on delete, without id');
        notifyListeners();
        return;
      }

      await _expensesService.removeExpense(id);

      expensesList.removeWhere((e) => e.id == id);

      updateTotalValue();
      hideLoading();
    } on ExpenseException catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.message);
    } on Exception catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }

  void updateTotalValue([String? divisionValueText]) {
    if (divisionValueText != null && divisionValueText.isNotEmpty) {
      divisionValue = double.tryParse(divisionValueText) ?? 1;
    }
    resultValue = expensesList.toSumExpenseValue() / divisionValue;
    totalValue = expensesList.toSumExpenseValue();
  }

  Future<void> savePattern() async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (expensesList.isEmpty) {
        hideLoadingAndSetStatus(errorMessage: 'Has no expenses to save');
        return;
      }

      if (_patternModel != null) {
        _patternModel = _patternModel!.copyWith(
          name: expensesList.map((e) => e.expenseName).toList().join(', '),
          expenses: expensesList,
        );

        await _patternsService.updatePattern(_patternModel!);

        hideLoadingAndSetStatus();
        return;
      }

      var pattern = PatternModel(
        name: expensesList.map((e) => e.expenseName).toList().join(', '),
        expenses: expensesList,
        createDate: DateTime.now(),
      );

      var response = await _patternsService.addPattern(pattern);

      if (response != 0) {
        expensesList.clear();
        updateTotalValue();
      }

      hideLoadingAndSetStatus();
    } on ExpenseException catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.message);
    } on Exception catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> editExpense(ExpenseModel expense) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (expense.id == null) {
        hideLoadingAndSetStatus(errorMessage: 'Error on update, without id');
        notifyListeners();
        return;
      }

      expensesList[expensesList.indexWhere(
        (element) => element.id == expense.id,
      )] = expense;

      await _expensesService.updateExpense(expense);

      updateTotalValue();
      hideLoading();
    } on ExpenseException catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.message);
    } on Exception catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
