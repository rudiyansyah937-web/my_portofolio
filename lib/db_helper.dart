import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  Database? _db;

  Future<Database> get database async {
    return _db ??= await _open();
  }

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'portfolio.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE projects(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            year TEXT NOT NULL,
            tech TEXT NOT NULL,
            category TEXT NOT NULL,
            description TEXT NOT NULL,
            image TEXT NOT NULL DEFAULT ''
          )
        ''');
        await _seed(db);
      },
    );
  }

  Future<void> _seed(DatabaseExecutor db) async {
    for (final p in seedProjects.reversed) {
      await db.insert('projects', p.toMap());
    }
  }

  Future<List<Project>> getAll() async {
    final db = await database;
    final rows = await db.query('projects', orderBy: 'id DESC');
    return rows.map(Project.fromMap).toList();
  }

  Future<int> insert(Project p) async {
    final db = await database;
    return db.insert('projects', p.toMap());
  }

  Future<int> update(Project p) async {
    final db = await database;
    return db.update('projects', p.toMap(), where: 'id = ?', whereArgs: [p.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete('projects', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> resetToSeed() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('projects');
      await _seed(txn);
    });
  }
}
