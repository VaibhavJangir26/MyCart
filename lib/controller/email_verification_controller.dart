import 'dart:async';
import 'package:cartfunctionlity/utilities/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/index.dart';

class VerificationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isEmailVerified = false.obs;
  var isChecking = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    checkVerificationStatus();
  }

  // auto verification of email
  void checkVerificationStatus() {
    isChecking.value = true;
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      User? user = _auth.currentUser;
      await user?.reload();

      if (user != null && user.emailVerified) {
        isEmailVerified.value = true;
        isChecking.value = false;
        timer.cancel();
        Get.back();
        Get.to(() => const BottomNavBarWidget());
      }
    });
  }

  // it will check manually for email verification
  Future<void> verifyNow() async {
    isChecking.value = true;
    User? user = _auth.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      isEmailVerified.value = true;
      Get.back();
      Get.to(() => const BottomNavBarWidget());
    } else {
      Get.snackbar("Not Verified", "Please check your email.");
    }
    isChecking.value = false;
  }

  // resend the verification email again
  Future<void> resendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      Get.snackbar('Email Sent',"Check your inbox or spam in your mail",);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // it will show the bottom sheet for new user to verify the email
  void showVerificationBottomSheet() {
    Get.bottomSheet(
      EmailVerificationBottomSheet(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
