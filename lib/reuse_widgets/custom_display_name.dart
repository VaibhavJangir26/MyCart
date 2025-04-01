import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDisplayName extends StatelessWidget {
  const CustomDisplayName({super.key,
    required this.title,

  });

   final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.start,
        style: GoogleFonts.italiana(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
