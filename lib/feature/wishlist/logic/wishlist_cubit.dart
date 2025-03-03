import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/sql_helper.dart';
import '../data/wishlist_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<WishlistModel> wishlistItems = [];
  Database? _database;

  Future<void> initDatabase() async {
    _database = await SQLHelper.initDb();
    await getWishlist();
  }

  Future<void> getWishlist() async {
    emit(WishlistLoading());
    try {
      final data = await _database!.query('wishlist');
      wishlistItems = data.map((e) => WishlistModel.fromJson(e)).toList();
      emit(WishlistLoaded());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> addToWishlist(WishlistModel product) async {
    try {
      await _database!.insert(
        'wishlist',
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await getWishlist();
      emit(WishlistLoaded());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }


   Future<void> removeFromWishlist(int productId) async {
    try {
      await _database!.delete(
        'wishlist',
        where: 'id = ?',
        whereArgs: [productId],
      );
      await getWishlist();
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}