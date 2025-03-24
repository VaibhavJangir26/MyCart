// // import 'package:cartfunctionlity/bloc/cart_bloc/cart_bloc.dart';
// // import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
// // import 'package:cartfunctionlity/repositories/index.dart';
// // import 'package:cartfunctionlity/utilities/bottom_navigation_bar.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:get/get.dart';
// // import 'package:hive_flutter/adapters.dart';
// // import 'models/product_model/products.dart';
// //
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   // Initialize Hive
// //   await Hive.initFlutter();
// //
// //   // Register the adapter
// //   Hive.registerAdapter(ProductAdapter());
// //
// //
// //   // Open Hive Box
// //   await Hive.openBox<Product>('products');
// //   runApp(const MyApp());
// // }
// //
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider<ProductBloc>(
// //           create: (_) => ProductBloc(productRepository: ProductRepository()),
// //         ),
// //         BlocProvider(create: (_)=>CartBloc()),
// //       ],
// //       child: GetMaterialApp(
// //         title: 'MyCart',
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
// //           useMaterial3: true,
// //         ),
// //         home: const BottomNavBarWidget(),
// //       ),
// //     );
// //   }
// // }
//
//
import 'package:cartfunctionlity/bloc/cart_bloc/cart_bloc.dart';
import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
import 'package:cartfunctionlity/repositories/index.dart';
import 'package:cartfunctionlity/utilities/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(productRepository: ProductRepository()),
        ),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: GetMaterialApp(
        title: 'MyCart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const BottomNavBarWidget(),
      ),
    );
  }
}


// import 'package:cartfunctionlity/bloc/cart_bloc/cart_bloc.dart';
// import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
// import 'package:cartfunctionlity/repositories/index.dart';
// import 'package:cartfunctionlity/utilities/bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'models/product_model/index.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // ✅ Initialize Hive
//   await Hive.initFlutter();
//
//   // ✅ Register Hive Adapters (only for stored models)
//   Hive.registerAdapter(ProductAdapter());
//   Hive.registerAdapter(DimensionAdapter());
//   Hive.registerAdapter(MetaAdapter());
//   Hive.registerAdapter(ReviewAdapter());
//
//   // ✅ Open Hive Boxes before creating ProductRepository
//   await Hive.openBox<Product>('products');
//   await Hive.openBox<Review>('reviews');
//
//   // ✅ Now that Hive is ready, create ProductRepository
//   final productRepository = ProductRepository();
//
//   runApp(MyApp(productRepository: productRepository));
// }
//
// class MyApp extends StatelessWidget {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ProductBloc>(
//           create: (_) => ProductBloc(productRepository: productRepository),
//         ),
//         BlocProvider(create: (_) => CartBloc()),
//       ],
//       child: GetMaterialApp(
//         title: 'MyCart',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//           useMaterial3: true,
//         ),
//         home: const BottomNavBarWidget(),
//       ),
//     );
//   }
// }
//
