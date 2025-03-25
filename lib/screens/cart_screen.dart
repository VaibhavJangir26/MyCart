import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../reuse_widgets/custom_app_bar.dart';
import '../reuse_widgets/custom_text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateDiscountedPrice(
      double actualAmount, double discountPercentage) {
    return actualAmount * (1 - (discountPercentage / 100));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "Cart"),
      ),

      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {

            if (state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoadedState) {
              final cartItems = state.cartItems;
              if (cartItems.isEmpty) {
                return const Center(child: Text("Your cart is empty."));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final discountPrice = calculateDiscountedPrice(
                            item.product!.price ?? 0,
                            item.product!.discountPercentage ?? 0);

                        return Container(
                          width: width,
                          margin: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 5)
                            ],
                          ),
                          child: Row(
                            children: [
                              /// product image
                              Container(
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.product!.thumbnail!,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              /// product details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: item.product!.title!,
                                          maxLine: 2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      CustomText(
                                          text: item.product!.description!,
                                          maxLine: 1,
                                          textOverFlow: TextOverflow.ellipsis,
                                          fontSize: 12),

                                      /// price and discount
                                      Row(
                                        children: [
                                          CustomText(
                                              text:
                                                  "\$${item.product!.price ?? 0}",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              textDecoration:
                                                  TextDecoration.lineThrough),
                                          const SizedBox(width: 5),
                                          CustomText(
                                              text:
                                                  "\$${discountPrice.toStringAsFixed(2)}",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ],
                                      ),
                                      CustomText(
                                          text:
                                              "${item.product!.discountPercentage ?? 0}% OFF",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),

                                      /// rating
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: item.product!.rating ?? 0,
                                            itemCount: 5,
                                            itemSize: 16,
                                            itemBuilder: (context, index) =>
                                                const Icon(Icons.star,
                                                    color: Colors.amber),
                                          ),
                                          Text("${item.product!.rating ?? 0}"),
                                        ],
                                      ),

                                      /// quantity controls
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              text:
                                                  "Stock: ${item.product!.availabilityStatus!}",
                                              fontSize: 12,
                                              color: Colors.redAccent)
                                        ],
                                      ),
                                      quantityControl(context, item),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  /// bottom summary widgets
                  cartSummary(state),
                ],
              );
            }
            return const Center(child: Text("Your cart is empty"));
          },
        ),
      ),
    );
  }

  /// quantity control widget
  Widget quantityControl(BuildContext context, dynamic item) {
    return Container(
      width: 100,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: const Icon(Icons.remove, size: 20),
            onTap: () {
              if (item.quantity! > 1) {
                context
                    .read<CartBloc>()
                    .add(UpdateCartQuantity(item.id!, item.quantity! - 1));
              } else {
                context.read<CartBloc>().add(RemoveFromCart(item.id!));
              }
            },
          ),
          CustomText(
              text: "${item.quantity}",
              fontSize: 16,
              fontWeight: FontWeight.bold),
          InkWell(
            child: const Icon(Icons.add, size: 20),
            onTap: () {
              context
                  .read<CartBloc>()
                  .add(UpdateCartQuantity(item.id!, item.quantity! + 1));
            },
          ),
        ],
      ),
    );
  }

  /// cart summary Widget
  Widget cartSummary(CartLoadedState state) {
    final totalPrice = state.cartItems.fold(
        0.0, (sum, item) => sum + (item.product!.price ?? 0) * item.quantity!);
    final totalDiscountPrice = state.cartItems.fold(
        0.0,
        (sum, item) =>
            sum +
            ((item.product!.price ?? 0) *
                item.quantity! *
                (item.product!.discountPercentage ?? 0) /
                100));
    final amountToPay = totalPrice - totalDiscountPrice;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        color: Colors.blue.shade50,
      ),
      child: Column(
        children: [
          summaryRow("Total Price:", "\$${totalPrice.toStringAsFixed(2)}"),
          summaryRow(
              "Total Discount:", "-\$${totalDiscountPrice.toStringAsFixed(2)}"),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Amount to Pay",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  CustomText(
                      text: "\$${amountToPay.toStringAsFixed(2)}",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ],
              ),
              SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        elevation: 2,
                        backgroundColor: Colors.pink.shade200,
                        content: const CustomText(
                          text: "Your order palace successfully.",
                          color: Colors.white,
                        )));
                  },
                  child: const CustomText(
                    text: "Place Order",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget summaryRow(String label, String value,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: label, fontSize: 16),
          CustomText(
            text: value,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
