import 'package:cartfunctionlity/models/cart_model/cart_model.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:cartfunctionlity/ui_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../bloc/product_bloc/index.dart';
import '../bloc/cart_bloc/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchAllProducts());
  }

  double calculateDiscountedPrice(double actualAmount, double discountPercentage) {
    return actualAmount*(1 - (discountPercentage/100));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "Home"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CarouselImageSlider(),

              const CategoryWiseSelection(),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, productState) {
                    if (productState is ProductLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (productState is ProductLoadedState) {
                      final products = productState.products;

                      return BlocBuilder<CartBloc, CartState>(
                        builder: (context, cartState) {
                          final cartItems = cartState is CartLoadedState ? cartState.cartItems : [];

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(), // Prevent internal scrolling
                            shrinkWrap: true, // Let GridView adjust its height within Column
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final pdt = products[index];
                              final isInCart = cartItems.any((item)=>item.id==pdt.id);

                              final discountPrice= calculateDiscountedPrice(pdt.price??0, pdt.discountPercentage??0);

                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          imageUrl: pdt.thumbnail??"",
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                          placeholder: (_, url) => Container(color: Colors.blue.shade50),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            pdt.title ?? "",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            pdt.brand ?? "",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          CustomText(text: "${pdt.description}",textOverFlow: TextOverflow.ellipsis,maxLine: 2,fontSize: 5,),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: pdt.rating??0,
                                                itemCount: 5,
                                                itemSize: 16,
                                                itemBuilder:(context,index)=> const Icon(Icons.star, color:Colors.amber),
                                              ),
                                              Text("${pdt.rating??0}"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              CustomText(text: "\$${pdt.price??0}",fontSize: 8,textDecoration: TextDecoration.lineThrough,),
                                              const SizedBox(width: 5,),
                                              CustomText(text: "\$${discountPrice.toStringAsFixed(2)}",fontSize: 8,color: Colors.blue,)
                                            ],
                                          ),
                                          CustomText(text: "${pdt.discountPercentage??0}% OFF",fontSize: 6,color: Colors.pink,),
                                          ElevatedButton(
                                            onPressed: isInCart
                                                ? null
                                                : () {
                                              final cartItem = CartModel(
                                                id: pdt.id,
                                                title: pdt.title,
                                                price: pdt.price,
                                                images: pdt.images,
                                                quantity: 1,
                                              );
                                              context.read<CartBloc>().add(AddToCart(cartItem));
                                            },
                                            child: Text(isInCart ? "Added" : "Add to Cart"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (productState is ProductErrorState) {
                      return Center(child: Text(productState.message));
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
