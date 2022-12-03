import 'package:labanda/data/model/cart_product.dart';
import 'package:labanda/presentation/resources/constants_manager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDataBaseHelper {
  CartDataBaseHelper._();

  static final CartDataBaseHelper db = CartDataBaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'Band.b');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
                  CREATE TABLE ${AppConstants.tableCartProduct}
                  (
                   ${AppConstants.columnName} TEXT NOT NULL  , 
                   ${AppConstants.columnImage} TEXT NOT NULL  , 
                   ${AppConstants.columnPrice} TEXT NOT NULL  , 
                   ${AppConstants.columnQuantity} INTEGER NOT NULL  )     
                ''');
    });
  }

  insert(CartModel model) async {
    var dbClient = await database;
    await dbClient?.insert(
      AppConstants.tableCartProduct,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map<String, dynamic>> maps =
        await dbClient!.query(AppConstants.tableCartProduct);

    List<CartModel> list = maps.isNotEmpty
        ? maps.map((Product) => CartModel.fromJson(Product)).toList()
        : [];

    print(list.length);
    return list;
  }

  updateProduct(CartModel model) async {
    var dbClient = await database;
    return await dbClient?.update(AppConstants.tableCartProduct, model.toJson(),
        where: '${AppConstants.columnImage} = ? ', whereArgs: [model.image]);
  }

  deleteProduct(CartModel model) async {
    var dbClient = await database;
    return await dbClient?.delete(AppConstants.tableCartProduct,
        where: '${AppConstants.columnImage} = ? ', whereArgs: [model.image]);
  }
}
