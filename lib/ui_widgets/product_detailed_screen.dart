import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../bloc/cart_bloc/index.dart';
import '../models/cart_model/cart_model.dart';
import '../models/product_model/index.dart';
import '../reuse_widgets/index.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier(0);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "Product Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // product title
            CustomText(
              text: product.title ?? "",
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 5),
            const Divider(),

            // image slider
            buildImageSlider(product, currentIndex, width),
            const SizedBox(height: 10),

            const Divider(),
            // price & discount
            buildPriceSection(product),

            const SizedBox(height: 5),

            const Divider(),

            buildOtherThings(context, product),

            const Divider(),

            const CustomText(
              text: "Description",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 5),

            CustomText(
              text: product.description ?? "",
              fontSize: 18,
              color: Colors.black87,
            ),

            const SizedBox(height: 10),

            const Divider(),

            const CustomText(
              text: "Customer Reviews",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 5),

            buildCustomerReviews(product.reviews ?? [], width),
          ],
        ),
      ),
    );
  }

  Widget buildImageSlider(
      Product product, ValueNotifier<int> currentIndex, double width) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: product.images?.length ?? 0,
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: product.images?[index] ?? "",
              width: width,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                  child: SpinKitWave(
                color: Colors.blue,
                size: 30,
              )),
              errorWidget: (context, error, _) =>
                  const Icon(Icons.image_not_supported, size: 50),
            );
          },
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context, index, child) {
            return DotsIndicator(
              dotsCount: product.images?.length ?? 0,
              position: index,
              decorator: const DotsDecorator(activeColor: Colors.blue),
            );
          },
        ),
      ],
    );
  }

  Widget buildPriceSection(Product product) {
    final double discountPrice =
        product.price != null && product.discountPercentage != null
            ? product.price! * (1 - (product.discountPercentage! / 100))
            : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "\$${discountPrice.toStringAsFixed(2)}",
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        if (product.discountPercentage != null &&
            product.discountPercentage! > 0)
          Row(
            children: [
              CustomText(
                text: "\$${product.price?.toStringAsFixed(2) ?? "0"}",
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                textDecoration: TextDecoration.lineThrough,
              ),
              const SizedBox(width: 5),
              CustomText(
                text: "-${product.discountPercentage?.toStringAsFixed(0)}% OFF",
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
      ],
    );
  }

  Widget buildOtherThings(BuildContext context, Product product) {
    final cartState = context.watch<CartBloc>().state;

    final bool isInCart = cartState is CartLoadedState &&
        cartState.cartItems.any((item) => item.product?.id == product.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability Status

        Row(
          children: [
            const CustomText(
              text: "Availability",
              fontSize: 17,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              text: product.availabilityStatus ?? "Out of Stock",
              fontSize: 17,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),

        // Brand Name
        Row(
          children: [
            const CustomText(
              text: "Brand",
              fontSize: 17,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              text: product.brand ?? "Unknown Brand",
              fontSize: 18,
              color: Colors.pink.shade400,
            ),
          ],
        ),

        CustomText(
          text: product.warrantyInformation ?? "",
          fontSize: 16,
          color: Colors.cyan,
        ),

        CustomText(
          text: product.returnPolicy ?? "",
          fontSize: 18,
        ),

        Row(
          children: [
            RatingBarIndicator(
              rating: product.rating ?? 0,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.amber),
            ),
            Text("${product.rating ?? 0}"),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // buy now button
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

            // add to cart button
            SizedBox(
              width: 125,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: isInCart
                    ? null
                    : () {
                        final cartItem = CartModel(
                          id: product.id,
                          quantity: 1,
                          product: product,
                        );
                        context.read<CartBloc>().add(AddToCart(cartItem));
                      },
                child: CustomText(
                  text: isInCart ? "Added" : "Add to Cart",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCustomerReviews(List<Review> reviews, final width) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CustomText(
          text: "No reviews yet.",
          fontSize: 15,
          color: Colors.blueGrey,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    return Column(
      children: reviews.map((review) {
        // Safely parse the date string
        DateTime? date;
        String formattedDate = "";

        if (review.date != null && review.date!.isNotEmpty) {
          try {
            date = DateTime.parse(review.date!);
            formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(date);
          } catch (e) {
            formattedDate = "Invalid date"; // Handle parsing error gracefully
          }
        }

        return Container(
          width: width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reviewer Name
              CustomText(
                text: review.reviewerName ?? "Anonymous",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 5),

              // Formatted Date
              CustomText(
                text: formattedDate,
                fontSize: 12,
                color: Colors.grey,
              ),

              // Rating
              Row(
                children: [
                  RatingBarIndicator(
                    rating: (review.rating ?? 0).toDouble(),
                    itemCount: 5,
                    itemSize: 16,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                  ),
                  const SizedBox(width: 5),
                  CustomText(
                    text: "${review.rating ?? 0}",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Comment
              CustomText(
                text: review.comment ?? "No comment provided.",
                fontSize: 14,
                color: Colors.black87,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
