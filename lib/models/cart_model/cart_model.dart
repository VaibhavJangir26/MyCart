import '../product_model/products.dart';

class CartModel {
  final int? id;
  final int? quantity;
  final Product? product;

  CartModel({
    this.id,
    this.quantity,
    this.product,
  });


  CartModel copyWith({int? quantity}) {
    return CartModel(
      id: id,
      quantity: quantity ?? this.quantity,
      product: product,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }


  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}
