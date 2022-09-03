# Now we want to fetch data from our api

we want to fetch data in the product overview when the product page loads for example, this is going to be done in the initState of the product overview

so in the provider products, you are going to have the following

      Future<void> fetchAndSetProducts () async {
        try {
          final response = await http.get(defaultProductUrl , headers: defaultHeaders);
          print(json.decode(response.body)["hydra:member"]);
        } catch (error) {
          throw error;
        }
    }


# Transforming the fetch data for it to be used in the rest of the pages

Now our fetch data is going to be 


  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(defaultProductUrl, headers: defaultHeaders);
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

Now we also want to add isLoading property in our product overview so that when the products is fetching, we show a spinner

so our init state in theat method is going to be 

@override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .catchError((error) {
          log(error);
        })
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }
remember that you can't declare the init state as async because we are overriding that method.