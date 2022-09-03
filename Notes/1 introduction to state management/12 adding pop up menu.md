To add a pop up menu to the appBar, you need to proceed as follows

    actions: [
          PopupMenuButton(itemBuilder: (_) => [
            PopupMenuItem(child: const Text('Go to cart') , value: 0,) ,
            PopupMenuItem(child: const Text('Go to cart')) ,
            PopupMenuItem(child: const Text('Go to cart')) ,
  
          ] ,
          icon: const Icon(Icons.more_vert),
          )
        ],

Now you can see that the pop up menu item has a value which is important for us to know after which item was choosen


a more complete version

     actions: [
          PopupMenuButton(itemBuilder: (_) => [
            const PopupMenuItem(child:  Text('Only favorites') , value: 0,) ,
            const PopupMenuItem(child:  Text('Show all') , value: 1,) ,
  
          ] ,
          icon: const Icon(Icons.more_vert),
          onSelected: (int selectedValue) {
            log(selectedValue.toString());
          },
          )

Now we can simply use enumerations instead of using values of 0 and 1

this is done like below

    enum FilterOptions {
    favorite , 
    all
}

To use it, do as follows

        PopupMenuButton(itemBuilder: (_) => [
            const PopupMenuItem(child:  Text('Only favorites') , value: FilterOptions.favorite,) ,
            const PopupMenuItem(child:  Text('Show all') , value: FilterOptions.all,) ,
  
          ] ,
Remember that enumerations are always declared outside a class

### Now, we want that, when a user selects the show only favorites, we show only the favorites products to him, other wise we show all the products. One way of doing that is to declare the following methods in the products providers

      var _showFavoritesOnly = false;

    void showFavoritesOnly(){
    _showFavoritesOnly = true;
  }

  void showAll(){
    _showFavoritesOnly = false;
  }

Now any method that calls the showFavoritesOnly, will change all the displayed products and show only the favorites once, thesame for the second case.

Now in the product overview, we are going to have the following

    appBar: AppBar(
        title: const Text('Yanndevs shop'),
        actions: [
          PopupMenuButton(itemBuilder: (_) => [
            const PopupMenuItem(child:  Text('Only favorites') , value: FilterOptions.favorite,) ,
            const PopupMenuItem(child:  Text('Show all') , value: FilterOptions.all,) ,
  
          ] ,
          icon: const Icon(Icons.more_vert),
          onSelected: (FilterOptions selectedValue) {
            if(selectedValue == FilterOptions.favorite){
              productData.showFavoritesOnly();
            }else{
              productData.showAll();
            }
          },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}

You see that when there is a change, we don't go to the ProductGrid to change the display of the products but we simply call this method and it will change the show of the product directly from the providers file

# A problem

### The problem here is that, if you proceed like this and that you have another screen on your applicaiton that uses the products also, if you go on that screen and call the show all products method, if you then leave that screen and come back to the screen we just filtered, it is going to show you all the products also mean while you selected the show only favorites previously. So we really don't want to use this method to manage this. 

Instead of doing this, we can instead change our class that is using the filtered by favorite into a statefull widget and then proceed as follows

in the product overview, we can have our bool showOnlyFavorites there

    var _showOnlyFavorites = false;
Then on change of the selectors we want to do the following

  onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },

Now since we are calling the ProductGrid here, we are going to pass the _showFavorites as a paramter

      body: ProductGrid(favorites: _showOnlyFavorites),
so this file complete will be

  import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Widgets/products/product_grid.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/product_providers.dart';

enum FilterOptions { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
      var _showOnlyFavorites = false; // this should always be here and not in the build below if not the change will not be reflected even been in the set state
  @override
  Widget build(BuildContext context) {


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
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGrid(favorites: _showOnlyFavorites),
    );
  }
}


Now our product grid will have the following logic

  final productData = Provider.of<Products>(context);

    List<ProductModel> loadedProducts = favorites ? productData.favorites : productData.items;
And remembering to add the favorites method in the provider class as follows

    List<ProductModel> get favorites {
    return [..._items.where((prod) => prod.isFavorite)];
  }
and with that we solve our problem correctly