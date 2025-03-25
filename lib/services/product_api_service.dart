import 'dart:convert';
import 'package:cartfunctionlity/api_keys.dart';
import 'package:http/http.dart' as http;
import '../models/product_model/product_model.dart';

class ProductApiService {
  static const String baseUrl = ApiKeys.productApiKey;

  // fetch all products
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<ProductModel> products = (jsonData['products'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception("failed to fetch products ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error ${e.toString()}");
    }
  }

  // fetch products by category
  Future<List<ProductModel>> fetchCategoryProducts(String categorySlug) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/category/$categorySlug"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<ProductModel> products = (jsonData['products'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception(
            "failed to fetch category products ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error ${e.toString()}");
    }
  }
}
