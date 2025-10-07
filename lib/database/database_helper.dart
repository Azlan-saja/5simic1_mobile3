import 'package:aplikasi_5simic1_mobile3/models/note_model.dart';
import 'package:aplikasi_5simic1_mobile3/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Configuration variables
  static Database? _database;
  final String databaseName = "note2.db";
  final int databaseVersion = 1;

  // Create user table
  final String createUserTable = '''
  CREATE TABLE users ( 
    userId INTEGER PRIMARY KEY AUTOINCREMENT, 
    userName TEXT UNIQUE NOT NULL, 
    userPassword TEXT NOT NULL 
  ) 
  ''';
  // create note table
  final String createNoteTable = '''
  CREATE TABLE notes ( 
    noteId INTEGER PRIMARY KEY AUTOINCREMENT, 
    noteTitle TEXT NOT NULL, 
    noteContent TEXT NOT NULL, 
    createdAt TEXT DEFAULT CURRENT_TIMESTAMP 
  ) 
  ''';
  final String insertUserTable = '''
  INSERT INTO users ( 
    userId, 
    userName, 
    userPassword
  ) VALUES (1, "admin", "12345678")
  ''';

  // Initialize the database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute(createUserTable);
        await db.execute(createNoteTable);
        await db.execute(insertUserTable);
      },
    );
  }

  // Getter database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<bool> login(UserModel user) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'userName = ? AND userPassword = ?',
      whereArgs: [user.userName, user.userPassword],
    );

    return result.isNotEmpty;
  }

  Future<int> createNote(NoteModel note) async {
    final Database db = await database;
    return db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await database;
    final result = await db.query('notes');
    return result
        .map(
          (e) => NoteModel.fromMap(e),
        )
        .toList();
  }

  Future<int> updateNote(String title, String content, int noteId) async {
    final Database db = await database;
    return db.update(
      'notes',
      {
        'noteTitle': title,
        'noteContent': content,
      },
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
  }

  Future<int> deleteNote(int id) async {
    final Database db = await database;
    return db.delete(
      'notes',
      where: 'noteId = ?',
      whereArgs: [id],
    );
  }

  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await database;

    final List<Map<String, Object?>> result = await db.query(
      'notes',
      where: 'LOWER(noteTitle) LIKE ? OR LOWER(noteContent) LIKE ?',
      whereArgs: ['%${keyword.toLowerCase()}%', '%${keyword.toLowerCase()}%'],
    );

    return result.map((map) => NoteModel.fromMap(map)).toList();
  }
}
