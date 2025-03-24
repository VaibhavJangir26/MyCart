import 'dart:io';
import 'package:cartfunctionlity/reuse_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:badges/badges.dart' as badges;
import '../screens/index.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  final _navIndexController = PersistentTabController(initialIndex: 0);

  Future<bool> onWillPop() async {
    if (_navIndexController.index == 0) {
      exit(0);
    }
    return false;
  }

  List<Widget> screens() {
    return [
      PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (!didPop) {
            await onWillPop();
          }
        },
        child: const HomeScreen(),
      ),
      const CartScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int cartItemCount = 0;

          if (state is CartLoadedState) {
            cartItemCount = state.cartItems.length;
          }

          return PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(cartItemCount),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            controller: _navIndexController,
            navBarStyle: NavBarStyle.style3,
          );
        },
      ),
    );
  }

  List<PersistentBottomNavBarItem> navBarItems(int cartItemCount) {
    return [

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveIcon: const Icon(Icons.home_outlined),
      ),

      PersistentBottomNavBarItem(
        title: "Cart",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,

        icon: cartItemCount>0 ? badges.Badge(
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.blue.shade200,
          ),
          badgeContent: CustomText(text: "$cartItemCount",fontSize: 9,),
          child: const Icon(Icons.shopping_cart),
        ): const Icon(Icons.shopping_cart),


        inactiveIcon: cartItemCount>0 ? badges.Badge(
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.blue.shade200,
          ),
          badgeContent: CustomText(text: "$cartItemCount",fontSize: 9,),
          child: const Icon(Icons.shopping_cart_outlined),
        ): const Icon(Icons.shopping_cart_outlined),
      ),


    ];
  }
}
