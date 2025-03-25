import '../../models/cart_model/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartModel> cartItems;
  final double totalPrice;
  CartLoadedState(this.cartItems, this.totalPrice);
  List<Map<String, dynamic>> getAllItemsAsJson() {
    return cartItems.map((item) => item.toJson()).toList();
  }
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}
