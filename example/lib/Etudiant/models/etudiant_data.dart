import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableEtudiantData = 'EtudiantData';
final String columnId = '_id';
final String columncoursId = 'coursId';
final String columnchapitreId = 'chapitreId';

class EtudiantData {
  int id;
  int coursId;
  int chapitreId;

  EtudiantData({
    this.id,
    this.coursId,
    this.chapitreId,
  });
  Map<String, Object> toMap() {
    var map = <String, Object>{
      columncoursId: coursId,
      columnchapitreId: chapitreId
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  EtudiantData.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    coursId = map[columncoursId];
    chapitreId = map[columnchapitreId];
  }
}

class EtudiantDataProvider {
  Future<Database> open() async {
    String path = await getDatabasesPath();
    return await openDatabase(join(path, 'etudiant.db'), version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableEtudiantData ( 
  $columnId integer primary key autoincrement, 
  $columncoursId integer not null,
  $columnchapitreId integer not null)
''');
    });
  }

  Future<EtudiantData> insert(EtudiantData etudiantData) async {
    final Database db = await open();
    etudiantData.id = await db.insert(tableEtudiantData, etudiantData.toMap());
    return etudiantData;
  }

  Future<EtudiantData> getEtudiantData(int id) async {
    final Database db = await open();
    List<Map> maps = await db.query(tableEtudiantData,
        columns: [columnId, columnchapitreId, columncoursId],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return EtudiantData.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final Database db = await open();
    return await db
        .delete(tableEtudiantData, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(EtudiantData etudiantData) async {
    final Database db = await open();
    return await db.update(tableEtudiantData, etudiantData.toMap(),
        where: '$columnId = ?', whereArgs: [etudiantData.id]);
  }
}
