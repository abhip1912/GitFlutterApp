import 'dart:async';
import 'dart:io' as io;
import 'package:git_users/models/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UsersDBHelper {
  static Database _db;
  //Columns
  static const String ID = 'id';
  static const String LOGIN = 'login';
  static const String AVATAR_URL = 'avatar_url';
  static const String URL = 'url';
  static const String TYPE = 'type';
  static const String NOTE = 'notes';
  //Database-Table
  static const DB_NAME = 'users1.db';
  static const TABLE = 'Users';

  // Get the dataBase
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    //Get the document directory of devices
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Path is : /data/user/0/com.example.git_users/app_flutter

    //Make a path for database
    String path = join(documentsDirectory.path, DB_NAME);

    //Open the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // What will happed at the time of creation of database
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $LOGIN TEXT, $AVATAR_URL TEXT, $URL TEXT, $TYPE TEXT, $NOTE TEXT DEFAULT '')");
  }

  //Insert the data into database
  void save(List<Users> usersList) async {
    var dbClient = await db;
    Batch batch = dbClient.batch();
    usersList.forEach((element) {
      batch.insert(TABLE, element.toJson());
    });
    await batch.commit();
  }

  Future<void> updateNote(int id, String note) async {
    var dbClient = await db;
    await dbClient.rawUpdate('UPDATE $TABLE SET $NOTE = "$note" WHERE $ID=$id');
  }

  Future<String> getNote(int id) async {
    var dbClient = await db;
    var s = await dbClient.rawQuery("SELECT $NOTE FROM $TABLE WHERE $ID=$id");
    return s[0][NOTE];
  }

  // Get all the users
  // I'm returning all the data from the database, if I have big database, it is not recommeded way.
  Future<List<Users>> getUsers() async {
    var dbClient = await db;
    //Fetch all the users in json form
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, LOGIN, AVATAR_URL, URL, TYPE]);
    List<Users> users = [];
    //Convert the json form into dartObj and add into the list
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(Users.fromJson(maps[i]));
      }
    }
    return users;
  }

  //close the database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future<int> getLastId() async {
    var dbClient = await db;
    List<Map> res = await dbClient
        .rawQuery("SELECT $ID FROM $TABLE ORDER BY $ID DESC LIMIT 1");
    if (res.length > 0) {
      return res[0][ID];
    }
    return 0;
  }

  deleteAllRecords() async {
    var dbClient = await db;
    await dbClient.rawDelete('DELETE FROM Users');
  }
}
