import 'dart:async';

import 'package:sqflite/sqflite.dart';

class Sql {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDataBase();
      return _db;
    }
    return _db!;
  }

  intialDataBase() async {
    String path = await getDatabasesPath();
    // String path2 = join(path,'test.db'); or
    String path2 = '$path/products.db';
    Database db = await openDatabase(path2,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    await db.execute('''
    CREATE TABLE ordersTable (
      order_id INTEGER PRIMARY KEY,
      date TEXT
    )
  ''');

    await db.execute('''CREATE TABLE product_prices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  time DATETIME DEFAULT CURRENT_TIMESTAMP,
  item_count INTEGER DEFAULT 1,
  order_id INTEGER ,
    FOREIGN KEY (order_id) REFERENCES ordersTable(order_id)

);''');

    batch.commit();
  }

  readData(sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  Future<void> printAllProducts(table) async {
    Database? myDb = await db;
    final products = await myDb!.query('$table');

    for (final product in products) {
      final name = product['name'];
      final price = product['price'];
      print('$name: $price');
    }
  }

  Future<List<Map<String, dynamic>>> getProductPricesByTimeRange(
      DateTime start, DateTime end) async {
    Database? myDb = await db;
    final startDateStr = start.toIso8601String();
    final endDateStr = end.toIso8601String();
    final query = '''
    SELECT * FROM product_prices
    WHERE time >= '$startDateStr' AND time <= '$endDateStr'
  ''';
    return myDb!.rawQuery(query);
  }

  insertData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    // print("onUpgrade =====================================");
  }

  deleteMyDataBase() async {
    String path = await getDatabasesPath();
    String path2 = '$path/products_values.db';
    return await deleteDatabase(path2);
  }

  //====== methods for notes table ======
  //======short methodes for queries======
  read(table, {String? Where, List? wherear}) async {
    Database? myDb = await db;
    List<Map> response =
        await myDb!.query(table, where: Where, whereArgs: wherear);
    return response;
  }

  insert(table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  update(table, Map<String, Object?> values, where) async {
    Database? myDb = await db;
    int response =
        await myDb!.update(table, values, where: where); //where: 'id = ?'
    return response;
  }

  delete(table, where) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: where); //where: 'id = ?'
    return response;
  }

  Future<void> createTable(
      String tableName, Map<String, String> columns) async {
    final dbf = await db;
    String query = "CREATE TABLE $tableName (";
    columns.forEach((key, value) {
      query += "$key $value,";
    });
    query = query.substring(0, query.length - 1);
    query += ")";
    await dbf!.execute(query);
  }

  close() {
    _db!.close();
  }

  Future<List<Map<String, dynamic>>> query(tablename) async {
    Database? myDb = await db;
    return await myDb!.query(
      tablename,
    );
  }
}
