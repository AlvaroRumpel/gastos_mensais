import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'module_page_model.dart';

abstract class ModuleModel {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  ModuleModel({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, value) => MapEntry(
        key,
        (_) => ModulePageModel(
          page: value,
          bindings: _bindings,
        ),
      ),
    );
  }
}
