
import 'package:cartfunctionlity/reuse_widgets/index.dart';
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

    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return AppBar(
          title: Text(widget.title),

      
      actions: [


        Container(
          width: width*.45,
          height: height*.07,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2,color: Colors.grey),
          ),
          child: InkWell(
            onTap: ()=>showSearch(context: context, delegate: MySearchBar()),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search),
                Text("Search...")
              ],
            ),
          ),
        ),

        
        Padding(padding: const EdgeInsets.all(8),
          child: IconButton(onPressed: (){
            Get.to(()=>const ProfileScreen());
          }, icon: const Icon(Icons.settings,color: Colors.blue,)),
        ),
        
      ],
      
        );
  }
}
