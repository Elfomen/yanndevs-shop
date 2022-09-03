How do we validate all the inputs of the form,?

this is done by adding a validator on each of the inputs

for example

    validator: (value) {
                    if(value!.isEmpty){
                      return 'This field is required';
                    }

                    return null;
                  },

Now if you write your validator and just return null, then your text will consider that every thing we enter or if we don't even enter any thing, it will approve it.

now if you return a text or any other thing, then this will be shown as an error to the user, you are the one who knows how your validator is going to be.

### Now before it works, you will need to trigger the validation, to do that, you should go into the mehtod where you saved the form and trigger the validation there as follows

 void _saveForm() {
    _form.currentState!.validate();
    _form.currentState!.save();
    print(_editedProduct.description);
  }

Now we want to save the form only if the validator is true, so the above method is going to be as follows

    void _saveForm() {
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();
    }
    print(_editedProduct.description);
  }


validating an image

    validator: (value){
                        if(value!.isEmpty){
                          return 'The image field is required';
                        }
                        if(!value.startsWith('http://') && !value.startsWith('https://')){
                          return 'Invalid URL, please enter a valid url';
                        }
                        if(!value.endsWith('.png') && !value.endsWith('jpeg') && !value.endsWith('jpg')){
                          return 'Unsupported type image, supported types are : [png , jpg , jpeg]';
                        }

                        return null;
                      },