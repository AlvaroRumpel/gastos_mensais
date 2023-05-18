import 'package:provider/provider.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/modules/module_model.dart';
import '../../core/routes/routes.dart';
import '../../repositories/patterns_repository.dart';
import '../../repositories/patterns_repository_impl.dart';
import '../../services/patterns_service.dart';
import '../../services/patterns_service_impl.dart';
import 'overhead_controller.dart';
import 'overhead_page.dart';

class OverheadModule extends ModuleModel {
  OverheadModule()
      : super(
          bindings: [
            Provider<PatternsRepository>(
              create: (context) => PatternsRepositoryImpl(
                sqliteConnectionFactory:
                    context.read<SqliteConnectionFactory>(),
              ),
            ),
            Provider<PatternsService>(
              create: (context) => PatternsServiceImpl(
                repository: context.read<PatternsRepository>(),
              ),
            ),
            ChangeNotifierProvider<OverheadController>(
              create: (context) => OverheadController(
                service: context.read<PatternsService>(),
              ),
            ),
          ],
          routers: {
            Routes.overheadRoute: (context) => OverheadPage(
                  controller: context.read<OverheadController>(),
                ),
          },
        );
}
