## Now we wnat that if the user slide the product cart item to dismiss a product, we first show an alert that is goning to ask the user if he is sure of dismissing the item of not.

### Hint ---> this can be usefull when you are doing for example replying a message like we use to do on whatsapp, when the user slides the dismissible, you get a dismiss confirmation that is always going to return false and then you know exactly  how you are going to reply the user

so to do this, we are goning to proceed as folows

    confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text('Are you sure you wan\' to delete $title from the cart?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(ctx).pop(false);
            }, child:const Text('No')) ,

            TextButton(onPressed: (){
              Navigator.of(ctx).pop(true);
            }, child:const Text('Yes'))
          ],
        ));

      },

you can see that we are returniing a dialog that pops the navigation with the respond of true or false, so this is going to be passed to the confirmDismissed, if true , it will be dismissed and else it will stay