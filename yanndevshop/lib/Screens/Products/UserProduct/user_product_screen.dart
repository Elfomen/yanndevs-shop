
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/Screens/Products/UserProduct/edit_product_screen.dart';
import 'package:yanndevshop/Widgets/app_drawer.dart';
import 'package:yanndevshop/Widgets/products/user_products/user_product_item.dart';
import 'package:yanndevshop/providers/product_providers.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user/products';

  Future<void> _refreshIndicator(BuildContext context)async {
    await Provider.of<Products>( context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        }, icon: const Icon(Icons.add))],
        title: const Text('Your products'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshIndicator(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                    title: productData.items[i].title,
                    imageUrl: productData.items[i].imageUrl ,
                    id: productData.items[i].id,
                    ),
                  
      
                const Divider() ,
      
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),

      drawer: const AppDrawer(),
    );
  }
}
