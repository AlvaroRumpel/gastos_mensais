import 'package:flutter/material.dart';

import 'core/routes/routes.dart';
import 'core/ui/theme/theme_config.dart';
import 'modules/history/history_module.dart';
import 'modules/home/home_module.dart';
import 'modules/navigatior/navigator_module.dart';
import 'modules/overhead/overhead_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Month Expenses',
      theme: ThemeConfig.theme,
      routes: {
        ...NavigatorModule().routers,
        ...HomeModule().routers,
        ...HistoryModule().routers,
        ...OverheadModule().routers,
      },
      initialRoute: Routes.navigatorRoute,
    );
  }
}
