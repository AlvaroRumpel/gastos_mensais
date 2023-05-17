import 'package:flutter/material.dart';

import '../ui/theme/app_colors.dart';

extension TextStyleExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get textRegular =>
      Theme.of(this).textTheme.headlineMedium?.copyWith(
            color: AppColors.white,
          );
  TextStyle? get textLabel => Theme.of(this).textTheme.bodyMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      );
}
