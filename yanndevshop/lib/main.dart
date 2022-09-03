import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Screens/Cart/cart_screen.dart';
import 'package:yanndevshop/Screens/Orders/order_screen.dart';
import 'package:yanndevshop/Screens/Products/UserProduct/edit_product_screen.dart';
import 'package:yanndevshop/Screens/Products/UserProduct/user_product_screen.dart';
import 'package:yanndevshop/Screens/Products/product_detail_screen.dart';
import 'package:yanndevshop/Screens/Products/products_overview.dart';
import 'package:yanndevshop/providers/cart_providers.dart';
import 'package:yanndevshop/providers/orders_provider.dart';
import 'package:yanndevshop/providers/product_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()) ,

        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen() , 
          CartScreen.routeName: ((context) => const CartScreen()) , 
          OrderScreen.routeName: ((context) => const OrderScreen()) ,
          UserProductScreen.routeName: ((context) => const UserProductScreen()) ,
          EditProductScreen.routeName: (((context) =>const EditProductScreen()))
        },
      ),
    );
  }
}
