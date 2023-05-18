import './patterns_service.dart';
import '../models/expense_model.dart';
import '../models/pattern_model.dart';
import '../repositories/patterns_repository.dart';

class PatternsServiceImpl implements PatternsService {
  final PatternsRepository _repository;

  PatternsServiceImpl({
    required PatternsRepository repository,
  }) : _repository = repository;

  @override
  Future<int> addPattern(PatternModel pattern) =>
      _repository.addPattern(pattern.toMap());

  @override
  Future<List<PatternModel>> findAllPatterns() async {
    var patternsList = <PatternModel>[];
    var response = await _repository.findAllPatterns();

    var patterns =
        response.patterns.map((e) => PatternModel.fromMap(e)).toList();

    var expenses =
        response.expenses.map((e) => ExpenseModel.fromMap(e)).toList();

    for (var item in patterns) {
      patternsList.add(
        item.copyWith(
          expenses: expenses
              .where(
                (element) => item.expensesId!.any((e) => element.id == e),
              )
              .toList(),
        ),
      );
    }

    return patternsList;
  }

  @override
  Future<void> updatePattern(PatternModel pattern) =>
      _repository.updatePattern(pattern.toMap(), pattern.id!);
}
