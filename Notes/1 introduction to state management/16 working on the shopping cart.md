so we need a screen for the cart, the content of the cart screeen is going to be as follows

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/providers/cart_providers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),

      body: Column(
        children: [
          Card(margin: EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total' , style: TextStyle(
                  fontSize: 20 , 

                ),) , 
                const SizedBox(
                  width: 10,
                ) ,
                Chip(label: Text('\$${cart.cartTotal.toString()}' , style: const TextStyle(
                  color: Colors.white
                ),) ,
                backgroundColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          )
        ],
      ),
    );
  }
}

our cart total is calculated inside the cart provider file, the method is

    double get cartTotal {
        double total = 0.0;

        _items.forEach((key, cartItem) {
          total+=cartItem.price * cartItem.quantity;
        });

        return total;
  }

Now we want to render our cart items inside the cart screen

Now in the cart screen, our  list of cart items will be as follows

     const SizedBox( height: 10,) ,

          Expanded(child: ListView.builder(
            itemCount: cart.cartCount,
            itemBuilder: (ctx , i) => CartItem(id: cart.items.values.toList()[i].id, title: cart.items.values.toList()[i].title, quantity: cart.items.values.toList()[i].quantity, price: cart.items.values.toList()[i].price),
          ))
        ],
      ),
Now we have build the CartItem as a widget, so the content of the cart item is as follows

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.id, required this.price, required this.quantity, required this.title}) : super(key: key);

  final String id;
  final double price;

  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 4),

      child: Padding(padding:const EdgeInsets.all(8) , 
      child: ListTile(
        leading: CircleAvatar(
          child: Text('\$$price'),
        ),
        title: Text(title),
        subtitle: Text('Total: \$${price*quantity}'),
        trailing: Text('$quantity x'),
      ),
      ),
    );
  }
}

And now all our cart items are going to be displayed inside the list view

### as you can see on the item builder of the listview.builder above as shown below


          Expanded(child: ListView.builder(
            itemCount: cart.cartCount,
            itemBuilder: (ctx , i) => CartItem(id: cart.items.values.toList()[i].id, title: cart.items.values.toList()[i].title, quantity: cart.items.values.toList()[i].quantity, price: cart.items.values.toList()[i].price),
          ))
        ],
## to give the parameters of our cart items, we have first of all converted all the values of our objects to list before acessing the values. This is because our cart items is not a list but a map, so we can't access it as a list by doing for example cart.items[i].id ==> this is going to produce an error