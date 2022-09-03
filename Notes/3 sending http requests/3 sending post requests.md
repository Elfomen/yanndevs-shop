a better place to send your http requests, for registering a new product, is inside your product providers, in the addNew product function. You can do it as follows

import 'package:http/http.dart' as http;

void addProduct(ProductModel prod){

    var url = Uri.https('http://localhost:8000', '/api/products');

    http.post(url , body: json.encode({
      'title': prod.title , 
      'description': prod.description , 
      'imageUrl': prod.imageUrl ,
      'quantity': prod.quantity , 
      'price': prod.price , 
      'isFavorite': prod.isFavorite
    }));

    final newP = ProductModel(quantity: prod.quantity, id: DateTime.now().toString(), title: prod.title, description: prod.description, price: prod.price, imageUrl: prod.imageUrl);
    _items.insert(0, newP);
    notifyListeners();
  }