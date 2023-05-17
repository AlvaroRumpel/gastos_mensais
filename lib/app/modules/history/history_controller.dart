import '../../core/exceptions/expense_exception.dart';
import '../../core/notifier/change_notifier_controller.dart';
import '../../models/expense_model.dart';
import '../../services/expenses_service.dart';

class HistoryController extends ChangeNotifierController {
  final ExpensesService _service;

  HistoryController({required ExpensesService service}) : _service = service;

  var listOfExpenses = <ExpenseModel>[];

  Future<void> searchListOfExpenses() async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      listOfExpenses = await _service.findAllExpenses();

      if (listOfExpenses.isNotEmpty) {
        listOfExpenses.sort((a, b) => b.createDate.compareTo(a.createDate));
      }

      hideLoadingAndSetStatus();
    } on ExpenseException catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.message);
    } catch (e) {
      hideLoadingAndSetStatus(errorMessage: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
