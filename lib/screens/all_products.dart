import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:cartfunctionlity/reuse_widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../models/product_model/index.dart';
import '../ui_widgets/index.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "MyCart"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingState) {
              return const LoadingAnimation();
            }
            if (state is ProductLoadedState) {
              final allPdt = state.allProducts;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
                itemCount: allPdt.length,
                itemBuilder: (context, index) {
                  final pdt = allPdt[index];
                  return InkWell(
                    onTap: () => PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ProductDetailScreen(product: pdt),
                        withNavBar: true),
                    child: Stack(alignment: Alignment.topLeft, children: [
                      /// product details
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            displayProductImage(pdt),
                            displayProductNameAndBrand(pdt),
                          ],
                        ),
                      ),

                      /// discount %
                      Positioned(
                        left: 5,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .25,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: CustomText(
                            text: "${pdt.discountPercentage}% OFF",
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              );
            }

            if (state is ProductErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(
              child: Text("Loading..."),
            );
          }),
        ),
      ),
    );
  }

  Widget displayProductImage(Product pdt) {
    return Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: pdt.thumbnail ?? "",
              fit: BoxFit.contain,
              errorWidget: (context, __, _) => const Icon(Icons.error),
            ),
          ),
        ));
  }

  Widget displayProductNameAndBrand(Product pdt) {
    double calculateDiscountedPrice(
        double actualAmount, double discountPercentage) {
      return actualAmount * (1 - (discountPercentage / 100));
    }

    double afterDiscountPrice =
        calculateDiscountedPrice(pdt.price!, pdt.discountPercentage!);

    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          child: Column(
            children: [
              /// name of product
              CustomText(
                text: pdt.title ?? "",
                maxLine: 1,
                textOverFlow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),

              /// rating bar
              Row(
                children: [
                  RatingBarIndicator(
                    rating: pdt.rating ?? 0,
                    itemCount: 5,
                    itemSize: 12,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                  ),
                  CustomText(
                    text: "${pdt.rating ?? 0}",
                    fontSize: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: "\$${pdt.price}",
                    maxLine: 1,
                    textOverFlow: TextOverflow.ellipsis,
                    fontSize: 13,
                    textDecoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  CustomText(
                    text: "\$${afterDiscountPrice.toStringAsFixed(2)}",
                    maxLine: 1,
                    textOverFlow: TextOverflow.ellipsis,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
