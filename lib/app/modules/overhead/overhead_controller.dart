import '../../core/exceptions/expense_exception.dart';
import '../../core/notifier/change_notifier_controller.dart';
import '../../models/pattern_model.dart';
import '../../services/patterns_service.dart';

class OverheadController extends ChangeNotifierController {
  final PatternsService _service;

  OverheadController({required PatternsService service}) : _service = service;

  var listOfPatterns = <PatternModel>[];

  Future<void> searchPatterns() async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      listOfPatterns = await _service.findAllPatterns();
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
