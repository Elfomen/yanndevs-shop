Remember we have our product items and the product view, we need to create a provider in the product view at the level of the loop that is going to provide each product to the product item instead of passing the product into parameter

os the return statement of the product views is going to be as follows

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx , i) => ChangeNotifierProvider(
          create: (c) => loadedProducts[i] as ChangeNotifier ,
          child:  ProductItem() 
        ) 
        );
  }


you see that we have another ChangeNotifierProvider here

Now in the product view we are going to have the following

 #   final product = Provider.of<ProductModel>(context);

    log(product.toString());

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
           Navigator.of(context).pushNamed(ProductDetailScreen.routeName ,
            arguments: product.id );
          },
          child: Image.network(
 #           product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

we are using this pattern so that when the user taps for example on the mark as favorite button, we change the favorite status of the product that was tapped only


Now you will notice that in the products model, we need to mix the Change notifier class  also





    
    class ProductModel with ChangeNotifier {

and then we have the following method to change the favorite status of one product  

    void toggleFavoriteStatus(){
        isFavorite = !isFavorite; 
        notifyListeners();
    }

Now you see that in the product item, we are able to call the product.toggleFavoriteStatus

    footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: product.isFavorite ? Theme.of(context).accentColor : Colors.white,
            ),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),