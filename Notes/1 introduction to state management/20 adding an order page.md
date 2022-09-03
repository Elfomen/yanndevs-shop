Now create your order screen and inside your are going to have the following

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/providers/orders_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),

      body: ListView.builder(itemBuilder: (ctx , i) => OrderItem(orderData.orders[i]) , itemCount: orderData.orders.length,) ,
    );
  }
}

and now your order item is going to be as follows

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:yanndevshop/models/Order/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const  EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),

            trailing: IconButton(icon: const Icon(Icons.expand_more), onPressed: (){},), // on press of this button, we want to expand the icon and view more details on the order
          )
        ],
      ),
    );
  }
}

Now in order to use the date format, do not forget that you are required to install the intl package to use it.

to install the intl package, run the follwing command

# flutter pub get intl

# adding a drawer 

the app drewer is going to be as follows, we have declared a seperate widget here

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:yanndevshop/Screens/Orders/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Hello friend'),
            automaticallyImplyLeading: false,
          ) , 
          const Divider() ,

          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () =>  Navigator.of(context).pushReplacementNamed('/'),
          ) ,

          const Divider() ,

          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () =>  Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
          )
        ],
      ),
    );
  }
}

## Now if you remember at the beggining of this file inside the order item file we had a list of orders and a button to expand and view more details on the order , now we need to create the method that is going to expand an order and view more details. the order item was as follows


  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const  EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),

            trailing: IconButton(icon: const Icon(Icons.expand_more), onPressed: (){},), // on press of this button, we want to expand the icon and view more details on the order
          )
        ],
      ),
    );
  }
}

To do that , we need our order item to be a statefull widget

Our new order item is going to be as follows

    import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:yanndevshop/models/Order/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  bool _expanded = false;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const  EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),

            trailing: IconButton(icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more), onPressed: (){
              setState(() {
                _expanded = !_expanded;
              });
            },),
          ) , 

          if(_expanded) Container(
            height: min(widget.order.products.length * 20 + 100 , 180),
            child: ListView(

             children: widget.order.products.map((prod) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(prod.title , style: const TextStyle(
                  fontSize: 18 , 
                  fontWeight: FontWeight.bold
                ),) ,

                Text('${prod.quantity} x \$${prod.price}' , style: const TextStyle(
                  fontSize: 18 , 
                  color: Colors.grey
                ),)
              ],
             )).toList()
              
            ),
          )
        ],
      ),
    );
  }
}



# Important

 if(_expanded) Container(
            height: min(widget.order.products.length * 20 + 100 , 180),
            child: ListView(

The heigth we set here simply means that, we want to calculate the height that our column is going to take from the number of products we have in the product list, now if there are too many products inside the products list, we instead want to limit the height to 180. that is why we put the two values inside the min. so if the height of all the products is more than 180, then we want to consider 180 as our height