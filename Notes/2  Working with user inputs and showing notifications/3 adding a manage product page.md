### we now want a page that is going to help us manage our products like adding a new product, deleting a product or even modifying a product

the content of the page will be as folows

    import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.28,
        child: Row(
          children: [
            IconButton(onPressed: (){
        
            }, icon: Icon(Icons.edit , color: Theme.of(context).primaryColor,)) ,
        
            IconButton(onPressed: (){
        
            }, icon: const Icon(Icons.delete , color: Colors.red,))
          ],
        ),
      ),
    );
  }
}

now on click of the edit icon we want to navigate to another screen that is going to containt the form for the user to add another product, this screen content is going to be as follows

