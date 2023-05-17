import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];

  List<Migration> getUpgradeMigration(int version) {
    var migrations = <Migration>[];

    // if (version == 1) {
    //   migrations.add(MigrationV2());
    // }

    return migrations;
  }
}
