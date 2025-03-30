import 'package:cartfunctionlity/authentication/index.dart';
import 'package:cartfunctionlity/bloc/cart_bloc/cart_bloc.dart';
import 'package:cartfunctionlity/bloc/product_bloc/index.dart';
import 'package:cartfunctionlity/firebase_options.dart';
import 'package:cartfunctionlity/repositories/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        home: const Login(),
      ),
    );
  }
}

