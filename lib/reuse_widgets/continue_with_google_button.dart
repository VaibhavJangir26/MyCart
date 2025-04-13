import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controller/index.dart';
import 'custom_text.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final authController = Get.put(AuthController());
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width * .8,
        height: height * .1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade300,
        ),
        child: Obx(
          () => InkWell(
            onTap: () {
              authController.signInWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    authController.isGoogleSignIn.value
                        ? null
                        : FontAwesomeIcons.google,
                    color: Colors.orangeAccent,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: width * .02,
                ),
                authController.isGoogleSignIn.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const CustomText(
                        text: "Continue with google",
                        color: Colors.white60,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
