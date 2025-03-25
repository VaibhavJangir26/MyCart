import '../../models/cart_model/cart_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartModel item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final int itemId;
  RemoveFromCart(this.itemId);
}

class UpdateCartQuantity extends CartEvent {
  final int itemId;
  final int newQuantity;
  UpdateCartQuantity(this.itemId, this.newQuantity);
}

