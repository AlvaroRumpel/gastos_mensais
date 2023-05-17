import 'package:provider/provider.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/modules/module_model.dart';
import '../../core/routes/routes.dart';
import '../../repositories/expenses_repository.dart';
import '../../repositories/expenses_repository_impl.dart';
import '../../repositories/patterns_repository.dart';
import '../../repositories/patterns_repository_impl.dart';
import '../../services/expenses_service.dart';
import '../../services/expenses_service_impl.dart';
import '../../services/patterns_service.dart';
import '../../services/patterns_service_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ModuleModel {
  HomeModule()
      : super(
          bindings: [
            Provider<ExpensesRepository>(
              create: (context) => ExpensesRepositoryImpl(
                sqliteConnectionFactory:
                    context.read<SqliteConnectionFactory>(),
              ),
            ),
            Provider<PatternsRepository>(
              create: (context) => PatternsRepositoryImpl(
                sqliteConnectionFactory:
                    context.read<SqliteConnectionFactory>(),
              ),
            ),
            Provider<ExpensesService>(
              create: (context) => ExpensesServiceImpl(
                repository: context.read<ExpensesRepository>(),
              ),
            ),
            Provider<PatternsService>(
              create: (context) => PatternsServiceImpl(
                repository: context.read<PatternsRepository>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(
                expensesService: context.read<ExpensesService>(),
                patternsService: context.read<PatternsService>(),
              ),
            ),
          ],
          routers: {
            Routes.homeRoute: (context) => HomePage(
                  controller: context.read<HomeController>(),
                ),
          },
        );
}
