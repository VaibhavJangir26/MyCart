import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/cart_bloc/cart_event.dart';
import '../reuse_widgets/custom_app_bar.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});


  double calculateDiscountedPrice(double actualAmount, double discountPercentage) {
    return actualAmount*(1 - (discountPercentage/100));
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                        return ListTile(
                          leading: Image.network(item.images?.first ?? "", width: 50, height: 50),
                          title: Text(item.title ?? ""),
                          subtitle: Text("₹${item.price} x ${item.quantity}"),

                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            width: width*.38,
                            height: height*.08,
                            constraints: BoxConstraints(
                              maxWidth: width*.38,
                              maxHeight: height*.08,
                            ),
                            child: Card(
                              elevation: 2,
                              color: Colors.blue.shade100,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        context.read<CartBloc>().add(UpdateCartQuantity(item.id??0, item.quantity - 1));
                                      } else {
                                        context.read<CartBloc>().add(RemoveFromCart(item.id??0));
                                      }
                                    },
                                  ),
                                  CustomText(text: "${item.quantity}",fontSize: 16,fontWeight: FontWeight.bold,),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      context.read<CartBloc>().add(UpdateCartQuantity(item.id??0, item.quantity + 1));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                        );
                      },
                    ),
                  ),


                  Container(
                    width: width,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:  Radius.circular(10)),
                      color: Colors.blue.shade100
                    ),
                    child: Column(
                      children: [
                        CustomText(text: state.totalPrice.toStringAsFixed(2),fontWeight: FontWeight.bold,fontSize: 15,),
                      ],
                    ),
                  ),

                ],
              );
            }
            else if(state is CartErrorState){
              print(state.message);
              return Center(child: Text(state.message),);
            }
            return const Center(child: Text("Your cart is empty"));
          },
        ),
      ),
    );
  }


}


// import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cart_bloc/cart_bloc.dart';
// import '../bloc/cart_bloc/cart_state.dart';
// import '../bloc/cart_bloc/cart_event.dart';
// import '../reuse_widgets/custom_app_bar.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   /// Function to calculate the discounted price
//   double calculateDiscountedPrice(double actualAmount, double discountPercentage) {
//     return actualAmount * (1 - (discountPercentage / 100));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: CustomAppBar(title: "Cart"),
//       ),
//
//       body: SafeArea(
//         child: BlocBuilder<CartBloc, CartState>(
//           builder: (context, state) {
//             if (state is CartLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is CartLoadedState) {
//               final cartItems = state.cartItems;
//               if (cartItems.isEmpty) {
//                 return const Center(child: Text("Your cart is empty."));
//               }
//
//               return Column(
//                 children: [
//                   /// Cart Items List
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: cartItems.length,
//                       itemBuilder: (context, index) {
//                         final item = cartItems[index];
//                         final discountedPrice = calculateDiscountedPrice(
//                           item.price ?? 0,
//                           item.discountPercentage ?? 0,
//                         );
//
//                         return Card(
//                           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                           elevation: 3,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Product Image
//                                 Image.network(
//                                   item.images?.first ?? "",
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 const SizedBox(width: 10),
//
//                                 /// Product Details
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(text: item.title ?? "No Title", fontWeight: FontWeight.bold, fontSize: 16),
//                                       CustomText(text: "Brand: ${item.brand ?? "N/A"}", fontSize: 14),
//                                       CustomText(text: "Category: ${item.category ?? "N/A"}", fontSize: 14),
//                                       CustomText(text: "Rating: ${item.rating?.toStringAsFixed(1) ?? "N/A"} ★", fontSize: 14),
//                                       CustomText(text: "Stock: ${item.stock ?? 0} left", fontSize: 14, fontWeight: FontWeight.w500),
//
//                                       /// Price and Discount
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "₹${discountedPrice.toStringAsFixed(2)}",
//                                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
//                                           ),
//                                           const SizedBox(width: 6),
//                                           if (item.discountPercentage != null && item.discountPercentage! > 0)
//                                             Text(
//                                               "₹${item.price?.toStringAsFixed(2)}",
//                                               style: const TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: Colors.red),
//                                             ),
//                                         ],
//                                       ),
//                                       CustomText(
//                                         text: "Discount: ${item.discountPercentage?.toStringAsFixed(1) ?? "0"}%",
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.blue,
//                                       ),
//                                       CustomText(text: "Availability: ${item.availabilityStatus ?? "Unknown"}", fontSize: 14),
//
//                                       /// Warranty & Shipping
//                                       if (item.warrantyInformation != null)
//                                         CustomText(text: "Warranty: ${item.warrantyInformation}", fontSize: 14),
//                                       if (item.shippingInformation != null)
//                                         CustomText(text: "Shipping: ${item.shippingInformation}", fontSize: 14),
//
//                                       /// Quantity Controller
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               IconButton(
//                                                 icon: const Icon(Icons.remove),
//                                                 onPressed: () {
//                                                   if (item.quantity > 1) {
//                                                     context.read<CartBloc>().add(UpdateCartQuantity(item.id ?? 0, item.quantity - 1));
//                                                   } else {
//                                                     context.read<CartBloc>().add(RemoveFromCart(item.id ?? 0));
//                                                   }
//                                                 },
//                                               ),
//                                               CustomText(
//                                                 text: "${item.quantity}",
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               IconButton(
//                                                 icon: const Icon(Icons.add),
//                                                 onPressed: () {
//                                                   context.read<CartBloc>().add(UpdateCartQuantity(item.id ?? 0, item.quantity + 1));
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//
//                                           /// Total Price Per Item
//                                           CustomText(
//                                             text: "Total: ₹${(discountedPrice * item.quantity).toStringAsFixed(2)}",
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12,
//                                             color: Colors.deepPurple,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//                   /// Cart Summary
//                   Container(
//                     width: width,
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(10),
//                         topLeft: Radius.circular(10),
//                       ),
//                       color: Colors.blue.shade100,
//                     ),
//                     child: Column(
//                       children: [
//                         /// Total Amount
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const CustomText(text: "Total Amount:", fontWeight: FontWeight.bold, fontSize: 16),
//                             CustomText(
//                               text: "₹${state.totalPrice.toStringAsFixed(2)}",
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.green,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//
//                         /// Checkout Button
//                         ElevatedButton(
//                           onPressed: () {
//                             // Implement checkout functionality
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueAccent,
//                             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                           ),
//                           child: const Text("Proceed to Checkout", style: TextStyle(fontSize: 16, color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is CartErrorState) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text("Your cart is empty"));
//           },
//         ),
//       ),
//     );
//   }
// }
