import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableUtilDataSqlite = 'UtilDataSqlite';
const String columnId = '_id';
const String columnlangue = 'langue';

// classe pour l'enregistrement des donnees localement
class UtilDataSqlite {
  int id;
  String langue;

  UtilDataSqlite({this.id, this.langue});

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnlangue: langue,
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  UtilDataSqlite.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    langue = map[columnlangue];
  }
}

// classe de manipulation de la table etudiantData
class UtilDataProvider {
  // configuration d'accee
  Future<Database> open() async {
    String path = await getDatabasesPath();
    return await openDatabase(join(path, 'utildata.db'), version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableUtilDataSqlite ( 
  $columnId integer primary key autoincrement, 
  $columnlangue integer not null)
''');
    });
  }

// insertion des donnees
  Future<UtilDataSqlite> insert(UtilDataSqlite utilDataSqlite) async {
    final Database db = await open();
    utilDataSqlite.id =
        await db.insert(tableUtilDataSqlite, utilDataSqlite.toMap());
    if (utilDataSqlite.id != 1) {
      utilDataSqlite.id = 1;
      update(utilDataSqlite);
    }
    return utilDataSqlite;
  }

// lister les donnees
  Future<UtilDataSqlite> getUtilDataSqlite(int id) async {
    final Database db = await open();
    List<Map> maps = await db.query(tableUtilDataSqlite,
        columns: [columnId, columnlangue],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return UtilDataSqlite.fromMap(maps.first);
    }
    return null;
  }

// supprimer les donnees
  Future<int> delete(int id) async {
    final Database db = await open();
    return await db
        .delete(tableUtilDataSqlite, where: '$columnId = ?', whereArgs: [id]);
  }

// mise ajoure des donnees
  Future<int> update(UtilDataSqlite utilDataSqlite) async {
    final Database db = await open();
    return await db.update(tableUtilDataSqlite, utilDataSqlite.toMap(),
        where: '$columnId = ?', whereArgs: [utilDataSqlite.id]);
  }
}
