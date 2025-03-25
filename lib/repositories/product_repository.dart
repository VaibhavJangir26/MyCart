import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model/product_model.dart';
import '../api_keys.dart';

class ProductRepository {
  Future<ProductModel> fetchAllProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiKeys.productApiKey));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductModel.fromJson(jsonData);
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error fetching all products $e");
    }
  }

  Future<ProductModel> fetchCategoryProducts(String categorySlug) async {
    try {
      final String categoryUrl =
          "${ApiKeys.productApiKey}/category/$categorySlug";

      final response = await http.get(Uri.parse(categoryUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductModel.fromJson(jsonData);
      } else {
        throw Exception("failed to load category pdt ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("error fetching category pdt $e");
    }
  }
}
