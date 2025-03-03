import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/sql_helper.dart';
import '../data/model/product_card_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  double totalPrice = 0;
  List<ProductCartModel> products = [];

  Future<void> getCartData() async {
    emit(CartLoading());
    try {
      await SQLHelper.getProducts().then((value) {
        products = value.map((e) => ProductCartModel.fromJson(e)).toList();
      });
      calculateTotalPrice();
      emit(CartLoaded());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> deleteProduct(String id, int index) async {
  emit(CartLoading());
  try {
    await SQLHelper.deleteProduct(id);
    products.removeAt(index);
    calculateTotalPrice();
    emit(CartProductDeleted()); // إرسال حالة محدثة
  } catch (e) {
    emit(CartError(e.toString()));
  }
}

  void calculateTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < products.length; i++) {
      totalPrice += products[i].quantity! * products[i].price!.toDouble();
    }
  }

  Future<void> refreshCart() async {
    await getCartData();
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) return;
    
    final db = await SQLHelper.initDb();
    await db.update(
      'products',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [productId],
    );
    
    final index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      products[index].quantity = newQuantity;
      calculateTotalPrice();
      emit(CartUpdated());
    }
  }
}

