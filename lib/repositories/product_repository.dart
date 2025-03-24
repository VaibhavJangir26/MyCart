import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model/product_model.dart';
import '../api_keys.dart';

class ProductRepository {
  /// Fetch all products
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

  /// Fetch products by category
  Future<ProductModel> fetchCategoryProducts(String categorySlug) async {
    try {
      final String categoryUrl = "${ApiKeys.productApiKey}/category/$categorySlug";

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


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:hive/hive.dart';
// import '../models/product_model/product_model.dart';
// import '../api_keys.dart';
//
// class ProductRepository {
//   static const String _productCacheKey = "all_products";
//   static const String _categoryCacheKey = "category_products";
//
//   /// Fetch all products with caching
//   Future<ProductModel> fetchAllProducts({bool forceRefresh = false}) async {
//     try {
//       final box = await Hive.openBox('cache');
//
//       // Return cached data if available and refresh is not forced
//       if (!forceRefresh && box.containsKey(_productCacheKey)) {
//         final cachedData = box.get(_productCacheKey);
//         return ProductModel.fromJson(json.decode(cachedData));
//       }
//
//       final response = await http.get(Uri.parse(ApiKeys.productApiKey));
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//
//         // Save data to cache
//         box.put(_productCacheKey, json.encode(jsonData));
//
//         return ProductModel.fromJson(jsonData);
//       } else {
//         throw Exception("Failed to load products: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching all products: $e");
//     }
//   }
//
//   /// Fetch products by category with caching
//   Future<ProductModel> fetchCategoryProducts(String categorySlug, {bool forceRefresh = false}) async {
//     try {
//       final box = await Hive.openBox('cache');
//       final String categoryKey = "${_categoryCacheKey}_$categorySlug";
//
//       // Return cached data if available and refresh is not forced
//       if (!forceRefresh && box.containsKey(categoryKey)) {
//         final cachedData = box.get(categoryKey);
//         return ProductModel.fromJson(json.decode(cachedData));
//       }
//
//       final String categoryUrl = "${ApiKeys.productApiKey}/category/$categorySlug";
//       final response = await http.get(Uri.parse(categoryUrl));
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//
//         // Save data to cache
//         box.put(categoryKey, json.encode(jsonData));
//
//         return ProductModel.fromJson(jsonData);
//       } else {
//         throw Exception("Failed to load category products: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching category products: $e");
//     }
//   }
// }



