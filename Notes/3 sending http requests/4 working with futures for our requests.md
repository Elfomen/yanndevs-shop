so our complete add new product function is goinig to be as follows

void addProduct(ProductModel prod) {
    var url = Uri.https("api.yanndevs.com", "/public/api/products");

    http.post(url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'imageUrl': prod.imageUrl,
          'quantity': prod.quantity,
          'price': prod.price,
          'ratings': 0.0
        }),
        headers: {'Content-Type': 'application/json'}).then((response) {
      final newP = ProductModel(
          quantity: prod.quantity,
          id: json.decode(response.body)["id"] ,
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.insert(0, newP);
      notifyListeners();
    });
  }

  You can also catch errors on the futures like below


    http.post(url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'imageUrl': prod.imageUrl,
          'quantity': prod.quantity,
          'price': prod.price,
          'ratings': 0.0
        }),
        headers: {'Content-Type': 'application/json'}).then((response) {
      final newP = ProductModel(
          quantity: prod.quantity,
          id: json.decode(response.body)["id"] ,
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.insert(0, newP);
      notifyListeners();
    }).catchError((error) {
        priint(error)
    });
  }