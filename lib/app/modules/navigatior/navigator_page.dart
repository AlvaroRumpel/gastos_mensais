import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../history/history_module.dart';
import '../home/home_module.dart';
import '../overhead/overhead_module.dart';
import 'navigator_controller.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navKey,
        initialRoute: Routes.homeRoute,
        clipBehavior: Clip.none,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => HomeModule().routers.values.first(context),
        ),
        onGenerateRoute: (settings) {
          var route = settings.name;
          switch (route) {
            case Routes.homeRoute:
              return MaterialPageRoute(
                builder: (context) =>
                    HomeModule().routers.values.first(context),
                settings: settings,
              );

            case Routes.historyRoute:
              return MaterialPageRoute(
                builder: (context) =>
                    HistoryModule().routers.values.first(context),
              );
            case Routes.overheadRoute:
              return MaterialPageRoute(
                builder: (context) =>
                    OverheadModule().routers.values.first(context),
              );
            default:
              return null;
          }
        },
      ),
      bottomNavigationBar: Selector<NavigatorController, int>(
        selector: (context, controller) => controller.currentPage,
        builder: (context, value, child) => NavigationBar(
          selectedIndex: value,
          onDestinationSelected: (nextPage) {
            if (value == nextPage) {
              return;
            }

            var controller = context.read<NavigatorController>();

            controller.changePage(pageIndex: nextPage);

            if (controller.currentPage != 1) {
              _navKey.currentState?.pushNamed(controller.pages[nextPage]);
              return;
            }

            _navKey.currentState?.popUntil(
              (route) => route.isFirst,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.attach_money),
              label: 'Overhead',
            ),
          ],
        ),
      ),
    );
  }
}
