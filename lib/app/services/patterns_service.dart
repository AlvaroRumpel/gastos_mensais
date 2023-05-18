import '../models/pattern_model.dart';

abstract class PatternsService {
  Future<int> addPattern(PatternModel pattern);
  Future<List<PatternModel>> findAllPatterns();
  Future<void> updatePattern(PatternModel pattern);
}
