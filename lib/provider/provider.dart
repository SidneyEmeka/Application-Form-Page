import 'package:sqflite/sqflite.dart';

// class DbProvider{
//   Database? db;
//   String mySQLcl = """CREATE TABLE formDB(
//   user_id integer PRIMARY KEY AUTO INCREMENT,
//   user_name TEXT,
//   user_dob TEXT,
//   user_day TEXT,
//   user_course TEXT,
//   user_time TEXT,
//   user_essay TEXT,
//   )""";
//
//   Future open(String path) async{
//     db = await openDatabase(
//       path,
//     version: 1,
//     onCreate: (Database db, int version) async{
//         await db.execute(mySQLcl);
//     }
//
//     );
//   }
// }