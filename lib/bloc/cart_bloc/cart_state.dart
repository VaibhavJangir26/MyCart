// import '../../models/cart_model/cart_model.dart';
//
// abstract class CartState{}
//
// class CartInitialState extends CartState{}
//
// class CartLoadingState extends CartState{}
//
// class CartLoadedState extends CartState{
//   final List<CartModel> cartItems;
//   final double totalPrice;
//   CartLoadedState(this.cartItems, this.totalPrice);
// }
//
// class CartErrorState extends CartState{
//   final String message;
//   CartErrorState(this.message);
// }


import '../../models/cart_model/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartModel> cartItems;
  final double totalPrice;

  CartLoadedState(this.cartItems, this.totalPrice);

  List<Map<String, dynamic>> getAllItemsAsMap() {
    return cartItems.map((item) => item.toMap()).toList();
  }
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}
