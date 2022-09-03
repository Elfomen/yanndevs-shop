import 'package:flutter/foundation.dart';
import 'package:yanndevshop/models/Cart/cart.dart';
import 'package:yanndevshop/models/Order/order.dart';

class Orders with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItemModel> products , double total){
    _orders.insert(0, OrderModel(id: (DateTime.now()).toString(), amount: total, products: products, dateTime: DateTime.now()));
    notifyListeners();
  }
}