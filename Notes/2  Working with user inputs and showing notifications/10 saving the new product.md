Now we need to save the product if the save button is clicked

go to your product providers and add a save method

then after saving the form, add the following

 void _saveForm() {
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();

#      Provider.of<Products>(context).addProduct(_editedProduct);
    }
    print(_editedProduct.description);
  }