import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:cartfunctionlity/ui_widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CategoryWiseSelection extends StatefulWidget {
  const CategoryWiseSelection({super.key});

  @override
  State<CategoryWiseSelection> createState() => _CategoryWiseSelectionState();
}

class _CategoryWiseSelectionState extends State<CategoryWiseSelection> {
  List<String> categoriesImages = [
    "assets/images/categories/beauty.jpg",
    "assets/images/categories/electronics.jpg",
    "assets/images/categories/home_living.jpeg",
    "assets/images/categories/men_fashions.jpg",
    "assets/images/categories/women_bags.jpg",
    "assets/images/categories/women_fashion.jpg"
  ];

  List<String> categoriesImagesName = [
    "Beauty",
    "Electronics",
    "Home & Living",
    "Men's Fashions",
    "Bags",
    "Women's Fashions",
  ];

  List<String> slugName=[
    "beauty",
    "laptops",
    "home-decoration",
    "womens-bags",
    "mens-shirts",
    "womens-dresses",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.35,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: categoriesImages.length,
          itemBuilder: (context, index) {
            final img = categoriesImages[index];
            final category = categoriesImagesName[index];
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: CategoryDetailsScreen(
                          slug: slugName[index],
                        ),
                        withNavBar: true,
                    );
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade200,
                    backgroundImage: AssetImage(img),
                  ),
                ),
                CustomText(text: category,fontSize: 10,fontWeight: FontWeight.w700,)
              ],
            );
          },
        ),
    );
  }
}
