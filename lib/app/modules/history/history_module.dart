import 'package:provider/provider.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/modules/module_model.dart';
import '../../core/routes/routes.dart';
import '../../repositories/expenses_repository.dart';
import '../../repositories/expenses_repository_impl.dart';
import '../../services/expenses_service.dart';
import '../../services/expenses_service_impl.dart';
import 'history_controller.dart';
import 'history_page.dart';

class HistoryModule extends ModuleModel {
  HistoryModule()
      : super(
          bindings: [
            Provider<ExpensesRepository>(
              create: (context) => ExpensesRepositoryImpl(
                sqliteConnectionFactory:
                    context.read<SqliteConnectionFactory>(),
              ),
            ),
            Provider<ExpensesService>(
              create: (context) => ExpensesServiceImpl(
                repository: context.read<ExpensesRepository>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => HistoryController(
                service: context.read<ExpensesService>(),
              ),
            ),
          ],
          routers: {
            Routes.historyRoute: (context) => HistoryPage(
                  controller: context.read<HistoryController>(),
                ),
          },
        );
}
