
import 'package:covid19_tracker/blocs/user/user_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDbHelper {
  static Database _db;
  Future<Database> get db async {
    if(_db !=null) return _db;
    _db = await open();
    return _db;
  }

  //OPEN DB
  Future open() async {
    final dbPath = await getDatabasesPath();
    String _path = join(dbPath,'covid19_db.db');
    Database _opened = await openDatabase(_path,version: 1,onCreate: (Database db,int version) async{
      await db.execute('''
        CREATE TABLE $userTableName(
          $useridColumn integer primary key autoincrement,
          $prenomColumn text not null,
          $tokenColumn text,
          $nomColumn text,
          $emailColumn text,
          $pictureColumn text,
          $countryNameColumn text,
          $countryIdColumn text,
          $countryFlagColumn text,
          $countryCodeColumn text,
          $countryNatColumn text
        )
      '''
      );
    });

    return _opened;
  }

  //INSERT USER
  Future<int> insertUser({UserDataModel user}) async {
    final _dbClient = await db;
    final _saved = await _dbClient.insert(userTableName, user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return _saved;
  }

  //UPDATE USER
  Future<int> updateUser({UserDataModel user}) async {
    final _dbClient = await db;
    final _saved = await _dbClient.update(userTableName, user.toMapForUpdate());
    return _saved;
  }

  //get USER INFO
  Future<UserDataModel> getUserInfo() async {
    final _dbClient = await db;
    List<Map> maps  = await _dbClient.query(userTableName);
    if (maps.length > 0) {
      return UserDataModel.fromMap(map:maps.first);
    }
    return UserDataModel();
  }

  Future<List<UserDataModel>> getUsers() async {
    final _dbClient = await db;
     List<Map> maps  = await _dbClient.query(userTableName);
    if (maps.length > 0) {
      return List.generate(maps.length, (index) => UserDataModel(
        dbid:maps[index][useridColumn],
        countryid:maps[index][countryIdColumn],
        countrycode:maps[index][countryCodeColumn],
        countryflag:maps[index][countryFlagColumn],
        countryname:maps[index][countryNameColumn],
        prenom:maps[index][prenomColumn],
        nom:maps[index][nomColumn],
        usertoken:maps[index][tokenColumn],
        email:maps[index][emailColumn],
      ));
    }
    return <UserDataModel>[];
  }

  //delete user
  Future<int> deleteUser(dynamic id) async {
    final _dbClient = await db;
    int _deletion = await _dbClient.delete(userTableName,where: useridColumn,whereArgs: [id]);
    return _deletion;
  }



}