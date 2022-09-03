# Now we want to update a product

To edit a product, we are still going to need thesame form we used to create a new product. the only difference is that we are going to pass a parameter and the edit product screen is going to know what to do there

child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName , arguments: id);
            }, icon: Icon(Icons.edit , color: Theme.of(context).primaryColor,)) ,
        
            IconButton(onPressed: (){
        
            }, icon: const Icon(Icons.delete , color: Colors.red,))
          ],
        ),

you can see that we pass the id of the product into parameter

Now in the edit product screen, we are going to proceed as follows

bool isInit = true;

    @override
  void didChangeDependencies() {
    if(isInit){
      final productId = ModalRoute.of(context)!.settings.arguments as String;

      var product = Provider.of<Products>(context , listen: false).findById(productId);

      _editedProduct = product;
    }
    isInit = false;
    super.didChangeDependencies();
  }

Now what remains is to prefill all the input values of the form

we will declare an init value which will be empty at the beggining

    var _initValues = {
    'quantity': 0,
    'id': '',
    'title': '',
    'description':'',
    'price': 0.0,
    'imageUrl':''
  };

now when we find the product, we override the init value

     @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;

      if (productId.isNotEmpty) {
        var product =
            Provider.of<Products>(context, listen: false).findById(productId);

        _editedProduct = product;

        _initValues = {
          'quantity': product.quantity,
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl
        };
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

Now we need to pass the initial vbalues of the fields

    TextFormField(
      initialValue: _initValues['description'].toString(),
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'The Description field is required';
        } else {
          if (value.length < 15) {
            return 'Description too short! Minimum characters 15';
          }
        }

        return null;
      },
Now remember that for the image, we are using a controller, so we cant use the initValue again, so for that inside the didChangeDependencies, we will instead do


        _initValues = {
          'quantity': product.quantity,
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': ""
        };

        _imageUrlController.text = product.imageUrl;
      }

and the image text input will be

     Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The image field is required';
                        }
                        if (!value.startsWith('http://') &&
                            !value.startsWith('https://')) {
                          return 'Invalid URL, please enter a valid url';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('jpeg') &&
                            !value.endsWith('jpg')) {
                          return 'Unsupported type image, supported types are : [png , jpg , jpeg]';
                        }

                        return null;
                      },
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) {
                        _editedProduct = ProductModel(
                            quantity: _editedProduct.quantity,
                            id: '',
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value!);
                      },

Now every thing works normally

If we cllick on the save button to update, it will instead create a new product, we instead need to update the product, to manage that, go into your provider and then modify the add product to verify if the product already exists, if yes , update it and if no, create it (this is one method)

### But there is a best way of doing it, just by checking if our edited product.id is defined because this will be defined only if we are modifying the product

so for that we need to write the update product method in the provider

      void updateProduct(String index , ProductModel newproduct){
    final indexToMod = _items.indexWhere((prod) => prod.id == index);

    _items[indexToMod] = newproduct;

    notifyListeners();

  }
Now in the edit proeuct screen

    void _saveForm() {
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();

      if(_editedProduct.id.isNotEmpty){
        Provider.of<Products>(context).updateProduct(_editedProduct.id, _editedProduct);
      }else{
        Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
      }

      

      Navigator.of(context).pop();
    }
    print(_editedProduct.description);
  }

Now on the onSave method of the form fields, instead of putting the id's to '' , you should instead put it back to _edited product.id as below

     onSaved: (value) {
                    _editedProduct = ProductModel(
                        quantity: _editedProduct.quantity,
 #                       id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),

# Now every thing works perfectly