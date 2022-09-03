
import 'package:flutter/foundation.dart';
import 'package:yanndevshop/models/Cart/cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  int get cartCount {
    return _items.length;
  }

  double get cartTotal {
    double total = 0.0;

    _items.forEach((key, cartItem) {
      total+=cartItem.price * cartItem.quantity;
    });
    
    return total;
  }

  void removeItem(productId){
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(productId){
     if (_items.containsKey(productId)) {
      if(_items[productId]!.quantity > 1){
        _items.update(
          productId,
          (existingCartItem) => CartItemModel(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
      }else {
        _items.remove(productId);
      }

      notifyListeners();
      
    } else {
       return;
    }
  }

  void clearCart(){
    _items.clear();
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItemModel(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItemModel(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }

    notifyListeners();
  }
}
