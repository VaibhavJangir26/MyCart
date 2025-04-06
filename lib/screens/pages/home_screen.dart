import 'package:cartfunctionlity/reuse_ui_widget/index.dart';
import 'package:cartfunctionlity/screens/all_products.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../reuse_widgets/index.dart';
import '../../ui_widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

              const CustomDisplayName(
                title: "TOP PICKS BEST PRICE",
              ),

              const DisplayHorizontalDesignProducts(),

              DisplaySpecificProduct(
                slugName: "home-decoration",
                displayName: "HOME DECORATION",
                color: Colors.brown.shade100,
              ),

              DisplaySpecificProduct(
                slugName: "mens-watches",
                displayName: "MENS WATCHES",
                color: Colors.brown.shade100,
              ),

              const CustomDisplayName(
                title: "TOP SELECTIONS",
              ),

              const BrandSelections(),

              const CustomDisplayName(
                title: "ALL PRODUCTS",
              ),

              seeAllProductButton(),

              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }

  Widget seeAllProductButton() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: const AllProducts(), withNavBar: true);
          },
          child: const CustomText(
            text: "Explore MyCart ",
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
