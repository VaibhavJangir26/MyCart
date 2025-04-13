import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../bloc/product_bloc/index.dart';
import '../models/product_model/index.dart';
import '../reuse_widgets/index.dart';
import '../ui_widgets/index.dart';


class DisplaySpecificProduct extends StatefulWidget {
  const DisplaySpecificProduct({
    super.key,
    required this.slugName,
    required this.displayName,
    required this.color,
  });

  final String slugName;
  final String displayName;
  final Color color;

  @override
  State<DisplaySpecificProduct> createState() => _DisplaySpecificProductState();
}

class _DisplaySpecificProductState extends State<DisplaySpecificProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchCategoryProducts(widget.slugName));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, categoryState) {
        if (categoryState is ProductLoadingState) {
          return Center(
              child: SpinKitWave(
                color: Colors.blue.shade100,
                size: 20,
              ));
        }

        if (categoryState is ProductLoadedState) {
          List<Product> pdt = categoryState.categoryProducts[widget.slugName] ?? [];

          return Stack(children: [
            Container(
              width: width,
              height: height * .25,
              color: widget.color,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDisplayName(
                  title: widget.displayName,
                ),

                exploreMoreButton(height, width, context),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 3),
                  itemCount: pdt.length > 4 ? 4 : pdt.length,
                  itemBuilder: (context, index) {
                    final categoryPdt = pdt[index];
                    return InkWell(
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ProductDetailScreen(product: categoryPdt),
                          withNavBar: true),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        color: Colors.grey.shade100,
                        child: Column(
                          children: [
                            displayProductImage(categoryPdt),
                            displayProductNameAndBrand(categoryPdt),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ]);
        }

        if (categoryState is ProductErrorState) {
          return Center(child: Text(categoryState.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget exploreMoreButton(double height, double width, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * .1),
      width: width * .45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () => PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: CategoryDetailsScreen(slug: widget.slugName),
          withNavBar: true,
        ),
        child: const CustomText(text: "Explore more", color: Colors.white),
      ),
    );
  }

  Widget displayProductImage(Product categoryPdt) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: categoryPdt.thumbnail ?? "",
            fit: BoxFit.cover,
            errorWidget: (context, error, _) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget displayProductNameAndBrand(Product categoryPdt) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            CustomText(
              text: categoryPdt.title ?? "",
              maxLine: 1,
              textOverFlow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            CustomText(
              text: categoryPdt.brand ?? "",
              maxLine: 1,
              textOverFlow: TextOverflow.ellipsis,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}

//
// class DisplaySpecificProduct extends StatelessWidget {
//   const DisplaySpecificProduct({
//     super.key,
//     required this.slugName,
//     required this.displayName,
//     required this.color,
//   });
//   final String slugName;
//   final String displayName;
//   final Color color;
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<ProductBloc>(context).add(FetchCategoryProducts(slugName));
//
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, categoryState) {
//       if (categoryState is ProductLoadingState) {
//         return Center(
//             child: SpinKitWave(
//           color: Colors.blue.shade100,
//           size: 20,
//         ));
//       }
//
//       if (categoryState is ProductLoadedState) {
//         List<Product> pdt = categoryState.categoryProducts[slugName] ?? [];
//         return Stack(children: [
//           Container(
//             width: width,
//             height: height * .25,
//             color: color,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomDisplayName(
//                 title: displayName,
//               ),
//
//               /// this is explore more button
//               exploreMoreButton(height, width, context),
//
//               /// some item are show here or display some items
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 3),
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   final categoryPdt = pdt[index];
//                   return InkWell(
//                     onTap: () => PersistentNavBarNavigator.pushNewScreen(
//                         context,
//                         screen: ProductDetailScreen(product: categoryPdt),
//                         withNavBar: true),
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 3),
//                       color: Colors.grey.shade100,
//                       child: Column(
//                         children: [
//                           displayProductImage(categoryPdt),
//                           displayProductNameAndBrand(categoryPdt),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ]);
//       }
//
//       if (categoryState is ProductErrorState) {
//         print(categoryState.message);
//         return Center(child: Text(categoryState.message));
//       }
//
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     });
//   }
//
//   Widget exploreMoreButton(double height, double width, BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: width * .1),
//       width: width * .45,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue.shade300,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             )),
//         onPressed: () => PersistentNavBarNavigator.pushNewScreen(
//           context,
//           screen: CategoryDetailsScreen(slug: slugName),
//           withNavBar: true,
//         ),
//         child: const CustomText(
//           text: "Explore more",
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget displayProductImage(Product categoryPdt) {
//     return Expanded(
//         flex: 2,
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: CachedNetworkImage(
//               imageUrl: categoryPdt.thumbnail ?? "",
//               fit: BoxFit.cover,
//               errorWidget: (context, __, _) => const Icon(Icons.error),
//             ),
//           ),
//         ));
//   }
//
//   Widget displayProductNameAndBrand(Product categoryPdt) {
//     return Flexible(
//         flex: 1,
//         fit: FlexFit.tight,
//         child: SizedBox(
//           width: double.infinity,
//           child: Column(
//             children: [
//               CustomText(
//                 text: categoryPdt.title ?? "",
//                 maxLine: 1,
//                 textOverFlow: TextOverflow.ellipsis,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//               CustomText(
//                 text: categoryPdt.brand ?? "",
//                 maxLine: 1,
//                 textOverFlow: TextOverflow.ellipsis,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//               ),
//             ],
//           ),
//         ));
//   }
// }
