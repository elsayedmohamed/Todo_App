// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class SqlDb {
//   // Get DataBase And sure Initialize or not
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initialDb();
//     } else {
//       return _db;
//     }
//     return null;
//   }
//
// // Initialize DataBase===
//   initialDb() async {
//     String databasePath = await getDatabasesPath();
//
//     String path = join(databasePath, 'todo.db');
//
//     Database mydb = await openDatabase(path,
//         onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
//     print('DataBase Created');
//
//     return mydb;
//   }
//
//   // Create Table ===
//   _onCreate(Database db, int version) async {
//     await db.execute('''
//
//     CREATE TABLE "tasks"("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"title" TEXT,"date" TEXT,"time" TEXT,"status" TEXT)
//
//            ''');
//
//     print('table Created');
//   }
//
//   // Upgrade DataBase===
//   _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     await db.execute('ALTER TABLE tasks ADD COLUMN "" ');
//   }
//
//   // Select Data From DataBase===
//
//   readData({required String sql}) async {
//     Database? myDb = await db;
//
//     Future response = myDb!.rawQuery(sql);
//     response.then((value) {
//       print(value.toString());
//     });
//
//     return response;
//   }
//
//   // Insert Data To DataBase===
//
//   insertData({required String sql}) async {
//     Database? myDb = await db;
//
//     Future<int> response = myDb!.rawInsert(sql);
//     response.then((value) => {print(value.toString())});
//     return response;
//   }
//
//   // Update Data From DataBase===
//
//   updateData({required String sql}) async {
//     Database? myDb = await db;
//
//     Future<int> response = myDb!.rawUpdate(sql);
//     return response;
//   }
//
//   // Delete Data From DataBase===
//
//   deleteData({required String sql}) async {
//     Database? myDb = await db;
//
//     Future<int> response = myDb!.rawDelete(sql);
//     return response;
//   }
// }
