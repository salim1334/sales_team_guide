import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' show Sqflite;
import 'package:alarm_sales_guide/data/models/user_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_group_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_group_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';
import 'package:alarm_sales_guide/data/seed/seed_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('alarm_sales.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // 1. Users Table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // 2. Call Script Groups Table
    await db.execute('''
      CREATE TABLE call_script_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        title_am TEXT NOT NULL,
        icon TEXT NOT NULL,
        sort_order INTEGER NOT NULL
      )
    ''');

    // 3. Call Scripts Table
    await db.execute('''
      CREATE TABLE call_scripts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id INTEGER NOT NULL,
        body_am TEXT NOT NULL,
        tag TEXT,
        sort_order INTEGER NOT NULL,
        FOREIGN KEY (group_id) REFERENCES call_script_groups (id) ON DELETE CASCADE
      )
    ''');

    // 4. Ad Template Groups Table
    await db.execute('''
      CREATE TABLE ad_template_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        sort_order INTEGER NOT NULL
      )
    ''');

    // 5. Ad Templates Table
    await db.execute('''
      CREATE TABLE ad_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id INTEGER NOT NULL,
        day_number INTEGER NOT NULL,
        body_am TEXT NOT NULL,
        is_favorite INTEGER DEFAULT 0,
        FOREIGN KEY (group_id) REFERENCES ad_template_groups (id) ON DELETE CASCADE
      )
    ''');

    // 6. Settings Table
    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    // Seed Data
    await _seedDatabase(db);
  }

  Future _seedDatabase(Database db) async {
    for (var user in SeedData.users) {
      await db.insert('users', user.toMap());
    }
    
    for (var group in SeedData.callScriptGroups) {
      await db.insert('call_script_groups', group.toMap());
    }
    
    for (var script in SeedData.callScripts) {
      await db.insert('call_scripts', script.toMap());
    }
    
    for (var group in SeedData.adTemplateGroups) {
      await db.insert('ad_template_groups', group.toMap());
    }
    
    for (var template in SeedData.adTemplates) {
      await db.insert('ad_templates', template.toMap());
    }

    // Default settings
    await db.insert('settings', {'key': 'themeMode', 'value': 'system'});
    await db.insert('settings', {'key': 'fontScale', 'value': 'medium'});
  }

  // --- Users ---
  Future<UserModel?> authenticateUser(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> createUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  // --- Call Scripts ---
  Future<List<CallScriptGroupModel>> getCallScriptGroups() async {
    final db = await instance.database;
    final result = await db.query('call_script_groups', orderBy: 'sort_order ASC');
    return result.map((json) => CallScriptGroupModel.fromMap(json)).toList();
  }

  Future<int> createCallScriptGroup({
    required String title,
    required String titleAm,
    required String icon,
  }) async {
    final db = await instance.database;
    final nextSortOrder = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COALESCE(MAX(sort_order), 0) + 1 as next_order FROM call_script_groups'),
        ) ??
        1;

    return db.insert('call_script_groups', {
      'title': title,
      'title_am': titleAm,
      'icon': icon,
      'sort_order': nextSortOrder,
    });
  }

  Future<int> updateCallScriptGroup({
    required int id,
    required String title,
    required String titleAm,
    required String icon,
  }) async {
    final db = await instance.database;
    return db.update(
      'call_script_groups',
      {
        'title': title,
        'title_am': titleAm,
        'icon': icon,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCallScriptGroup(int id) async {
    final db = await instance.database;
    return db.delete(
      'call_script_groups',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CallScriptModel>> getCallScriptsForGroup(int groupId) async {
    final db = await instance.database;
    final result = await db.query(
      'call_scripts',
      where: 'group_id = ?',
      whereArgs: [groupId],
      orderBy: 'sort_order ASC',
    );
    return result.map((json) => CallScriptModel.fromMap(json)).toList();
  }

  Future<int> createCallScript({
    required int groupId,
    required String bodyAm,
    required String tag,
  }) async {
    final db = await instance.database;
    final nextSortOrder = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COALESCE(MAX(sort_order), 0) + 1 as next_order FROM call_scripts WHERE group_id = ?',
            [groupId],
          ),
        ) ??
        1;

    return db.insert('call_scripts', {
      'group_id': groupId,
      'body_am': bodyAm,
      'tag': tag,
      'sort_order': nextSortOrder,
    });
  }

  Future<List<CallScriptModel>> getAllCallScripts() async {
    final db = await instance.database;
    final result = await db.query('call_scripts', orderBy: 'group_id ASC, sort_order ASC');
    return result.map((json) => CallScriptModel.fromMap(json)).toList();
  }

  Future<int> updateCallScript({
    required int id,
    required int groupId,
    required String bodyAm,
    required String tag,
  }) async {
    final db = await instance.database;
    return db.update(
      'call_scripts',
      {
        'group_id': groupId,
        'body_am': bodyAm,
        'tag': tag,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCallScript(int id) async {
    final db = await instance.database;
    return db.delete(
      'call_scripts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Ad Templates ---
  Future<List<AdTemplateGroupModel>> getAdTemplateGroups() async {
    final db = await instance.database;
    final result = await db.query('ad_template_groups', orderBy: 'sort_order ASC');
    return result.map((json) => AdTemplateGroupModel.fromMap(json)).toList();
  }

  Future<int> createAdTemplateGroup({
    required String name,
    required String description,
  }) async {
    final db = await instance.database;
    final nextSortOrder = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COALESCE(MAX(sort_order), 0) + 1 as next_order FROM ad_template_groups'),
        ) ??
        1;

    return db.insert('ad_template_groups', {
      'name': name,
      'description': description,
      'sort_order': nextSortOrder,
    });
  }

  Future<int> updateAdTemplateGroup({
    required int id,
    required String name,
    required String description,
  }) async {
    final db = await instance.database;
    return db.update(
      'ad_template_groups',
      {
        'name': name,
        'description': description,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAdTemplateGroup(int id) async {
    final db = await instance.database;
    return db.delete(
      'ad_template_groups',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<AdTemplateModel>> getAdTemplatesForGroup(int groupId) async {
    final db = await instance.database;
    final result = await db.query(
      'ad_templates',
      where: 'group_id = ?',
      whereArgs: [groupId],
      orderBy: 'day_number ASC',
    );
    return result.map((json) => AdTemplateModel.fromMap(json)).toList();
  }

  Future<List<AdTemplateModel>> getAllAdTemplates() async {
    final db = await instance.database;
    final result = await db.query('ad_templates', orderBy: 'group_id ASC, day_number ASC');
    return result.map((json) => AdTemplateModel.fromMap(json)).toList();
  }

  Future<int> createAdTemplate({
    required int groupId,
    required int dayNumber,
    required String bodyAm,
  }) async {
    final db = await instance.database;
    return db.insert('ad_templates', {
      'group_id': groupId,
      'day_number': dayNumber,
      'body_am': bodyAm,
      'is_favorite': 0,
    });
  }

  Future<int> updateAdTemplate({
    required int id,
    required int groupId,
    required int dayNumber,
    required String bodyAm,
  }) async {
    final db = await instance.database;
    return db.update(
      'ad_templates',
      {
        'group_id': groupId,
        'day_number': dayNumber,
        'body_am': bodyAm,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAdTemplate(int id) async {
    final db = await instance.database;
    return db.delete(
      'ad_templates',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> toggleFavoriteAdTemplate(int id, int currentStatus) async {
    final db = await instance.database;
    return await db.update(
      'ad_templates',
      {'is_favorite': currentStatus == 1 ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Settings ---
  Future<String?> getSetting(String key) async {
    final db = await instance.database;
    final maps = await db.query(
      'settings',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: [key],
    );

    if (maps.isNotEmpty) {
      return maps.first['value'] as String;
    }
    return null;
  }

  Future<void> updateSetting(String key, String value) async {
    final db = await instance.database;
    await db.insert('settings', {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
