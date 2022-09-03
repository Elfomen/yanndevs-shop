we want the user of the application to add items to the cart, this is done by first creating a class that is going to provide the cart data

so in the providers, you are going to create a cartProvider there, and in the model folder, also create a cart model 

so the content of the cart model is going to be as follows

    class CartItem {
        final String id;
        final String title;
        final int quantity;
        final double price;

        CartItem(this.id , this.title, this.quantity, this.price);
    }

now the content of the cart provider is going to be as follows

    import 'package:flutter/foundation.dart';
import 'package:yanndevshop/models/Cart/cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
  }
}


Now you can see that we have our initial items which is an object of a string and cart items, the string there is going to represent our id and the cart item is our items so at the end we are going to have something like

    {
        1 : cartItem , 
        2: cartItem
    } etc

Now we have a getter that is going to get all our items for usage in different classes, we don't want to give our origin items to the pages as we don't want them to directly modify it, just like we did on the products provider.

Now we have our addItems to cart which first verifies whether the product exist if yes we increment the quantity of the product in the cart list and if not, we add the product to the list 


# now our cart items is ready and we can start using it in our application
