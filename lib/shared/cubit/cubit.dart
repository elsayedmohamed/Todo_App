import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../Screens/archive_screen/archive_screen.dart';
import '../../Screens/done_screen/done_screen.dart';
import '../../Screens/task_screen/task_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];
  // titles
  List<String> titles = [
    'Task Screen',
    'Done Screen',
    'Archive Screen',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  //==========================================

  bool isOpendBottomSheet = false;
  IconData iconFab = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isOpendBottomSheet = isShow;
    iconFab = icon;

    emit(AppBottomSheetShowState());
  }
  //=========================================

  List<Map> newTasks = [];
  List<dynamic> doneTasks = [];
  List<dynamic> archiveTasks = [];

  Database? database;
  void createDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    // open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE "tasks"("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"title" TEXT,"date" TEXT,"time" TEXT,"status" TEXT)');
    }, onOpen: (database) {
      getData(database);

      emit(AppCreateDataBase());
    });
  }

// Insert ============================================================================================
  Future insertIntoDataBase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database?.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO tasks ("title","date","time","status") VALUES ("$title","$date","$time","new")');
      print('inserted1: $id1');
    });
    getData(database);
    emit(AppInsertIntoDataBase());
  }

  // Get Data From Database========================================
  void getData(database) {
    emit(AppLoadingGetFromDataBase());

    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archiveTasks.add(element);
          }
          print('${element['title']} ==========================');
          emit(AppGetFromDataBase());
        },
      );
    });
  }

  // Update Database================================================
// Update some record
  updateData({
    required int id,
    required String status,
  }) async {
    return await database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getData(database);
      emit(AppUpdateDataBase());
    });
  }

  // Delete
// Delete a record
  deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getData(database);
      emit(AppDeleteDataState());
    });
  }
}
