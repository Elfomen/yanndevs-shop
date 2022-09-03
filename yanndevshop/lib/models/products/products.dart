import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  double price = 0.0;
  int quantity;
  bool isFavorite = false;
  double ratings = 0.0;

  ProductModel({required this.quantity ,required this.id,required this.title,required this.description, required this.price, required this.imageUrl});

  void toggleFavoriteStatus(){
   isFavorite = !isFavorite; 
   notifyListeners();
  }

}