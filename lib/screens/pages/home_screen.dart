
import 'package:cartfunctionlity/reuse_ui_widget/display_horizontal_design_products.dart';
import 'package:cartfunctionlity/reuse_ui_widget/display_specific_product.dart';
import 'package:cartfunctionlity/reuse_widgets/custom_display_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../bloc/cart_bloc/index.dart';
import '../../bloc/product_bloc/index.dart';
import '../../models/cart_model/cart_model.dart';
import '../../reuse_widgets/index.dart';
import '../../ui_widgets/index.dart';

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



              const SizedBox(height: 10),

              const CarouselImageSlider(),

              const Divider(),

              const CategoryWiseSelection(),

              const CustomDisplayName(title: "TOP PICKS BEST PRICE",),

              const DisplayHorizontalDesignProducts(),


              const DisplaySpecificProduct(
                slugName: "home-decoration",
                displayName: "HOME DECORATION",
                color: Colors.cyan,
              ),


              const DisplaySpecificProduct(
                slugName: "mens-watches",
                displayName: "MENS WATCHES",
                color: Colors.brown,
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, productState) {
                    if (productState is ProductLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (productState is ProductLoadedState) {
                      final products = productState.allProducts;

                      return BlocBuilder<CartBloc, CartState>(
                        builder: (context, cartState) {
                          final cartItems = cartState is CartLoadedState ? cartState.cartItems : [];

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              final isInCart = cartItems.any((item) => item.id == product.id);

                              return ProductCard(
                                product: product,
                                isInCart: isInCart,
                                onAddToCart: () {
                                  final cartItem = CartModel(id: product.id, quantity: 1, product: product);
                                  context.read<CartBloc>().add(AddToCart(cartItem));
                                },
                                onTap: ()=>Get.to(()=>ProductDetailScreen(product: product)),
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







