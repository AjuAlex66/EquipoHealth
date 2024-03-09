import 'package:firebase_auth/firebase_auth.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/localstorage.dart';
import 'package:objectid/objectid.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? database;
  static String? databasesPath;
  DatabaseHelper._init();
  static openDB() async {
    databasesPath = await getDatabasesPath();
    if (database != null) return database!;
    database = await onCreate(databasesPath);
    return database!;
  }

  static onCreate(String? databasesPath) async {
    final db = await openDatabase(join(databasesPath!, 'simplelogs.db'),
        version: 1, onCreate: (db, versison) async {
      await db.execute('''
      CREATE TABLE userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT UNIQUE,
        userName TEXT,
        userEmail TEXT UNIQUE,
        userPassword TEXT,
        timestamp DATETIME
      )
    ''');
      await db.execute('''
      CREATE TABLE folderTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        folderId TEXT,
        userId TEXT,
        folderName TEXT,
        isActive INTEGER,
        timestamp TEXT,
        FOREIGN KEY (userId) REFERENCES userTable(userId)

      )
    ''');
      await db.execute('''
      CREATE TABLE notesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        notesId TEXT,
        userid TEXT,
        folderId TEXT,
        noteTitle TEXT,
        noteContent TEXT,
        timestamp TEXT,
        isActive INTEGER,
        FOREIGN KEY (userid) REFERENCES userTable(userId),
        FOREIGN KEY (folderId) REFERENCES folderTable(folderId)
      )
    ''');
      Helper.showLog('Table created');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < newVersion) {
        // await db.execute(
        //     'ALTER TABLE walkstatus ADD COLUMN isStartSynced  INTEGER DEFAULT 0');
        // await db.execute(
        //     'ALTER TABLE walkstatus ADD COLUMN isEndSynced INTEGER DEFAULT 0');
        Helper.showLog('Table upgraded');
      }
    });

    return db;
  }

  static addNote(String? title, String? content, DateTime date) async {
    try {
      final Database db = await openDB();
      final userid = await LocalStorage.getUserId();
      Map<String, Object?> data = {
        "notesId": ObjectId().toString(),
        "userid": userid,
        "folderId": "",
        "noteTitle": title,
        "noteContent": content,
        "timestamp": date.toString(),
        "isActive": 1,
      };
      Helper.showLog(data);
      final result = await db.insert('notesTable', data);
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Helper.showToast(msg: "Unable to add notes at this time");
      Helper.showLog("Insertion error $e");
      return false;
    }
  }

  static Future<bool> addLoginDetails(UserCredential userCredential) async {
    try {
      final Database db = await openDB();
      Map<String, Object?> data = {
        "userId": userCredential.user!.uid,
        "userName": userCredential.additionalUserInfo!.username,
        "userEmail": userCredential.user!.email,
        "timestamp": DateTime.now().toString(),
      };
      Helper.showLog(data);
      List<Map> result = await db.query('userTable',
          where: 'userId = ?', whereArgs: [userCredential.user!.uid]);
      if (result.isNotEmpty) {
        var updateStatus = await db.update(
          'userTable',
          {
            'timestamp': DateTime.now().toString(),
          },
          where: 'userId = ?',
          whereArgs: [userCredential.user!.uid],
        );
        if (updateStatus == 1) {
          Helper.showLog("Data updated");
          return true;
        } else {
          return false;
        }
      } else {
        var insertStatus = await db.insert('userTable', data);
        if (insertStatus == 1) {
          Helper.showLog("Data inserted");
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      Helper.showLog("Exception on adding user data $e");
      return false;
    }
  }

  static getAllRecentNotes() async {
    // must pass the selected date on this method
    List data = [];
    try {
      final Database db = await openDB();
      // DateTime time =
      //     DateTime.now(); // for getting current datetime  (yyyy-MM-dd-hh-mm-ss)
      // DateTime today = DateTime(time.year, time.month,
      //     time.day); // for getting current date by avoiding time (yyyy-MM-dd)
      // data = await db.query('notesTable',
      //     where: 'timestamp >= ? AND timestamp <= ?',
      //     whereArgs: [
      //       today.toUtc().toIso8601String(),
      //       today.add(const Duration(days: 1)).toUtc().toIso8601String()
      //     ]);
      data = await db.query('notesTable');
      Helper.showLog(data);
      return data;
    } catch (e) {
      Helper.showLog("Exception on getting notes $e");
      return data;
    }
  }

  static deleteNote(String? noteId, String? userId) async {
    try {
      final Database db = await openDB();
      final response = await db.rawDelete(
          'DELETE FROM notesTable WHERE notesId = ? AND userid = ?',
          [noteId, userId]);
      if (response == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Helper.showLog("Exception on getting notes $e");
      return false;
    }
  }
}
