import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  final ValueNotifier<bool> checkNetworkConnection = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checkNetworkDelay();
  }

  Future<void> checkNetworkDelay() async {
    await Future.delayed(const Duration(seconds: 10));
    if (mounted) {
      checkNetworkConnection.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xfffff1eb),
        Color(0xfface0f9),
      ])),
      child: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: checkNetworkConnection,
          builder: (context, value, _) {
            return value
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        size: 60,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomText(
                          text:
                              "No active internet connection. Please check your internet connection.",
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: width / 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onPressed: () {
                            checkNetworkConnection.value = false; // Reset
                            checkNetworkDelay(); // Restart the delay
                          },
                          child: const CustomText(
                            text: "Retry",
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  )
                : Lottie.asset(
                    "assets/json_files/loading.json",
                    repeat: true,
                    width: 100,
                    height: 80,
                    fit: BoxFit.fill,
                    renderCache: RenderCache.raster,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                  );
          },
        ),
      ),
    );
  }
}
