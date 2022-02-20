// import 'package:gharjagga/models/wishlistmodel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class DBHelper {
//   late Database _db;
//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDatabase();
//     return _db;
//   }

//   initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'gharjhagga.db');
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   _onCreate(Database db, int version) async {
//     // await db.execute(
//     //     'CREATE TABLE cart (id INTEGER PRIMARY KEY, propertyId TEXT, propertyPrice TEXT, productName TEXT, productImage TEXT, qty TEXT )');

//     await db.execute(
//       'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, propertyId TEXT, propertyPrice TEXT, propertyName TEXT, propertyImage TEXT, offerType TEXT, bathroom TEXT, bedroom TEXT, propertySIze TEXT )',
//     );
//   }

//   // Future<MyShoppingCart> add(MyShoppingCart property) async {
//   //   var dbClient = await db;
//   //   property.id = await dbClient.insert('cart', property.toMap());
//   //   return property;
//   // }

//   // Future<List<MyShoppingCart>> getMyShoppingCarts() async {
//   //   var dbClient = await db;
//   //   List<Map> maps = await dbClient.query('cart', columns: [
//   //     'id',
//   //     'propertyId',
//   //     'propertyPrice',
//   //     'productName',
//   //     'productImage',
//   //     'qty'
//   //   ]);
//   //   List<MyShoppingCart> properties = [];
//   //   if (maps.length > 0) {
//   //     for (int i = 0; i < maps.length; i++) {
//   //       properties.add(MyShoppingCart.fromMap(maps[i]));
//   //     }
//   //   }
//   //   return properties;
//   // }

//   // Future<int> delete(int id) async {
//   //   print("INT =  $id");
//   //   var dbClient = await db;
//   //   return await dbClient.delete(
//   //     'cart',
//   //     where: 'id = ?',
//   //     whereArgs: [id],
//   //   );
//   // }

//   // Future<int> update(MyShoppingCart property) async {
//   //   var dbClient = await db;
//   //   return await dbClient.update(
//   //     'cart',
//   //     property.toMap(),
//   //     where: 'id = ?',
//   //     whereArgs: [property.id],
//   //   );
//   // }

//   // Add Item to Wishlist.
//   Future<MyWishL> addWishlist(MyWishL property) async {
//     var dbClient = await db;
//     property.id = await dbClient.insert('wishlist', property.toMap());
//     return property;
//   }

//   // Get Wishlist Items.
//   Future<List<MyWishL>> getMyWishL() async {
//     var dbClient = await db;
//     List<Map> maps = await dbClient.query('wishlist', columns: [
//       'id',
//       'propertyId',
//       'propertyPrice',
//       'productName',
//       'productImage',
//       'qty'
//     ]);
//     List<MyWishL> properties = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         properties.add(MyWishL.fromMap(maps[i]));
//       }
//     }
//     return properties;
//   }

//   // Delete Wishlist Items.
//   Future<int> deleteItemFromWishlist(int id) async {
//     print("INT =  $id");
//     var dbClient = await db;
//     return await dbClient.delete(
//       'wishlist',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteItemFromWishlistByProductId(String id) async {
//     // print("INT =  $id");
//     var dbClient = await db;
//     return await dbClient.delete(
//       'wishlist',
//       where: 'propertyId = ?',
//       whereArgs: [id],
//     );
//   }

//   // Future<bool> searchItemInCart(int propertyId) async {
//   //   // print("INT =  $id");
//   //   bool existed = false;
//   //   var dbClient = await db;
//   //   List<Map> maps = await dbClient.query('wishlist',
//   //       columns: [
//   //         'id',
//   //         'propertyId',
//   //         'propertyPrice',
//   //         'productName',
//   //         'productImage',
//   //         'qty'
//   //       ],
//   //       where: "propertyId LIKE ?",
//   //       whereArgs: [
//   //         propertyId,
//   //       ]);
//   //   List<MyWishL> properties = [];
//   //   if (maps.length > 0) {
//   //     for (int i = 0; i < maps.length; i++) {
//   //       // properties.add(MyWishL.fromMap(maps[i]));
//   //       if ("$propertyId" == MyWishL.fromMap(maps[i]).qty) {
//   //         existed = true;
//   //       } else {
//   //         existed = false;
//   //       }
//   //     }
//   //   }

//   //   return existed;
//   // }

//   Future<int> getcount(propertyId) async {
//     var dbclient = await db;
//     int count = Sqflite.firstIntValue(await dbclient
//         .rawQuery("SELECT COUNT(*) FROM cart WHERE propertyId=$propertyId"));
//     return count;
//   }

//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }
// }
