import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) => _showMessage(message, AppColors.red);
  void showInfo(String message) => _showMessage(message, AppColors.primary);

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
