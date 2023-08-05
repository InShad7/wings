import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

late Database db;
//inintialize the database
Future<void> initDataBase() async {
  db = await _openDatabase();
}

//open the database or creating a new one
Future<Database> _openDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'user.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)',
      );
    },
  );
}
