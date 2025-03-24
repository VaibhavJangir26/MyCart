import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartfunctionlity/reuse_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc/index.dart';



class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key,
  required this.slug
  });
  final String slug;
  @override
  State<CategoryDetailsScreen> createState() => CategoryDetailsScreenState();
}

class CategoryDetailsScreenState extends State<CategoryDetailsScreen> {


  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchCategoryProducts(widget.slug));
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: "Products")
      ),

      body: SafeArea(
        child: Column(
          children: [


            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const GridViewLoadingShimmer();
                  } else if (state is ProductLoadedState) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:  product.thumbnail ?? "",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, error, _) {
                                      return const Icon(Icons.image_not_supported, size: 50);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      product.title ?? "No Title",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),


                                    Text(
                                      "\$${product.price?.toStringAsFixed(2) ?? 'N/A'}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is ProductErrorState) {
                    print(state.message);
                    return Center(child: Text(state.message)); // Fixed error message key
                  }
                  return const SizedBox();
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}
