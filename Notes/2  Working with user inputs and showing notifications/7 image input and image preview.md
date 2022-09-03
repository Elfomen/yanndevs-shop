# Adding image input

the image input and the image preview is going to be as follows

    Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Container(),
                  ),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    // controller: _imageUrlController,
                    onEditingComplete: () {
                      setState(() {});
                    },
                  )),
                ],
              )

Now for the preview of the image in that controller, you are going to add a text editing controller, to get the image url the user is going to endter

final _imageUrlController = TextEditingController();

Now do never forget to dispose the controller to prevent memory leakage

@override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

### Now good hint, if we wanted to get the value of the image url after the form is submitted, then we wouild have not used a text editing controller, but here we want to get the value of the image url before the text is submitted, that is why we use it

Now you add the preview image on the container as follows

  Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(top: 8, right: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey)),
      child: _imageUrlController.text.isEmpty ? const Text('Image uFittedBox(
        child: Image.network(_imageUrlController.text , fit: BoxFit.cover,),
      ),
    ),

Now when the user enters an image url and submit this text input, the preview is going to show on the container we just declared above, now we don't want that the image should show only on click of the submit button but that it should also show when that input loses focus, to do that, you are also going to declare the focus node for that input

    final _imageUrlFocusNode = FocusNode();

  lets add this to the input text
   Expanded(
        child: TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
#      focusNode: _imageUrlFocusNode,
      onEditingComplete: () {
        setState(() {});
      },
    )),

Now we need to add a listener to this focus node so that when it loses focus, we know what we are going to do after that, so a great place to initially set a listener is in the initState()

   @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

Now since we are dealing with adding a listener to the focus node, we also do not want to forget to remove the listener in the dispose method

      _imageUrlFocusNode.removeListener(_updateImageUrl);

Now we need to create the function _updateImageUrl, the content of that function is as follows


  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {
        
      });
    }
  }

Now this is a hack, you can see that in our setstate, we have nothing inside there. What we are doing is that, we simply test if the input have lost it focus and if yes, we simply call the setState method to completely rebuild the entire state to force the container to show our image for us

And now our input works perfectly