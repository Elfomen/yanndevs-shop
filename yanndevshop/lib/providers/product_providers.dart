import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<ProductModel> _items = [];

  final defaultProductUrl =
      Uri.https("api.yanndevs.com", "/public/api/products");
  final defaultHeaders = {'Content-Type': 'application/json'};

  List<ProductModel> get items {
    return [..._items];
  }

  List<ProductModel> get favorites {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response =
          await http.get(defaultProductUrl, headers: defaultHeaders);
      // print(json.decode(response.body)["hydra:member"]);
      final products = json.decode(response.body)["hydra:member"];
      final List<ProductModel> loadedProducts = [];

      products.forEach((prod) => {
            loadedProducts.add(ProductModel(
                quantity: prod["quantity"],
                id: prod["id"].toString(),
                title: prod["title"],
                description: prod["description"],
                // price: 29.99,
                price: prod["price"],
                imageUrl: prod["imageUrl"]))
          });

      _items = loadedProducts;
      log(_items.toString());
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(ProductModel prod) {
    return http
        .post(defaultProductUrl,
            body: json.encode({
              'title': prod.title,
              'description': prod.description,
              'imageUrl': prod.imageUrl,
              'quantity': prod.quantity,
              'price': prod.price,
              'ratings': 0.0
            }),
            headers: defaultHeaders)
        .then((response) {
      final newP = ProductModel(
          quantity: prod.quantity,
          // id: json.decode(response.body)["id"] ,
          id: json.decode(response.body)["id"].toString(),
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.insert(0, newP);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> updateProduct(String index, ProductModel newproduct) async {
    final url = Uri.https("api.yanndevs.com", "/public/api/products/$index");
    log(index);
      await http.patch(url,
          headers: {
            "Content-Type": "application/merge-patch+json"
          },
          body: json.encode({
            "id": index ,
            "title": newproduct.title,
            "description": newproduct.description,
            "imageUrl": newproduct.imageUrl,
            "price": newproduct.price,
            "quantity": newproduct.quantity,
            // "isFavorite": newproduct.isFavorite,
            // "ratings": newproduct.ratings,
          }));

      final indexToMod = _items.indexWhere((prod) => prod.id == index);

      _items[indexToMod] = newproduct;

      notifyListeners();
  }

  void deleteProduct(String id) async {
    final url = Uri.https("api.yanndevs.com", "/public/api/products/$id");
    await http.delete(url);
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  // void deleteProduct1(String id) async {
  //   final url = Uri.https("api.yanndevs.com", "/public/api/products/$id");

  //   final existingProductIndex = _items.indexWhere((prod) => prod.id == id);

  //   final existingProduct = _items[existingProductIndex];

  // _items.removeWhere((prod) => prod.id == id);
    
  //   http.delete(url).catchError((_){
  //     _items.insert(existingProductIndex, existingProduct);
  //   });
    
  //   notifyListeners();
  // }

  ProductModel findById(String id) {
    return _items.where((prod) => prod.id == id).toList()[0];
  }
}
