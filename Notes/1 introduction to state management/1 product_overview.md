# Declaring the product overview page

    import 'package:flutter/material.dart';
    import 'package:yanndevshop/models/products/dummy_products.dart';
    import 'package:yanndevshop/models/products/products.dart';

    class ProductOverviewScreen extends StatelessWidget {
    ProductOverviewScreen({Key? key}) : super(key: key);

    final List<ProductModel> loadedProducts = DUMMY_PRODUCTS;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text('Yanndevs shop'),
        ),

        body: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: loadedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2 , 
            childAspectRatio: 3/2 ,
            crossAxisSpacing: 10 ,
            mainAxisSpacing: 10
            ), 
            itemBuilder: (context , i) => Container()
        ),
        );
    }
    }

the body of our scaffold is a grid view builder

it has obligatory parameters which are itemBuilder and the gridDelegate, the item builder is going to be our products we want to display on the screen as shown below

    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, i) => ProductItem(imageUrl: loadedProducts[i].imageUrl, title: loadedProducts[i].title , id: loadedProducts[i].id) 
          ),
    );