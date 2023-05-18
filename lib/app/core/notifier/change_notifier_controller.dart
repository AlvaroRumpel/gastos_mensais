import 'package:flutter/material.dart';

class ChangeNotifierController extends ChangeNotifier {
  bool _loading = false;
  String _error = '';
  bool _success = false;

  bool get loading => _loading;
  String get errorMessage => _error.isNotEmpty ? _error : 'System error';
  bool get hasError => _error.isNotEmpty;
  bool get isSuccess => _success;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;

  void success() => _success = true;

  void error(String? error) => _error = error ?? _error;

  void resetState() {
    _error = '';
    _success = false;
  }

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void hideLoadingAndSetStatus({String? errorMessage}) {
    if (errorMessage != null && errorMessage.isNotEmpty) {
      _error = errorMessage;
      _success = false;
    } else {
      _success = true;
    }

    hideLoading();
  }
}
