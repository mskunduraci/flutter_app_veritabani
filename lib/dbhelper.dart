import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_veritabani/notlar.dart';

class DbHelper
{
  static Database? _db;
  static final DbHelper _dbHelper =DbHelper._internal();
  String tabloAdi="notlar";
  String colId="id";
  String colBaslik="baslik";
  String colIcerik="icerik";
  DbHelper._internal();

  factory DbHelper(){
    return _dbHelper;
  }

  Future<Database?> get db async{
    if(_db==null)
    {
      _db=await initializeDb();
    }
    return _db;
  }
  Future<Database> initializeDb() async
  {
    Directory dir=await getApplicationDocumentsDirectory();
    String yol=dir.path+"/notlar.db";
    print('Yol=== $yol');
    var dbNotlar=await openDatabase(yol,version: 1,onCreate: _createDb);
    return dbNotlar;
  }
  void _createDb(Database db,int yeniVersion) async
  {
    await db.execute("CREATE TABLE $tabloAdi($colId INTEGER PRIMARY KEY AUTOINCREMENT, "+
        "$colBaslik TEXT, $colIcerik TEXT)");
  }
  Future<List> getNotlar() async{
    List<Notlar> notlarListesi=<Notlar>[];
    Database? db=await this.db;
    var sonuc= await db!.rawQuery("SELECT * FROM $tabloAdi");
    sonuc.forEach((element) { notlarListesi.add(Notlar.fromObject(element));

    print(notlarListesi);
    });
    return notlarListesi;
  }
  Future<int?> getUzunluk() async{
    Database? db=await this.db;
    var sonuc=Sqflite.firstIntValue(
        await db!.rawQuery("SELECT COUNT(*) FROM $tabloAdi")
    );
    return sonuc;
  }
  Future<int?> updateNot(Notlar nots) async{
    Database? db=await this.db;
    var sonuc= await db!.update(tabloAdi, nots.toMap(),
        where:"$colId=?",whereArgs: [nots.id]);
    return sonuc;
  }
  Future<int?> insertNot(Notlar nots) async{
    print('Eklenecek===');
    print(nots.baslik);
    Database? db=await this.db;
    var sonuc= await db?.insert(tabloAdi, nots.toMap());
    print('Sonuç====$sonuc');
    return sonuc;
  }
  Future<int?> deleteNot(int id) async{
    Database? db=await this.db;
    var sonuc= await db?.delete(tabloAdi,
        where:"$colId=?",whereArgs: [id]);
    return sonuc;
  }

}