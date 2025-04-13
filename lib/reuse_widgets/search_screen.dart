import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../bloc/search_bloc/index.dart';
import '../reuse_widgets/index.dart';
import '../ui_widgets/product_detailed_screen.dart';

class MySearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/json_files/emptyCart.json",height: MediaQuery.of(context).size.height*.3,fit: BoxFit.contain,width: MediaQuery.of(context).size.width),
          Text("Search in MyCart!",style: GoogleFonts.publicSans(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.blue),)
        ],
      ));
    }
    context.read<SearchProductBloc>().add(FetchSearchProducts(query));

    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        if (state is SearchProductLoadingState) {
          return const LoadingAnimation();
        } else if (state is SearchProductLoadedState) {
          final products = state.results;

          if (products.isEmpty) {
            return const Center(child: Text("No products found 🛒"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final discountPrice =
                  product.price! * (1 - (product.discountPercentage! / 100));

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ProductDetailScreen(product: product),
                    );
                  },
                  child: Row(
                    children: [
                      //image
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                product.thumbnail ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // pdt details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: product.title ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            CustomText(
                              text: product.description ?? "",
                              fontSize: 12,
                              maxLine: 2,
                              textOverFlow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // discount and price
                            Row(
                              children: [
                                CustomText(
                                  text:
                                      "\$${product.price?.toStringAsFixed(2)}",
                                  fontSize: 15,
                                  color: Colors.grey,
                                  textDecoration: TextDecoration.lineThrough,
                                ),
                                const SizedBox(width: 6),
                                CustomText(
                                  text: "\$${discountPrice.toStringAsFixed(2)}",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ],
                            ),

                            CustomText(
                              text:
                                  "${product.discountPercentage?.toStringAsFixed(0)}% OFF",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),

                            // rating indicator
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: product.rating ?? 0,
                                  itemCount: 5,
                                  itemSize: 16,
                                  itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber),
                                ),
                                const SizedBox(width: 4),
                                Text("${product.rating ?? 0}",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),

                            // buy now button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.pink.shade200,
                                      content: const CustomText(
                                        text:
                                            "Your order has been placed successfully",
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const CustomText(
                                  text: "Buy Now",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is SearchProductErrorState) {
          return Center(child: Text(state.errorMsg));
        } else {
          return Center(child: Lottie.asset("assets/json_files/emptyCart.json"));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      "SmartPhone",
      "Headphones",
      "Laptop",
      "Camera",
      "Shoes"
    ];

    final filtered = query.isEmpty
        ? suggestions
        : suggestions
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final suggestion = filtered[index];
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
