Now how do we want to start this>?

we want that, when a user clicks for example on the add to cart button, we do not simply add the product to the cart, but we send a notification or a popup message to the user telling him he has added a product to the cart and even go more by giving him the possibility to undo the process

we are going to do that as follows

Insie the product item, on the click event to add the product to the cart, we are going to add the following

       ),
            onPressed: () {
              cart.addItem(product.id, product.price,product.title);

              ScaffoldMessenger.of(context)
            },

### Now it is very important ot know that, the scaffold.of(context) is goning to work on the nearest scaffold possible, for example, we are calling the scaffold.of inside the product item, mean making sure that our product item does not have the scaffold widget. The page that have the scaffold widget is the page calling this product item, so all what we are going to do with the scaffold.of context here is going to take effect on the nearest page that has the scaffold object and that calls this product item. We can take another example for you to understand that, if the page that calls our product item is not having a scaffold, then the scaffold.of context we call is going to execute on the page that calls the other page that calls the product page.

### for example if we do Scaffold.of(context).openDrawer(), after adding a product to the cart, it is going to open the drawer of the the page that has the newarest scaffold widget int it.

Since this is not what we want to do, instead we want to show a notification, we are going to proceed as follows

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added item to cart')));

so when you click on the add to cart button, it us going to pop up the notification on the screen of the nearest scaffold

Now you can make it to have a duration before it goes off

ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added item to cart') , duration: Duration(seconds: 3),));

So you have many more configuration you can do there, so you can just verify and play with it as you will like

#### Now your complete scaffold messenger item is going to be as follows

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Added item to cart') , 
                duration: const Duration(seconds: 4),
                action: SnackBarAction(label: 'UNDO', onPressed: (){
                  cart.removeExistingItem(product.id);
                }),
                ));

that remove is going to be as follows

     void removeSingleItem(productId){
     if (_items.containsKey(productId)) {
      if(_items[productId]!.quantity > 1){
        _items.update(
          productId,
          (existingCartItem) => CartItemModel(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
      }else {
        _items.remove(productId);
      }

      notifyListeners();
      
    } else {
       return;
    }
  }

we have added an action to permit the user to undo his change

If you now rapidly add items to the cart, notification will show after 4 seconds before the next notification is going to show, untill the end

To prevent this from happeningm, you need to do the folllowing

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

So you will need to inser that line before ading the new scaffold messenger, the complete file of the product item is going to be as follows

    import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Screens/Products/product_detail_screen.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/cart_providers.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key}) : super(key: key);

  // final String imageUrl;
  // final String title;
  // final String id;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context);

    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Added item to cart'),
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    }),
              ));
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
