import 'package:flutter/material.dart';

import '../../core/notifier/change_notifier_controller.dart';
import '../../core/routes/routes.dart';

class NavigatorController extends ChangeNotifierController {
  var pageController = PageController();

  var currentPage = 1;

  final pages = [Routes.historyRoute, Routes.homeRoute, Routes.overheadRoute];

  void changePage({
    required int pageIndex,
  }) {
    currentPage = pageIndex;
    notifyListeners();
  }
}
