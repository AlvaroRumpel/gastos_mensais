import 'package:flutter/material.dart';
import 'package:gastos_mensais/utils/app_colors.dart';

InputDecoration inputDecoration({
  required String label,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: AppColors.black.shade500,
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.primary.shade500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.black.shade500),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.black.shade500),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.primary.shade500),
    ),
  );
}
