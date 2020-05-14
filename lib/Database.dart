import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'Avancement.dart';

class DatabaseClient {
  Database _db;

  Future<Database> get db async{
    if(_db !=null){
      print("existing db");
      return db;
    } else{
      //crer nvlle bd
      _db = await createNewDb();
      return _db;
    }
  }

  Future createNewDb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String db_directory = join(directory.path, 'database.db');
    var bdd = await openDatabase(db_directory,version: 1,onCreate:_onCreate);
    return bdd;
  }

  Future deleteDb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String db_directory = join(directory.path, 'database.db');
    await deleteDatabase(db_directory);
  }


  Future _onCreate(Database db, int version) async{
    await db.execute(
        '''
         CREATE TABLE IF NOT EXISTS NIVEAU(
          id INTEGER PRIMARY KEY,
          niveau INTEGER,
          objectif INTEGER,
          temps INTEGER
          )
        '''
    );
    createNewItem();
  }

  void createNewItem() async{
    Database maDb = await db ;
    var niveau_atteind = Avancement(1,25,10);
    var id = await maDb.rawInsert("INSERT INTO NIVEAU(id,niveau,objectif,temps) VALUES(1,${niveau_atteind.niveau},${niveau_atteind.objectif},${niveau_atteind.temps})" );
    print("article inserer, id = $id");
  }

  void updateItem(Avancement avancement) async{
    Database maDb = await db;
    await maDb.rawUpdate("UPDATE NIVEAU SET niveau = ${avancement.niveau}, objectif = ${avancement.objectif}, temps = ${avancement.temps} WHERE id = 1");
    print("update successfuly");
  }

  Future<Map<String,dynamic>> recupererSeulItem() async{
//    print("recup");
    Database maDb = await db;
    List<Map<String,dynamic>> resultat = await maDb.rawQuery("SELECT * FROM NIVEAU");
    var avancer = resultat[0];
    Avancement infosNiveau = new Avancement(avancer['niveau'], avancer['objectif'], avancer['temps']);
//    print('recup avancer = $avancer');
    print('recup info from db = ${infosNiveau.convertirEnMap()}');
    return infosNiveau.convertirEnMap();
//    print(avancer);
  }

}