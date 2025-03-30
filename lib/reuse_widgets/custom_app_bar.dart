
import 'package:cartfunctionlity/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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




    return AppBar(
          title: Text(widget.title),
      
      actions: [
        
        Padding(padding: const EdgeInsets.all(8),
          child: IconButton(onPressed: (){
            Get.to(()=>const ProfileScreen());
          }, icon: const Icon(Icons.menu,color: Colors.blue,)),
        ),
        
      ],
      
        );
  }
}
