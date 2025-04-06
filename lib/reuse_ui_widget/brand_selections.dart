import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../reuse_widgets/index.dart';
import '../ui_widgets/index.dart';

class BrandSelections extends StatelessWidget {
  const BrandSelections({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * .25,
      color: Colors.brown.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1, // Move Expanded here
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    InkWell(
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const CategoryDetailsScreen(slug: "groceries"),
                        withNavBar: true,
                      ),
                      child: showItemWise("Groceries"),
                    ),
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                        width: 40,
                        height: 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green.shade300,
                        ),
                        child: const CustomText(
                          text: "New",
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CategoryDetailsScreen(slug: "vehicle"),
                    withNavBar: true,
                  ),
                  child: showItemWise("Vehicle"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CategoryDetailsScreen(slug: "motorcycle"),
                    withNavBar: true,
                  ),
                  child: showItemWise("Motorcycle"),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CategoryDetailsScreen(slug: "furniture"),
                    withNavBar: true,
                  ),
                  child: showItemWise("Furniture"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showItemWise(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      height: 50,
      child: Text(
        title,
        style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
