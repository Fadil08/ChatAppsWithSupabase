import 'package:flutter/material.dart';
import 'package:flutter_api/main.dart';
import 'package:flutter_api/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_api/widget/constans.dart';
// import 'path';

class DatabaseHelper {
  Future<void> createNote({required Notes notes}) async {
    try {
      final response = await supabase.from('notes').insert(notes.toJson());
      // print('berhasi');
      if (response.error != null) {
        throw Exception(response.error.message);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> insertNote(String title, deskripsi, name) async {
    try {
      final response = await supabase
          .from('notes')
          .insert({'title': title, 'description': deskripsi, 'name': name});
      // print('berhasi');
      if (response.error != null) {
        throw Exception(response.error.message);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateNotes(Notes notes) async {
    await supabase.from('notes').update({
      'title': notes.title,
      'description': notes.description,
      // 'date': notes.date
    }).eq('id', notes.id.toString());
  }

  Future<void> deleteNote(String id) async {
    try {
      await supabase.from('notes').delete().eq('notes', id);
    } catch (e) {
      print(e);
    }
  }

  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  Database? db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }
  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'notes.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE notes (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title TEXT NOT NULL,
              description TEXT NOT NULL, 
              date TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }

  Future<int> insertNotes(Notes notes) async {
    int result = await db!.insert('notes', notes.toMap());
    return result;
  }

  Future<int> updateUser(Notes notes) async {
    int result = await db!
        .update('notes', notes.toMap(), where: "id = ?", whereArgs: [notes.id]);
    return result;
  }

  Future<List<Notes>> retriveNotes() async {
    final List<Map<String, Object?>> queryResult = await db!.query('notes');
    return queryResult.map((e) => Notes.fromMap(e)).toList();
  }

  Future<void> deleteNotes(int id) async {
    await db!.delete('notes', where: "id = ?", whereArgs: [id]);
  }
}
