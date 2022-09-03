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

             children: widget.order.products.map((prod) => Padding(
               padding: const EdgeInsets.symmetric(vertical: 12),
               child: Row(
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
               ),
             )).toList()
              
            ),
          )
        ],
      ),
    );
  }
}