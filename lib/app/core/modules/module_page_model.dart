import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ModulePageModel extends StatelessWidget {
  const ModulePageModel({
    Key? key,
    List<SingleChildWidget>? bindings,
    required WidgetBuilder page,
  })  : _bindings = bindings,
        _page = page,
        super(key: key);

  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ??
          [
            Provider(
              create: (_) => Object(),
            ),
          ],
      child: Builder(
        builder: (context) => _page(context),
      ),
    );
  }
}
