import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> initDb() async {
    return await sql.openDatabase(
      'ecommerce.db', // قاعدة بيانات واحدة لجميع الجداول
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createProductsTable(database);
        await createWishlistTable(database);
      },
    );
  }

  static Future<void> createProductsTable(Database database) async {
    await database.execute("""
      CREATE TABLE products(
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL
      )
    """);
    debugPrint("Products Table Created");
  }

  static Future<void> createWishlistTable(Database database) async {
    await database.execute("""
      CREATE TABLE wishlist(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        price REAL NOT NULL
      )
    """);
    debugPrint("Wishlist Table Created");
  }

  // Add a product to the cart
  static Future<int> addProduct(String productId, String name, String description,
      String imageUrl, int quantity, double price) async {
    final db = await SQLHelper.initDb();
    final data = {
      'id': productId,
      'title': name,
      'description': description,
      'image': imageUrl,
      'quantity': quantity,
      'price': price
    };
    final id = await db.insert('products', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint("Product Added: $id");
    return id;
  }

  // Read all products from the cart
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await SQLHelper.initDb();
    return db.query('products', orderBy: "id");
  }

  // Get product by productId from the cart
  static Future<List<Map<String, dynamic>>> getProductById(
      String productId) async {
    final db = await SQLHelper.initDb();
    return db.query('products', where: "id = ?", whereArgs: [productId]);
  }

  // Update product in the cart
  static Future<int> updateProduct(String productId, String name, String description,
      String imageUrl, int quantity, double price) async {
    final db = await SQLHelper.initDb();
    final data = {
      'title': name,
      'description': description,
      'image': imageUrl,
      'quantity': quantity,
      'price': price
    };
    final result = await db
        .update('products', data, where: "id = ?", whereArgs: [productId]);
    return result;
  }

  // Delete product from the cart
  static Future<void> deleteProduct(String productId) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [productId]);
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }

  // Add a product to the wishlist
  static Future<int> addToWishlist(int productId, String name, String description,
      String imageUrl, double price) async {
    final db = await SQLHelper.initDb();
    final data = {
      'id': productId,
      'title': name,
      'description': description,
      'image': imageUrl,
      'price': price
    };
    final id = await db.insert('wishlist', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint("Product Added to Wishlist: $id");
    return id;
  }

  // Read all products from the wishlist
  static Future<List<Map<String, dynamic>>> getWishlist() async {
    final db = await SQLHelper.initDb();
    return db.query('wishlist', orderBy: "id");
  }

  // Delete product from the wishlist
  static Future<void> removeFromWishlist(int productId) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("wishlist", where: "id = ?", whereArgs: [productId]);
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }
}