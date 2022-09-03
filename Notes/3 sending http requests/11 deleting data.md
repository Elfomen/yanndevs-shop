  void deleteProduct(String id) async {
    final url = Uri.https("api.yanndevs.com", "/public/api/products/$id");
    await http.delete(url);
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }


as simple as that.

Now we can also do something know as uptimistic updating

void deleteProduct1(String id) async {
    final url = Uri.https("api.yanndevs.com", "/public/api/products/$id");

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);

    final existingProduct = _items[existingProductIndex];

  _items.removeWhere((prod) => prod.id == id);
    
    http.delete(url)
    .then((_){
        existingProduct = null;
    })
    .catchError((_){
      _items.insert(existingProductIndex, existingProduct);
    });
    
    notifyListeners();
  }

Now we store the product somewhere and perform the delete action, if the deletion compleeted well, then good we delete the reference to that product ,if not we re insert the product where it was

### This will not work, because in the http package, the delete request does not throws an error, so you need to test the status codes and then throw your own errors