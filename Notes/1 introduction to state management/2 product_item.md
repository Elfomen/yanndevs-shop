Lets build what the users are going to see as product on our screen

    class ProductItem extends StatelessWidget {
    const ProductItem(
        {Key? key, required this.imageUrl, required this.title, required this.id})
        : super(key: key);

    final String imageUrl;
    final String title;
    final String id;
    @override
    Widget build(BuildContext context) {
        return GridTile(
        child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
        ),
        footer: GridTileBar(
            backgroundColor: Colors.grey,
            title: Text(
            title,
            textAlign: TextAlign.center,
            ),
        ),
        );
    }
    }

we use the grid tile to show our product inside the grid view in the product overview


the complete product item widget is going to be as follows

     Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: (){},
        ),
        trailing: IconButton(icon: Icon(Icons.shopping_cart) , 
        onPressed: (){},),
        backgroundColor: Colors.black54,
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

now on the gridTilebar of the footer, as our text is centered, you can see that we are able to put items on the left and on the right of our text using respectively the leading and the trailing properties

    import 'package:flutter/material.dart';
    import 'package:flutter/src/foundation/key.dart';
    import 'package:flutter/src/widgets/framework.dart';

    class ProductItem extends StatelessWidget {
    const ProductItem(
        {Key? key, required this.imageUrl, required this.title, required this.id})
        : super(key: key);

    final String imageUrl;
    final String title;
    final String id;
    @override
    Widget build(BuildContext context) {
        return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            ),
            footer: GridTileBar(
            leading: IconButton(
                icon: Icon(Icons.favorite ,
                color: Theme.of(context).accentColor,
                ),
                onPressed: (){},
            ),
            trailing: IconButton(icon: Icon(Icons.shopping_cart
            , color: Theme.of(context).accentColor ,
        
            ) , 
            onPressed: (){},),
            backgroundColor: Colors.black87,
            title: Text(
                title,
                textAlign: TextAlign.center,
            ),
            ),
        ),
        );
    }
    }

you can discover that we have wrapped all the main widget here with the ClipRRect, which helps us have rounded border radius
