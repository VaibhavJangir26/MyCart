
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key,
    required this.title,
  });

  final String title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {

    final width= MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;



    return AppBar(
          title: Text(widget.title),
      backgroundColor: Colors.cyan,
        );
  }
}
