import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Screens/Cart/cart_screen.dart';
import 'package:yanndevshop/Widgets/Cart/badge.dart';
import 'package:yanndevshop/Widgets/app_drawer.dart';
import 'package:yanndevshop/Widgets/products/product_grid.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/cart_providers.dart';
import 'package:yanndevshop/providers/product_providers.dart';

enum FilterOptions { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showOnlyFavorites = false;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .catchError((error) {
          log(error.toString());
        })
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yanndevs shop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only favorites'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.all,
              ),
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  showOnlyFavorites = true;
                } else {
                  showOnlyFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    }),
                value: cartData.cartCount.toString(),
                color: Theme.of(context).accentColor),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showFavs: showOnlyFavorites),
    );
  }
}
