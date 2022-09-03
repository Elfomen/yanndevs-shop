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
    );
  }
}


Now when listening, you can make the listen to false, this is good for apps that need to fetch data only once and stick with it, so when the provider changes, you don't want to rebuild your entire application, so you do this by putting the listen property to false

     final product = Provider.of<Products>(context , listen: false).items.firstWhere((prod) => prod.id 

