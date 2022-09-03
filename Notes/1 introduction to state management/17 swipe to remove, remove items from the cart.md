we want that when an item is swipped, we delete it from our cart

Now to do that, thankfully flutter provides us with a widget named dismissable, this is used as follows

go to your cart_item and wrap the cart with the dismissible widget,

#    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 4),
    
        child: Padding(padding:const EdgeInsets.all(8) , 
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(child: Text('\$$price')),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price*quantity}'),
          trailing: Text('$quantity x'),
        ),
        ),
      ),
    );
  }
}

Now we have to give it a key that identifies it uniquely and then a background that is going to be shown when the user is dragging the element to dismiss.

### important, if you allow it like this, when the user dismiss it, it is dismissed only from the user interface and not deleted from our state or our database, to delete that completely, we need to listen to that slide

so to do that, we need to listen to the onDismissed listener which is implemented as follows

    onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(id);
      },

The removeItem function is been implementd in the cart provider as follows

      void removeItem(productId){
    _items.remove(productId);
    notifyListeners();
  }

### Now we need to receive our product id from the class that is going to call our cart item because remember the id we have here is our cart id and not the product id.

so in our cart screen we call the cart item as follows

     Expanded(child: ListView.builder(
            itemCount: cart.cartCount,
#            itemBuilder: (ctx , i) => CartItem(productId:  cart.items.keys.toList()[i], id: cart.items.values.toList()[i].id, title: cart.items.values.toList()[i].title, quantity: cart.items.values.toList()[i].quantity, price: cart.items.values.toList()[i].price),
          ))

We pass the key of the cart item because in our cart items the key is the product id

Now the complete cart item file is as follows

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/providers/cart_providers.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.id, required this.price, required this.quantity, required this.title}) : super(key: key);

  final String id;
  final double price;
final String productId;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete , color: Colors.white, size: 40,),
        alignment: Alignment.centerRight,
        padding:const EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 4),
    
        child: Padding(padding:const EdgeInsets.all(8) , 
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(child: Text('\$$price')),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price*quantity}'),
          trailing: Text('$quantity x'),
        ),
        ),
      ),
    );
  }
}