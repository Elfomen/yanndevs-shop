# The provider pattern

go to pub.dev and search for the provider package, install it

    flutter pub add provider

Now lets take for example the products, we want to manage the list of products and not a single products, that is why we dont want to declare our providers inside the product model, but instead we are going to create a new folder named providers.

    class Products with ChangeNotifier {
  
    }

now our product provider class mixins in the change notifier

    class Products with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items {
    return [..._items];
  }
}

you can see above that we created the _items as private, so all other classes outside this class cannot have access to this items, so we create a getter  function to get access to the items. Now if you see, you are going to find that in the getter, we return a copy of the _items and not the items it self, because if you return the items, flutter is going to pass the pointer ( the adress ) of the items in memory, so all the other classes that get acces to the getter function can modify this items in memory and that is not what we want.

we want that, when data changes from other classes that are listenng to this class, we call methods in this same class to do the work for us.

    void addProduct(product){
        _items.add(product)
    }

Now when this is done, we need to notify all the classses that ate listening to this class that products have change, that is why we implement the ChangeNotifier class, so that at the end of the addProduct for example, we call the change notifier to notify all the rest as shown below

    void addProduct(product){
        _items.add(product);
        notifyListeners();
    }

and all the rest of the classes are going to be notified about this change and then get the newer values

Now we need to provide the products in the root level of all the classes that are going to need it

### so go to your main.dart file and wrap the material app into a new widget as follows


     // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
        create: (ctx) => Products(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
        
Now you can see that, the ChangeNotifierProvider takes a create method and then in parameter the context and returns an instance of the ProductsProvider class

# Creating our listeners in different classes

for example since we need the provider in our product view, we will proceed as follows


    class ProductGrid extends StatelessWidget {
    const ProductGrid({
        Key? key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {

    final productData = Provider.of<Products>(context);

    final loadedProducts = productData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, i) => ProductItem(imageUrl: loadedProducts[i].imageUrl, title: loadedProducts[i].title , id: loadedProducts[i].id) 
        );
  }
}

this grid view was extracted into a seperate widget


Now we have provided our products to the product overview, this is how it is done for all the rest when you are using state management

