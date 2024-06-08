// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StaffDao? _staffDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StaffEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `dateOfBirth` TEXT NOT NULL, `avatar` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StaffDao get staffDao {
    return _staffDaoInstance ??= _$StaffDao(database, changeListener);
  }
}

class _$StaffDao extends StaffDao {
  _$StaffDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _staffEntityInsertionAdapter = InsertionAdapter(
            database,
            'StaffEntity',
            (StaffEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'dateOfBirth': item.dateOfBirth,
                  'avatar': item.avatar
                }),
        _staffEntityUpdateAdapter = UpdateAdapter(
            database,
            'StaffEntity',
            ['id'],
            (StaffEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'dateOfBirth': item.dateOfBirth,
                  'avatar': item.avatar
                }),
        _staffEntityDeletionAdapter = DeletionAdapter(
            database,
            'StaffEntity',
            ['id'],
            (StaffEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'dateOfBirth': item.dateOfBirth,
                  'avatar': item.avatar
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StaffEntity> _staffEntityInsertionAdapter;

  final UpdateAdapter<StaffEntity> _staffEntityUpdateAdapter;

  final DeletionAdapter<StaffEntity> _staffEntityDeletionAdapter;

  @override
  Future<List<StaffEntity>> findAllStaffs() async {
    return _queryAdapter.queryList('SELECT * FROM StaffEntity',
        mapper: (Map<String, Object?> row) => StaffEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            dateOfBirth: row['dateOfBirth'] as String,
            avatar: row['avatar'] as String));
  }

  @override
  Future<StaffEntity?> findStaffById(int id) async {
    return _queryAdapter.query('SELECT * FROM StaffEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => StaffEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            dateOfBirth: row['dateOfBirth'] as String,
            avatar: row['avatar'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertStaff(StaffEntity staff) async {
    await _staffEntityInsertionAdapter.insert(staff, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStaff(StaffEntity staff) async {
    await _staffEntityUpdateAdapter.update(staff, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStaff(StaffEntity staff) async {
    await _staffEntityDeletionAdapter.delete(staff);
  }
}
