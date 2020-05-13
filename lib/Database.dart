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


  Future _onCreate(Database db, int version) async{
    await db.execute(
        '''
         CREATE TABLE IF NOT EXISTS NIVEAU(
          niveau VARCHAR(255),
          objectif VARCHAR(255),
          temps VARCHAR(255)
          )
        '''
    );
    createNewItem();
  }

  void createNewItem() async{
    Database maDb = await db ;
    var niveau_atteind = Avancement(1,25,10);
    var id = await maDb.insert('NIVEAU', niveau_atteind.convertirEnMap());
    print("article inserer, id = $id");
  }

  void updateItem(Avancement avancement) async{
    Database maDb = await db;
    var a = await maDb.update('NIVEAU', avancement.convertirEnMap(),where: 'niveau = ?',whereArgs: [1]);
  }

  void recupererSeulItem() async{
    Database maDb = await db;
    List<Map<String,dynamic>> avancement = await maDb.rawQuery("SELECT * FROM NIVEAU");
    var avancer = avancement[0];
    print(avancer);
  }

}