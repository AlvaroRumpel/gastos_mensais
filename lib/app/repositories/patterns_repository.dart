import '../core/dtos/pattern_and_expense_dto.dart';

abstract class PatternsRepository {
  Future<int> addPattern(Map<String, dynamic> pattern);
  Future<PatternAndExpenseDto> findAllPatterns();
  Future<void> updatePattern(Map<String, dynamic> pattern, int id);
}
