# Now how are we going to submit our form

we want to submit the form if the user clicks on the submit button of the last iamge url text input, or adding an action button save on the appBar

     controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    onFieldSubmitted: (_) => _saveForm(),
                  )),


appBar: AppBar(
          title: const Text('Edit or Add new product'),
          actions: [
            IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
          ],
        ),

Now what is going to happen when user clicks on save, we want to interact with the form, and to do that, we need a global key

      final _form = GlobalKey<FormState>();

Now we need to link the form to our form, this is done as follows inside the form

 child: Form(
 #           key: _form,
              child: ListView(
            children: [
              TextFormField(
                decoration:

Now we have established a connection between the form and our global key,

The global key is mostly used when we want to interact with one of our widget in the state, this is mostly used with forms

      void _saveForm(){
    _form.currentState!.save();
  }

Now we need to declare a product model that is going to receive the informations of the form

    var _editedProduct = ProductModel(quantity: 0, id: '', title: '', description: '', price: 0.0, imageUrl: '');

Now the each form fields inside the form is now having a parameter of onSaved which is going to return to you all the values of the form, inside the onSave method, you should edit the _edited product as follows

    TextFormField(
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: ((_) =>
          {FocusScope.of(context).requestFocus(_priceFocusNode)}),
      onSaved: (value) {
        _editedProduct = ProductModel(
            quantity: _editedProduct.quantity,
            id: '',
            title: value!,
            description: _editedProduct.description,
            price: _editedProduct.price,
            imageUrl: _editedProduct.imageUrl);
      },
    ),

Now you are going to do this for each of the form fields inside the form

if you now print the edited product, you are going to have the result you entered in the form


  void _saveForm() {
    _form.currentState!.save();
    print(_editedProduct.description);
  }
