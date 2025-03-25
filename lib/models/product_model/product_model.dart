import 'package:cartfunctionlity/models/product_model/index.dart';

class ProductModel {
  final List<Product>? products;

  final int? total;

  final int? skip;

  final int? limit;

  ProductModel({this.products, this.total, this.skip, this.limit});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : null,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((x) => x.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
