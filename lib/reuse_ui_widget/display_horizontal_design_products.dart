import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
import 'package:cartfunctionlity/models/product_model/index.dart';
import 'package:cartfunctionlity/ui_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../reuse_widgets/custom_text.dart';

class DisplayHorizontalDesignProducts extends StatelessWidget {
  const DisplayHorizontalDesignProducts({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchAllProducts());

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState) {
        return Center(
            child: SpinKitWave(
          color: Colors.blue.shade100,
          size: 20,
        ));
      }

      if (state is ProductLoadedState) {
        List<Product> allPdt = state.allProducts;
        int startIndex = 11;
        int endIndex = 19;
        if (allPdt.length <= startIndex) {
          return const Center(child: Text("No products"));
        }

        List<Product> selectedProducts =
            allPdt.sublist(startIndex, endIndex.clamp(0, allPdt.length));

        return SizedBox(
          width: width,
          height: height * .3,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedProducts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final pdt = selectedProducts[index];

                return InkWell(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                      screen: ProductDetailScreen(product: pdt),
                      withNavBar: true),

                  child: Stack(
                    alignment: Alignment.topLeft,
                    children:[


                      Container(
                      width: width * 0.4,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.grey.shade100,
                      child: Column(
                        children: [

                          displayProductImage(pdt),
                          displayProductNameAndBrand(pdt),

                        ],
                      ),
                    ),

                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green.shade50,
                        ),
                        child: CustomText(text: "${pdt.discountPercentage}% OFF",color: Colors.green,fontWeight: FontWeight.bold,),
                      ),

                  ]
                  ),
                );
              }),
        );
      }

      if (state is ProductErrorState) {
        debugPrint(state.message);
        return Center(child: Text(state.message));
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
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
              fit: BoxFit.cover,
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
    double afterDiscountPrice=calculateDiscountedPrice(pdt.price!, pdt.discountPercentage!);
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              CustomText(
                text: pdt.title ?? "",
                maxLine: 1,
                textOverFlow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
