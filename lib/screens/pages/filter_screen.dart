import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    "https://cdn.dummyjson.com/products/images/skin-care/Attitude%20Super%20Leaves%20Hand%20Soap/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/home-decoration/Decoration%20Swing/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/mens-shirts/Blue%20&%20Black%20Check%20Shirt/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/tops/Blue%20Frock/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/sports-accessories/American%20Football/thumbnail.png",
    "https://cdn.dummyjson.com/products/images/vehicle/300%20Touring/thumbnail.png"

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

  final List<List<String>> subCategoryImages = [
    [
      "https://cdn.dummyjson.com/products/images/skin-care/Attitude%20Super%20Leaves%20Hand%20Soap/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/fragrances/Calvin%20Klein%20CK%20One/thumbnail.png"
    ],
    [
      "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/home-decoration/Decoration%20Swing/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/kitchen-accessories/Black%20Aluminium%20Cup/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/groceries/Apple/thumbnail.png"
    ],
    [
      "https://cdn.dummyjson.com/products/images/laptops/Apple%20MacBook%20Pro%2014%20Inch%20Space%20Grey/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/smartphones/iPhone%205s/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/tablets/iPad%20Mini%202021%20Starlight/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/mobile-accessories/Amazon%20Echo%20Plus/thumbnail.png"
    ],
    [
      "https://cdn.dummyjson.com/products/images/mens-shirts/Blue%20&%20Black%20Check%20Shirt/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/mens-shoes/Nike%20Air%20Jordan%201%20Red%20And%20Black/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/mens-watches/Brown%20Leather%20Belt%20Watch/thumbnail.png"
    ],
    [
      "https://cdn.dummyjson.com/products/images/womens-dresses/Black%20Women's%20Gown/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/womens-bags/Blue%20Women's%20Handbag/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/womens-jewellery/Green%20Crystal%20Earring/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/womens-shoes/Black%20&%20Brown%20Slipper/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/womens-watches/IWC%20Ingenieur%20Automatic%20Steel/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/tops/Blue%20Frock/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/sunglasses/Classic%20Sun%20Glasses/thumbnail.png"
    ],
    [
      "https://cdn.dummyjson.com/products/images/sports-accessories/American%20Football/thumbnail.png",
    ],
    [
      "https://cdn.dummyjson.com/products/images/motorcycle/Generic%20Motorcycle/thumbnail.png",
      "https://cdn.dummyjson.com/products/images/vehicle/300%20Touring/thumbnail.png"
    ]
  ];

  final List<List<String>> slugNames = [
    ["skin-care", "fragrances"],
    ["furniture", "home-decoration", "kitchen-accessories", "groceries"],
    ["laptops", "smartphones", "tablets", "mobile-accessories"],
    ["mens-shirts", "mens-shoes", "mens-watches"],
    [
      "womens-dresses",
      "womens-bags",
      "womens-jewellery",
      "womens-shoes",
      "womens-watches",
      "tops",
      "sunglasses"
    ],
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

            /// category list
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
                        return InkWell(
                          onTap: () {
                            selectedCategoryIndex.value = index;
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
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
                                  backgroundColor: Colors.white70,
                                  backgroundImage: CachedNetworkImageProvider(
                                    categoriesImages[index],
                                    errorListener: (_)=>const Icon(Icons.error),
                                  )
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  category[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.italiana(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
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


            /// subcategory of category
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
                    final subImages = subCategoryImages[selectedIndex];
                    final slugs = slugNames[selectedIndex];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: subCats.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: CategoryDetailsScreen(slug: slugs[index]),
                              withNavBar: true,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 32,
                                  backgroundImage: CachedNetworkImageProvider(
                                    subImages[index],
                                    errorListener: (_)=>const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  subCats[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.italiana(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
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
