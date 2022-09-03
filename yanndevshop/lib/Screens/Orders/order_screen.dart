import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Widgets/Orders/order_item.dart';
import 'package:yanndevshop/Widgets/app_drawer.dart';
import 'package:yanndevshop/providers/orders_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {

    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),

      drawer: const AppDrawer(),

      body: ListView.builder(itemBuilder: (ctx , i) => OrderItem(order: orderData.orders[i]) , itemCount: orderData.orders.length,) ,
    );
  }
}