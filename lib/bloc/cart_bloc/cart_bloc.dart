import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_model/cart_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final List<CartModel> updatedItems = _getCurrentCartItems();
    final existingIndex =
        updatedItems.indexWhere((item) => item.id == event.item.id);

    if (existingIndex != -1) {
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity! + 1,
      );
    } else {
      updatedItems.add(CartModel(
          id: event.item.id, quantity: 1, product: event.item.product));
    }

    emit(CartLoadedState(updatedItems, _calculateTotal(updatedItems)));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final List<CartModel> updatedItems = _getCurrentCartItems();
    updatedItems.removeWhere((item) => item.id == event.itemId);

    emit(CartLoadedState(updatedItems, _calculateTotal(updatedItems)));
  }

  void _onUpdateQuantity(UpdateCartQuantity event, Emitter<CartState> emit) {
    final List<CartModel> updatedItems = _getCurrentCartItems();
    final existingIndex =
        updatedItems.indexWhere((item) => item.id == event.itemId);

    if (existingIndex != -1) {
      if (event.newQuantity > 0) {
        updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
          quantity: event.newQuantity,
        );
      } else {
        updatedItems.removeAt(existingIndex);
      }
    }
    emit(CartLoadedState(updatedItems, _calculateTotal(updatedItems)));
  }


  List<CartModel> _getCurrentCartItems() {
    if (state is CartLoadedState) {
      return List.from((state as CartLoadedState).cartItems);
    }
    return [];
  }

  double _calculateTotal(List<CartModel> items) {
    return items.fold(
        0, (total, item) => total + ((item.product?.price)! * item.quantity!));
  }
}
