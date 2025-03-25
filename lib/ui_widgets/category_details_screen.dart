import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:cartfunctionlity/ui_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../bloc/product_bloc/index.dart';
import '../models/product_model/index.dart';
import '../reuse_widgets/custom_app_bar.dart';
import '../reuse_widgets/custom_text.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key, required this.slug});
  final String slug;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchCategoryProducts(widget.slug));
  }

  double calculateDiscountedPrice(double price, double discount) {
    return price * (1 - (discount / 100));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "Category Products"),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(child: ListViewLoadingShimmer());
            } else if (state is ProductLoadedState) {
              final List<Product> products =
                  state.categoryProducts[widget.slug] ?? [];

              if (products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final discountPrice = calculateDiscountedPrice(
                    product.price ?? 0,
                    product.discountPercentage ?? 0,
                  );

                  return Container(
                    width: width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: ProductDetailScreen(product: product)
                        );
                      },
                      child: Row(
                        children: [
                          /// image
                          Container(
                            width: width * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.thumbnail!,
                              fit: BoxFit.cover,
                            ),
                          ),

                          /// details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: product.title!,
                                    maxLine: 2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: product.description!,
                                    maxLine: 1,
                                    textOverFlow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                  ),

                                  /// price & discount
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "\$${product.price ?? 0}",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        textDecoration:
                                            TextDecoration.lineThrough,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        text:
                                            "\$${discountPrice.toStringAsFixed(2)}",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text:
                                        "${product.discountPercentage ?? 0}% OFF",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),

                                  /// rating
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: product.rating ?? 0,
                                        itemCount: 5,
                                        itemSize: 16,
                                        itemBuilder: (context, index) =>
                                            const Icon(Icons.star,
                                                color: Colors.amber),
                                      ),
                                      Text("${product.rating ?? 0}"),
                                    ],
                                  ),

                                  /// buy now button
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          )),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 1),
                                          elevation: 2,
                                          backgroundColor: Colors.pink.shade200,
                                          content: const CustomText(
                                            text: "Your order has been placed successfully.",
                                            color: Colors.white,
                                          ),
                                        ));
                                      },
                                      child: const CustomText(
                                        text: 'Buy Now',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductErrorState) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
