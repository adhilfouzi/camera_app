// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:camera_app/database/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<AlbumModel>> albumimages = ValueNotifier([]);
late Database database;

Future<void> initializeDatabase() async {
  database = await openDatabase(
    'imagealbum_db',
    version: 1,
    onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE album (id INTEGER PRIMARY KEY, imagex TEXT)');
    },
  );
  //print("Database created successfully.");
}

Future<void> update() async {
  final result = await database.rawQuery("SELECT * FROM album");
  //print('All Album Data : ${result}');
  albumimages.value.clear();
  for (var element in result) {
    final albumData = AlbumModel.fromMap(element);
    albumimages.value.add(albumData);
  }
  albumimages.notifyListeners();
}

Future<void> addData(AlbumModel value) async {
  try {
    await database
        .rawInsert('INSERT INTO album(imagex) VALUES (?)', [value.imagex]);
    update();
  } catch (e) {
    print('Error inserting data: $e');
  }
}

Future<void> deleteData(id) async {
  await database.delete('album', where: 'id=?', whereArgs: [id]);
  update();
}
