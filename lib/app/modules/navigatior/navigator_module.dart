import 'package:provider/provider.dart';

import '../../core/modules/module_model.dart';
import '../../core/routes/routes.dart';
import 'navigator_controller.dart';
import 'navigator_page.dart';

class NavigatorModule extends ModuleModel {
  NavigatorModule()
      : super(
          bindings: [
            ChangeNotifierProvider(create: (context) => NavigatorController()),
          ],
          routers: {
            Routes.navigatorRoute: (context) => const NavigatorPage(),
          },
        );
}
