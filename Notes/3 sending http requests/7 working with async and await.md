so here we are using the async and await keywords

Future<void> addProduct(ProductModel prod) async {
    var url = Uri.https("api.yanndevs.com", "/public/api/products");

    try{
        final response = await http.post(url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'imageUrl': prod.imageUrl,
          'quantity': prod.quantity,
          'price': prod.price,
          'ratings': 0.0
        }),
        headers: {'Content-Type': 'application/json'})
      
      final newP = ProductModel(
          quantity: prod.quantity,
          id: json.decode(response.body)["id"] ,
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.insert(0, newP);
      notifyListeners();
    }catch (error) {
        throw error;
    }
    
  }

and then you can go to the edit product screen and do thesame thing, declare the function as an async function and then wrap the execution of the add product in an try catch and it should be an await. save the results in a variable if it returns something in the provider and then use it as you want