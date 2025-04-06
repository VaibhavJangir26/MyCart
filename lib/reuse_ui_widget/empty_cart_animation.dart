import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartAnimation extends StatelessWidget {
  const EmptyCartAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,
            child: Lottie.asset("assets/json_files/emptyCart.json",
            filterQuality: FilterQuality.medium,
            fit: BoxFit.contain,
            repeat: true,
            ),
          ),
        ),
        const CustomText(text: "Your Cart is empty. Add item to cart 🛒",fontWeight: FontWeight.w700,fontSize: 20,textAlign: TextAlign.center,)
      ],
    );
  }
}
