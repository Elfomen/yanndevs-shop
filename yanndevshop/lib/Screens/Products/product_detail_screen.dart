import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/product_providers.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/productDetailsRoute';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<Products>(context).items.firstWhere((prod) => prod.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imageUrl , 
              fit: BoxFit.cover,),
            ),
            const SizedBox(height: 10,) ,

            Text('\$${product.price}' , 
            style: const TextStyle(
              color: Colors.grey ,
              fontSize: 20
            ),
            ) ,

            const SizedBox(height: 10,) ,

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(product.description ,
              textAlign: TextAlign.center, 
              softWrap: true,
              style: const TextStyle(
                
              ),
              ),
            )
          ],
        ),
      )
    );
  }
}
