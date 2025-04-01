import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:cartfunctionlity/utilities/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width,
                  height: height * .5,
                  child: Lottie.asset(
                    "assets/json_files/orderPlaced.json",
                    repeat: false,
                  )),
              const CustomText(
                text: "Your order has placed successfully. ",
                fontWeight: FontWeight.w800,
                fontSize: 20,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                width: width * .8,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const BottomNavBarWidget(), withNavBar: true);
                    },
                    child: const CustomText(
                      text: "Continue Shopping",
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
