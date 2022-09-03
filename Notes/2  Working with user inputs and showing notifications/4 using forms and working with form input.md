Now instead of collecting the users input using the text controllers and all the rest, we are simply going to used the build in widget known as the form to collect the user informations

this is done as follows

     body: Form(child: ListView(
        children: [
          TextFormField()
        ],
      )
      )
you can see that instead of using the text fields as usual, we are going to use instead the text form field, so the complete form is going to be as follows

     children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title'
            ),

            textInputAction: TextInputAction.next,
          )
        ],
you can see up there that we have added a textInputAction, which means that when we finish entering values inside this textform input, instead of submitting the form, we instead pass to the next value

Now our second imput is going to be as folows

     TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            )

you can see that we have changed the keyboardType to take a number, now we are going to make in such a way that when the submit or the done button that appears on the keyboard when we add the textInputAction: TextInputAction.next, is clicked, it goes to the next text input, this has to be configured manually

to do that, we need to declare focus nodes, for example we are going to have the following


class _EditProductScreenState extends State<EditProductScreen> {

#  final _priceFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

and then we are going to make our price input to focus on this focus node

    TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
#              focusNode: _priceFocusNode,
            )

Now when the first input whcih is that of the title field is submitted, we want to go to the focused node we have just created which is the priceFocusnode (the second input)

     TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title'
              ),

              textInputAction: TextInputAction.next,
              onFieldSubmitted: ((_) => {
                FocusScope.of(context).requestFocus(_priceFocusNode)
              }),
            ) ,

Now onsubmitted we see that we instead focus on the second input text form


## Input field for description

  TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description'
              ),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              focusNode: _descriptionFocusNode,
            ) ,

### Now never forget, when you are working with focus node, if you don't dispose them, you may end up having memory leaks. so you should override the dispose method in order to dispose at the end when the page is closed, all the focus node that you have declared

    final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();


  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }