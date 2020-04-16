import 'package:smm_project/models/user_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class LocalService {
  sql.Database db;
  static const nameDb = 'main.db';

  Future open() async {
    final dbPath = await sql.getDatabasesPath();
    final myDbPath = path.join(dbPath, nameDb);
    print('--------------$myDbPath');
    db = await sql.openDatabase(
      myDbPath,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tbl_user(userId TEXT PRIMARY KEY,displayName TEXT, email TEXT, password TEXT,dateofbirth TEXT,placeofbirth TEXT,address TEXT,phone TEXT,photoUrl TEXT,bloodGroup TEXT)');
        await db.execute(
          'CREATE TABLE tbl_employee(employeeId TEXT PRIMARY KEY, deptId TEXT, firstName TEXT, lastName TEXT,gender TEXT,familyName TEXT,familyNumber TEXT,photos TEXT,phone TEXT,bloodType TEXT,hiredDate Text,status TEXT)');
        await db.execute(
          'CREATE TABLE tbl_department(departmentId TEXT PRIMARY KEY,departmentName TEXT)');
        await db.execute(
          'CREATE TABLE tbl_report(id TEXT PRIMARY KEY,dateReport TEXT,inTime TEXT, outTime TEXT,employeeId TEXT,status TEXT)');
        await db.execute(
          'CREATE TABLE tbl_versioning(id INTEGER PRIMARY KEY)'
        );
      },
      version: 1,
    );
  }
  

  deleteDB() async {
    final dbPath = await sql.getDatabasesPath();
    final myDbpath = path.join(dbPath, nameDb);
    await sql.deleteDatabase(myDbpath);
  }

  addVersioning(String description, String name, String status) async {
    await db.transaction((txn) async {
      var res = await txn.rawInsert(
        'INSERT INTO tbl_versioning(name_change, time_change, status_change) VALUES(?, ?, ?)',
        [description, name, status]
      );
    });
  }

  addDepartmentFirstOf(List<dynamic> user) async {
    await db.transaction((txn) async {
      for(int i=0; i<user.length; i++) {
        var res = await txn.rawInsert(
          'INSERT INTO tbl_department(departmentId, departmentName) VALUES(?, ?)',
          [user[i]['departmentId'], user[i]['departmentName']]
        );
        print('--------------------$res');
      }
    });
  }

  addDepartment(String id, String name) async {
    await db.transaction((txn) async {
      var res = await txn.rawInsert(
        'INSERT INTO tbl_department(departmentId, departmentName) VALUES(?, ?)',
        [id, name]
      );
    });
  }

  getAllDepartment() async {
    var asd = await db.rawQuery('SELECT * FROM tbl_department');
    print(asd);
    return asd;
  }

  getuser() async {
    await open();
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    return List.generate(list.length, (i) {
      return User(
        userId: list[i]['id'],
        email: list[i]['email'],
        password: list[i]['password'],
        displayName: list[i]['displayName'],
        photoUrl: list[i]['photoUrl'],
        phone: list[i]['phone'],
        placeofbirth: list[i]['placeofbirth'],
        dateofbirth: list[i]['dateofbirth'],
      );
    }); 
  }

///////////////////// report

  addreportFirstOf(List<dynamic> report) async {
    await db.transaction((txn) async {
      for(int i=0; i<report.length; i++) {
        var res = await txn.rawInsert(
          'INSERT INTO tbl_report(id, dateReport, inTime, outTime, employeeId, status) VALUES(?, ?, ?, ?, ?, ?)',
          [
            report[i]['id'],
            report[i]['dateReport'],
            report[i]['inTime'],
            report[i]['outTime'],
            report[i]['employeeId'],
            'Y'
          ]
        );
        print('--------------------$res');
      }
    });
  }

  getAllReport() async {
    var asd = await db.rawQuery('SELECT * FROM tbl_report');
    print(asd);
    return asd;
  }

  updateReport(String intime, String status, String id) async {
    var asd = await db.rawUpdate('UPDATE tbl_report SET inTime = ?, status = ? WHERE id = ?',
    [intime, status, id]
    );
  }

}