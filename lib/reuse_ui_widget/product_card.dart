// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../models/product_model/index.dart';
// import '../reuse_widgets/index.dart';
//
// class ProductCard extends StatelessWidget {
//   final Product product;
//   final bool isInCart;
//   final VoidCallback onAddToCart;
//   final VoidCallback onTap;
//
//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.isInCart,
//     required this.onAddToCart,
//     required this.onTap,
//   });
//
//   double calculateDiscountedPrice(
//       double actualAmount, double discountPercentage) {
//     return actualAmount * (1 - (discountPercentage / 100));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final discountPrice = calculateDiscountedPrice(
//         product.price ?? 0, product.discountPercentage ?? 0);
//
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 3,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 130,
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(10)),
//                 child: CachedNetworkImage(
//                   imageUrl: product.thumbnail ?? "",
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   placeholder: (_, url) =>
//                       Container(color: Colors.grey.shade300),
//                   errorWidget: (_, url, error) =>
//                       const Icon(Icons.error, color: Colors.red),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.title ?? "No Title",
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product.brand ?? "Unknown Brand",
//                     style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   CustomText(
//                     text: product.description ?? "No description available",
//                     textOverFlow: TextOverflow.ellipsis,
//                     maxLine: 2,
//                     fontSize: 12,
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       RatingBarIndicator(
//                         rating: product.rating ?? 0,
//                         itemCount: 5,
//                         itemSize: 16,
//                         itemBuilder: (context, index) =>
//                             const Icon(Icons.star, color: Colors.amber),
//                       ),
//                       const SizedBox(width: 5),
//                       Text("${product.rating ?? 0}"),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       CustomText(
//                         text: "\$${product.price ?? 0}",
//                         fontSize: 14,
//                         textDecoration: TextDecoration.lineThrough,
//                         color: Colors.red,
//                       ),
//                       const SizedBox(width: 5),
//                       CustomText(
//                         text: "\$${discountPrice.toStringAsFixed(2)}",
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   CustomText(
//                     text: "${product.discountPercentage ?? 0}% OFF",
//                     fontSize: 12,
//                     color: Colors.pink,
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: isInCart ? null : onAddToCart,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: isInCart ? Colors.grey : Colors.blue,
//                       ),
//                       child: Text(isInCart ? "Added" : "Add to Cart"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/product_model/index.dart';
import '../reuse_widgets/index.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isInCart;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isInCart,
    required this.onAddToCart,
    required this.onTap,
  });

  double calculateDiscountedPrice(double actualAmount, double discountPercentage) {
    return actualAmount * (1 - (discountPercentage / 100));
  }

  @override
  Widget build(BuildContext context) {
    final discountPrice = calculateDiscountedPrice(product.price ?? 0, product.discountPercentage ?? 0);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail ?? "",
                    width: double.infinity,
                    fit: BoxFit.contain,
                    placeholder: (_, url) => Container(color: Colors.grey.shade300),
                    errorWidget: (_, url, error) => const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomText(
                        text: product.title ?? "",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),



                      CustomText(
                        text: product.brand ?? "",
                        fontSize: 9,
                        color: Colors.grey.shade600,
                        maxLine: 1,
                        textOverFlow: TextOverflow.ellipsis,
                      ),



                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating ?? 0,
                            itemCount: 5,
                            itemSize: 10,
                            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: "${product.rating ?? 0}",
                            fontSize: 8,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          CustomText(
                            text: "\$${product.price ?? 0}",
                            fontSize: 11,
                            textDecoration: TextDecoration.lineThrough,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: "\$${discountPrice.toStringAsFixed(2)}",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),


              SizedBox(
                width: 110,
                height: 30,
                child: ElevatedButton(
                  onPressed: isInCart ? null : onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInCart ? Colors.grey : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  child: CustomText(
                    text: isInCart ? "Added" : "Add to Cart",
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 1,),
            ],
          ),
        ),
      ),
    );
  }
}





