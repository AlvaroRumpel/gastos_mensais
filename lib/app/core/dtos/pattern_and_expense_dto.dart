class PatternAndExpenseDto {
  final List<Map<String, Object?>> patterns;
  final List<Map<String, Object?>> expenses;

  PatternAndExpenseDto({
    required this.patterns,
    required this.expenses,
  });
}
