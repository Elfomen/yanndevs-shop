we want to show some loading indicator to the user and when the product has been succesfully registered inside the database before we make the navigation.pop which we are doing inside the edit product screen

so for that, lets make our function add product in the provider to return a future

 Future<void> addProduct(ProductModel prod) {
    var url = Uri.https("api.yanndevs.com", "/public/api/products");

    return http.post(url,
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

Now our funcion returns a futurem, we can now go to our edit product screen and add a then function there

so our save form in that file is going to be as follows

void _saveForm() {
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();

      if (_editedProduct.id.isNotEmpty) {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
            Navigator.of(context).pop();
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct).then((_) {
              Navigator.of(context).pop();
            });
      }
    }
  }

Now adding a loading indicator, lets declare the following variables

 var _isLoading = false;

 Now when the form is submited, we want tot change it to true

 void _saveForm() {
    setState(() {
      _isLoading = true;
    });
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();

      if (_editedProduct.id.isNotEmpty) {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
            setState(() {
                _isLoading = false;
              });
            Navigator.of(context).pop();
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct).then((_) {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
            });
      }
    }
  }

  Now we want to render that inside our body like below

  body: _isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [

And now every thing works correctly