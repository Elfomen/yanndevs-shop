## Now we want to provide our orders

our order model

    import 'package:yanndevshop/models/Cart/cart.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderModel({required this.id, required this.amount, required this.products, required this.dateTime});
}

# the order provider is 

    import 'package:flutter/foundation.dart';
import 'package:yanndevshop/models/Cart/cart.dart';
import 'package:yanndevshop/models/Order/order.dart';

class Orders with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItemModel> products , double total){
    _orders.insert(0, OrderModel(id: (DateTime.now()).toString(), amount: total, products: products, dateTime: DateTime.now()));
    notifyListeners();
  }
}

# adding the provider to the main dart file 

     providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()) ,

        ChangeNotifierProvider(create: (ctx) => Orders())
      ],

# Adding the order now

in our cart screen when we press on the order now button, we want o add the order into the cart

 TextButton(onPressed: (){
                  Provider.of<Orders>(context , listen: false).addOrder(cart.items.values.toList(), cart.cartTotal);
                  cart.clearCart();
                }, child: const Text('ORDER NOW'))
              ],
Make sure you put the listen to false when you are calling the provider to access directly a method in the provided class