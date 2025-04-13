import 'package:flutter/material.dart';
import 'custom_text.dart';

class OrContinueWithText extends StatelessWidget {
  const OrContinueWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(child: Divider()),
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: "or",
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(child: Divider()),
          ],
        ));
  }
}
