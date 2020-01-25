import 'dart:io';
import './repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }
  void init() async {
    Directory documentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE items 
        (
          id INTEGER PRIMARY KEY,
          type TEXT, 
          by TEXT, 
          time INTEGER,
          text TEXT, 
          parent INTEGER, 
          kids BLOB ,
          dead INTEGER ,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    print(maps);
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    } else {
      return null;
    }
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("items", item.toMapForDb());
  }

  // TODO - Store and fetch top ids
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }
}

final newsDbProvider = NewsDbProvider();
