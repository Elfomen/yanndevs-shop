import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/providers/cart_providers.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.id, required this.price, required this.quantity, required this.title, required this.productId}) : super(key: key);

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
        Provider.of<Cart>(context , listen: false).removeItem(productId);
      },
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text('Are you sure you wan\' to delete $title from the cart?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(ctx).pop(false);
            }, child:const Text('No')) ,

            TextButton(onPressed: (){
              Navigator.of(ctx).pop(true);
            }, child:const Text('Yes'))
          ],
        ));

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