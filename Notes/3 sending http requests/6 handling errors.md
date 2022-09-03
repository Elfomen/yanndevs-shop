).then((response) {
      final newP = ProductModel(
          quantity: prod.quantity,
          id: json.decode(response.body)["id"].toString() ,
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.insert(0, newP);
      notifyListeners();
    }).catchError((error) {
        // handle your error here
    });
  }

In our case, we are going to throw our error, because we want to catch that error in the edit product screen, 

).catchError((error) {
      throw error;
    });

Now our edit product screen is gonig to be as follows

 Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct)
            .catchError((error) {
              return showDialog<Null>(context: context, builder: (ctx) => AlertDialog(
                title: const Text('An error occured'),
                content: Text(error.toString()),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(ctx).pop();
                  }, child: const Text('Ok'))
                ],
              ));
            })
            .then((_) {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
            });
