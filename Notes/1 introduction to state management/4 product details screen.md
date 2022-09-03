    import 'package:flutter/material.dart';
    import 'package:flutter/src/foundation/key.dart';
    import 'package:flutter/src/widgets/framework.dart';

    class ProductDetailScreen extends StatelessWidget {
    const ProductDetailScreen({Key? key}) : super(key: key);
    static const routeName = '/productDetailsRoute';
    @override
    Widget build(BuildContext context) {
        final productId = ModalRoute.of(context)!.settings.arguments as String;

        return Scaffold(
        appBar: AppBar(
            title: Text('title'),
        ),
        );
    }
    }

we have build our prodcut detail screen and when the image is clicked, we navigate using push named to this screen, and pass the id of the product that was clicked to this screen, with this id, we are going to fetch for the product that is been clicked and use it inside of here

     final productId = ModalRoute.of(context)!.settings.arguments as String;

Now we need state management to handle this, we don't want to pass all the products to this class call in the routes of the main file as we were doing before, so this is going to be handle in the next file of these notes.
