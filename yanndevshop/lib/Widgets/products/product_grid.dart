import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Widgets/products/product_item.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/product_providers.dart';

class ProductGrid extends StatelessWidget {
   const ProductGrid({
    Key? key, required this.showFavs,
  }) : super(key: key);

  final bool showFavs;

  @override
  Widget build(BuildContext context) {



    final productData = Provider.of<Products>(context);

    final loadedProducts = showFavs ? productData.favorites : productData.items;

    log(loadedProducts.toString());
    
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx , i) => ChangeNotifierProvider.value(
          value: loadedProducts[i] ,
          child:  ProductItem() 
        ) 
        );
  }
}
