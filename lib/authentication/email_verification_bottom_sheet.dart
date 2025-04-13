import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/index.dart';
import '../reuse_widgets/index.dart';

class EmailVerificationBottomSheet extends StatelessWidget {
  EmailVerificationBottomSheet({super.key});



  final VerificationController verificationController =
      Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Get.width,
          height: Get.height * .6,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.email, size: 50, color: Colors.orange),
              const SizedBox(height: 10),
              const CustomText(
                text: "Verify Your Email",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              const SizedBox(height: 10),
              const CustomText(
                  text:
                      "A verification email has been sent to your email. Please verify to continue."),
              const SizedBox(height: 15),

              // it will show the loading indicator
              verificationController.isChecking.value
                  ? const Column(
                      children: [
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2)),
                        SizedBox(height: 10),
                        Text("Waiting for verification..."),
                      ],
                    )
                  : SizedBox(
                      width: Get.width * .7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: verificationController.verifyNow,
                        child: const Text(
                          "I've Verified, Check Now",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

              const SizedBox(height: 10),

              SizedBox(
                width: Get.width,
                height: Get.height * .1,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    const Text("Didn't get the verification link?"),
                    InkWell(
                      onTap: () =>
                          verificationController.resendVerificationEmail(),
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
