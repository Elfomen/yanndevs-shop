Now to start using that cart provider we have just created , we need to know how we can use multiple providers in our application

So we can see that our cart is going to be neeeded in many of our screens so it will also be good that we provide it in the main file, but how do we do that?

thankfully we have multiple providers which is going to help us add more than one providers in one file, this is done as follows

    import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Screens/Products/product_detail_screen.dart';
import 'package:yanndevshop/Screens/Products/products_overview.dart';
import 'package:yanndevshop/providers/cart_providers.dart';
import 'package:yanndevshop/providers/product_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
#    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen()
        },
      ),
    );
  }
}

you can see that our muliprovider have a providers parameter which takes an array of providers

Now our cart is accecible every where in our application