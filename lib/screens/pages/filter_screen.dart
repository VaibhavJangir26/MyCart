// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// //
// // class FilterScreen extends StatefulWidget {
// //   const FilterScreen({super.key});
// //
// //   @override
// //   State<FilterScreen> createState() => _FilterScreenState();
// // }
// //
// // class _FilterScreenState extends State<FilterScreen> {
// //   List<String> category = [
// //     "Beauty",
// //     "Home and Living",
// //     "Electronics",
// //     "Men's Fashions",
// //     "Women's Fashions",
// //     "Sports",
// //     "Vehicle",
// //   ];
// //
// //   List<String> categoriesImages = [
// //     "assets/images/categories/beauty.jpg",
// //     "assets/images/categories/home_living.jpeg",
// //     "assets/images/categories/electronics.jpg",
// //     "assets/images/categories/men_fashions.jpg",
// //     "assets/images/categories/women_fashion.jpg",
// //     "assets/images/categories/sports.jpg",
// //     "assets/images/categories/car.jpg"
// //   ];
// //
// //   List<List<String>> subCategory = [
// //     ["Skin-Care", "Fragrance"],
// //     ["Furniture", "Home-Decoration", 'Kitchen-Accessories', 'Groceries'],
// //     ["Laptop", "SmartPhone", 'Tablets', 'Mobile-Accessories'],
// //     ["T-Shirts", "Shoes", 'Watches'],
// //     ["Dress", "Bags", 'Jewellery', 'Shoes', 'Watches', 'Tops', 'Sunglasses'],
// //     ['Sports-Accessories'],
// //     ['Motorcycle', 'Vehicle']
// //   ];
// //
// //   List<List<String>> subcategoryAssetsImages = [
// //     [
// //       "assets/images/subcategory/skinCare.jpg",
// //       "assets/images/subcategory/fragrance.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/furniture.jpg",
// //       "assets/images/subcategory/homeDecoration.jpg",
// //       "assets/images/subcategory/kitchen.jpg",
// //       "assets/images/subcategory/groceries.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/laptop.jpg",
// //       "assets/images/subcategory/smartPhone.jpg",
// //       "assets/images/subcategory/tabletDevice.jpg",
// //       "assets/images/subcategory/MobileAccessories.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/mensTShirt.jpg",
// //       "assets/images/subcategory/mensShoes.jpg",
// //       "assets/images/subcategory/mensWatches.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/womensDress.jpg",
// //       "assets/images/subcategory/women_bags.jpg",
// //       "assets/images/subcategory/jelw.jpg",
// //       "assets/images/subcategory/womenShoes.jpg",
// //       "assets/images/subcategory/womenWatch.jpg",
// //       "assets/images/subcategory/womenTops.jpg",
// //       "assets/images/subcategory/womenSunglass.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/sports.jpg"
// //     ],
// //     [
// //       "assets/images/subcategory/bike.jpg",
// //       "assets/images/subcategory/car.jpg"
// //     ]
// //   ];
// //
// //
// //   List<List<String>> slugNames = [
// //     ["skin-care", "fragrances"],
// //     ["furniture", "home-decoration", "kitchen-accessories", "groceries"],
// //     ["laptops", "smartphones", "tablets", "mobile-accessories"],
// //     ["mens-shirts", "mens-shoes", "mens-watches"],
// //     ["womens-dresses", "womens-bags", "womens-jewellery", "womens-shoes", "womens-watches", "tops", "sunglasses"],
// //     ["sports-accessories"],
// //     ["motorcycle", "vehicle"],
// //   ];
// //
// //
// //   final ValueNotifier<int> selectedCategoryIndex = ValueNotifier<int>(0);
// //
// //   @override
// //   void dispose() {
// //     selectedCategoryIndex.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Row(
// //           children: [
// //             /// Category list
// //             Expanded(
// //               flex: 2,
// //               child: Container(
// //                 color: Colors.brown.shade200,
// //                 child: ValueListenableBuilder<int>(
// //                   valueListenable: selectedCategoryIndex,
// //                   builder: (context, selectedIndex, _) {
// //                     return ListView.builder(
// //                       padding: const EdgeInsets.symmetric(vertical: 8),
// //                       itemCount: category.length,
// //                       itemBuilder: (context, index) {
// //                         return GestureDetector(
// //                           onTap: () {
// //                             if (index < subCategory.length) {
// //                               selectedCategoryIndex.value = index;
// //                             }
// //                           },
// //                           child: Container(
// //                             padding: const EdgeInsets.symmetric(vertical: 10),
// //                             decoration: BoxDecoration(
// //                               color: selectedIndex == index
// //                                   ? Colors.brown.shade400
// //                                   : Colors.transparent,
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 CircleAvatar(
// //                                   radius: 35,
// //                                   backgroundImage: AssetImage(categoriesImages[index]),
// //                                   backgroundColor: selectedIndex == index
// //                                       ? Colors.blue.shade300
// //                                       : Colors.blue.shade100,
// //                                 ),
// //                                 Text(
// //                                   category[index],
// //                                   textAlign: TextAlign.center,
// //                                   style: GoogleFonts.italiana(
// //                                     fontSize: 13,
// //                                     fontWeight: FontWeight.w700,
// //                                     color: selectedIndex == index
// //                                         ? Colors.white
// //                                         : Colors.black,
// //                                   ),
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //
// //             /// Sub-category grid
// //             Expanded(
// //               flex: 5,
// //               child: Container(
// //                 decoration: const BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [Color(0xffcfd9df), Color(0xffe2ebf0)],
// //                   ),
// //                 ),
// //                 child: ValueListenableBuilder<int>(
// //                   valueListenable: selectedCategoryIndex,
// //                   builder: (context, selectedIndex, _) {
// //                     final validIndex = (selectedIndex >= 0 && selectedIndex < subCategory.length)
// //                         ? selectedIndex
// //                         : 0;
// //
// //                     final subCats = subCategory[validIndex];
// //                     final subCatImages = subcategoryAssetsImages[validIndex];
// //                     final itemCount = subCats.length <= subCatImages.length
// //                         ? subCats.length
// //                         : subCatImages.length;
// //
// //                     if (itemCount == 0) {
// //                       return const Center(
// //                         child: Text(
// //                           "No subcategories available",
// //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //                         ),
// //                       );
// //                     }
// //
// //                     return Padding(
// //                       padding: const EdgeInsets.all(5),
// //                       child: GridView.builder(
// //                         itemCount: itemCount,
// //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                           crossAxisCount: 2,
// //                           mainAxisSpacing: 8,
// //                           crossAxisSpacing: 8,
// //                           childAspectRatio: 1,
// //                         ),
// //                         itemBuilder: (context, index) {
// //                           return Column(
// //                             mainAxisSize: MainAxisSize.min,
// //                             children: [
// //                                ClipOval(
// //                                   child:  Image.asset(
// //                                       subCatImages[index],
// //                                       fit: BoxFit.cover,
// //                                     height: 60,
// //                                     width: 60,
// //                                     filterQuality: FilterQuality.low,
// //                                     ),
// //                                   ),
// //                               Text(
// //                                 subCats[index],
// //                                 textAlign: TextAlign.center,
// //                                 style: GoogleFonts.italiana(
// //                                   fontWeight: FontWeight.w700,
// //                                   color: selectedIndex == index
// //                                       ? Colors.white
// //                                       : Colors.black,
// //                                 ),
// //                               )
// //                             ],
// //                           );
// //                         },
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cartfunctionlity/ui_widgets/category_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});
//
//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }
//
// class _FilterScreenState extends State<FilterScreen> {
//   List<String> category = [
//     "Beauty",
//     "Home and Living",
//     "Electronics",
//     "Men's Fashions",
//     "Women's Fashions",
//     "Sports",
//     "Vehicle",
//   ];
//
//   List<String> categoriesImages = [
//     "assets/images/categories/beauty.jpg",
//     "assets/images/categories/home_living.jpeg",
//     "assets/images/categories/electronics.jpg",
//     "assets/images/categories/men_fashions.jpg",
//     "assets/images/categories/women_fashion.jpg",
//     "assets/images/categories/sports.jpg",
//     "assets/images/categories/car.jpg"
//   ];
//
//   List<List<String>> subCategory = [
//     ["Skin Care", "Fragrance"],
//     ["Furniture", "Home Decoration", 'Kitchen Accessories', 'Groceries'],
//     ["Laptop", "Smartphone", 'Tablets', 'Mobile Accessories'],
//     ["T-Shirts", "Shoes", 'Watches'],
//     ["Dress", "Bags", 'Jewellery', 'Shoes', 'Watches', 'Tops', 'Sunglasses'],
//     ['Sports Accessories'],
//     ['Motorcycle', 'Vehicle']
//   ];
//
//   List<List<String>> subcategoryAssetsImages = [
//     [
//       "assets/images/subcategory/skinCare.jpg",
//       "assets/images/subcategory/fragrance.jpg"
//     ],
//     [
//       "assets/images/subcategory/furniture.jpg",
//       "assets/images/subcategory/homeDecoration.jpg",
//       "assets/images/subcategory/kitchen.jpg",
//       "assets/images/subcategory/groceries.jpg"
//     ],
//     [
//       "assets/images/subcategory/laptop.jpg",
//       "assets/images/subcategory/smartPhone.jpg",
//       "assets/images/subcategory/tabletDevice.jpg",
//       "assets/images/subcategory/MobileAccessories.jpg"
//     ],
//     [
//       "assets/images/subcategory/mensTShirt.jpg",
//       "assets/images/subcategory/mensShoes.jpg",
//       "assets/images/subcategory/mensWatches.jpg"
//     ],
//     [
//       "assets/images/subcategory/womensDress.jpg",
//       "assets/images/subcategory/women_bags.jpg",
//       "assets/images/subcategory/jelw.jpg",
//       "assets/images/subcategory/womenShoes.jpg",
//       "assets/images/subcategory/womenWatch.jpg",
//       "assets/images/subcategory/womenTops.jpg",
//       "assets/images/subcategory/womenSunglass.jpg"
//     ],
//     [
//       "assets/images/subcategory/sports.jpg"
//     ],
//     [
//       "assets/images/subcategory/bike.jpg",
//       "assets/images/subcategory/car.jpg"
//     ]
//   ];
//
//   List<List<String>> slugNames = [
//     ["skin-care", "fragrances"],
//     ["furniture", "home-decoration", "kitchen-accessories", "groceries"],
//     ["laptops", "smartphones", "tablets", "mobile-accessories"],
//     ["mens-shirts", "mens-shoes", "mens-watches"],
//     ["womens-dresses", "womens-bags", "womens-jewellery", "womens-shoes", "womens-watches", "tops", "sunglasses"],
//     ["sports-accessories"],
//     ["motorcycle", "vehicle"],
//   ];
//
//   final ValueNotifier<int> selectedCategoryIndex = ValueNotifier<int>(0);
//
//   @override
//   void dispose() {
//     selectedCategoryIndex.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Row(
//           children: [
//             /// Category list
//             Expanded(
//               flex: 2,
//               child: Container(
//                 color: Colors.brown.shade200,
//                 child: ValueListenableBuilder<int>(
//                   valueListenable: selectedCategoryIndex,
//                   builder: (context, selectedIndex, _) {
//                     return ListView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       itemCount: category.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () => selectedCategoryIndex.value = index,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                             decoration: BoxDecoration(
//                               color: selectedIndex == index
//                                   ? Colors.brown.shade400
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 35,
//                                   backgroundImage: AssetImage(categoriesImages[index]),
//                                   backgroundColor: selectedIndex == index
//                                       ? Colors.blue.shade300
//                                       : Colors.blue.shade100,
//                                 ),
//                                 Text(
//                                   category[index],
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.italiana(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w700,
//                                     color: selectedIndex == index
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//
//             /// Sub-category grid
//             Expanded(
//               flex: 5,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xffcfd9df), Color(0xffe2ebf0)],
//                   ),
//                 ),
//                 child: ValueListenableBuilder<int>(
//                   valueListenable: selectedCategoryIndex,
//                   builder: (context, selectedIndex, _) {
//                     final subCats = subCategory[selectedIndex];
//                     final subCatImages = subcategoryAssetsImages[selectedIndex];
//                     final slugs = slugNames[selectedIndex];
//
//                     return Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: GridView.builder(
//                         itemCount: subCats.length,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                         ),
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryDetailsScreen(slug: slugNames[selectedIndex][index]),
//                                 ),
//                               );
//                             },
//
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 ClipOval(
//                                   child: Image.asset(
//                                     subCatImages[index],
//                                     fit: BoxFit.cover,
//                                     height: 60,
//                                     width: 60,
//                                     filterQuality: FilterQuality.low,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   subCats[index],
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.italiana(
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.black,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cartfunctionlity/ui_widgets/category_details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> category = [
    "Beauty",
    "Home and Living",
    "Electronics",
    "Men's Fashions",
    "Women's Fashions",
    "Sports",
    "Vehicle",
  ];

  final List<String> categoriesImages = [
    "assets/images/categories/beauty.jpg",
    "assets/images/categories/home_living.jpeg",
    "assets/images/categories/electronics.jpg",
    "assets/images/categories/men_fashions.jpg",
    "assets/images/categories/women_fashion.jpg",
    "assets/images/categories/sports.jpg",
    "assets/images/categories/car.jpg"
  ];

  final List<List<String>> subCategory = [
    ["Skin Care", "Fragrance"],
    ["Furniture", "Home Decoration", 'Kitchen Accessories', 'Groceries'],
    ["Laptop", "Smartphone", 'Tablets', 'Mobile Accessories'],
    ["T-Shirts", "Shoes", 'Watches'],
    ["Dress", "Bags", 'Jewellery', 'Shoes', 'Watches', 'Tops', 'Sunglasses'],
    ['Sports Accessories'],
    ['Motorcycle', 'Vehicle']
  ];

  final List<List<String>> subcategoryAssetsImages = [
    [
      "assets/images/subcategory/skinCare.jpg",
      "assets/images/subcategory/fragrance.jpg"
    ],
    [
      "assets/images/subcategory/furniture.jpg",
      "assets/images/subcategory/homeDecoration.jpg",
      "assets/images/subcategory/kitchen.jpg",
      "assets/images/subcategory/groceries.jpg"
    ],
    [
      "assets/images/subcategory/laptop.jpg",
      "assets/images/subcategory/smartPhone.jpg",
      "assets/images/subcategory/tabletDevice.jpg",
      "assets/images/subcategory/MobileAccessories.jpg"
    ],
    [
      "assets/images/subcategory/mensTShirt.jpg",
      "assets/images/subcategory/mensShoes.jpg",
      "assets/images/subcategory/mensWatches.jpg"
    ],
    [
      "assets/images/subcategory/womensDress.jpg",
      "assets/images/subcategory/women_bags.jpg",
      "assets/images/subcategory/jelw.jpg",
      "assets/images/subcategory/womenShoes.jpg",
      "assets/images/subcategory/womenWatch.jpg",
      "assets/images/subcategory/womenTops.jpg",
      "assets/images/subcategory/womenSunglass.jpg"
    ],
    [
      "assets/images/subcategory/sports.jpg"
    ],
    [
      "assets/images/subcategory/bike.jpg",
      "assets/images/subcategory/car.jpg"
    ]
  ];

  final List<List<String>> slugNames = [
    ["skin-care", "fragrances"],
    ["furniture", "home-decoration", "kitchen-accessories", "groceries"],
    ["laptops", "smartphones", "tablets", "mobile-accessories"],
    ["mens-shirts", "mens-shoes", "mens-watches"],
    ["womens-dresses", "womens-bags", "womens-jewellery", "womens-shoes", "womens-watches", "tops", "sunglasses"],
    ["sports-accessories"],
    ["motorcycle", "vehicle"],
  ];

  final ValueNotifier<int> selectedCategoryIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedCategoryIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            /// Left Category List
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.brown.shade200,
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedCategoryIndex,
                  builder: (context, selectedIndex, _) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedCategoryIndex.value = index;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Colors.brown.shade400
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(categoriesImages[index]),
                                  backgroundColor: Colors.white,
                                  foregroundImage: const AssetImage(""),
                                  foregroundColor: Colors.transparent,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  category[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.italiana(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == index ? Colors.white : Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Right Subcategories Grid
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffcfd9df), Color(0xffe2ebf0)],
                  ),
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedCategoryIndex,
                  builder: (context, selectedIndex, _) {
                    final subCats = subCategory[selectedIndex];
                    final subImages = subcategoryAssetsImages[selectedIndex];
                    final slugs = slugNames[selectedIndex];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: subCats.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: ()=>PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: CategoryDetailsScreen(slug: slugs[index]),
                              withNavBar: true,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    subImages[index],
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  subCats[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.italiana(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
