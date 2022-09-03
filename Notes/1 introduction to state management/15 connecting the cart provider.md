Now lets start using our cart providers

To do this, we are going to proceed as follows

in our cart items for example we are going to import the cart provider using the provider.of and then on click of the cart item, we are going to call the method addItem to cart that we wrote in the cart providers above

    final cart = Provider.of<Cart>(context , listen: false);
Now here we add the listen to false because all what interest us here is to add items to cart, we don't want to be notified if the cart item changes

     trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price,product.title);
            },
          )
This is how we add items to our cart

In the product overview, we want to have a shopping cart in the actions of the appbar that is gong to show us the cart screen, now we need a cart and a number just above the cart that shows the number of items in the cart. Lets create  a widget named the badge that is gong to create our cart icon for us

so our badge widget is going to return a stack as follows

    import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required this.child,
    required this.value,
    required this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}

Now in the product overview, we are adding the badge on the appbar as follows

     Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart), onPressed: () {}),
                value: cartData.cartCount.toString(),
                color: Theme.of(context).accentColor),
          )
Now, you will discover here that, we are using the consumer at the place of the provider, this is because, if we put the provider.of at the beggining of the application, any time the cart item changes, the entire widget is going to rebuild again. Meanwhile we only need this badge to update when the cart changes. Now we wrote a method inside the cart provider that returns the number of items in the cart, this method is now used here as 

    cartData.cartCount.toString()

now the builder of the consumer takes three arguments, the first we don't need it , the second is the cartObject, which will give access to all the method that are present in the cart provider and the third is the child, we could use the child at the place of the child parameter of the badge and then give the child argument to the comsumer so that it will pass this child as the third paramter of the build and then use it in the child argument of the badge, like below

    Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
                child: ch,
                value: cartData.cartCount.toString(),
                color: Theme.of(context).accentColor),
            child: IconButton(
                    icon: const Icon(Icons.shopping_cart), onPressed: () {})
          )

this is usefull in the way that, when the cart item changes, the iconButton will not rebuild again because it is not inside the builder of the consumer

## Now we have a very good result for the cart

Now we want to go to the cart page at the click of  the cart button. 