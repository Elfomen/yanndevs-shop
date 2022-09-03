Now for that, the update method in the provider will become

Future<void> updateProduct(String index, ProductModel newproduct) async {
    final url = Uri.https("api.yanndevs.com", "/public/api/products/$index");

    try {
      await http.patch(url,
          headers: {
            "Content-Type": "application/merge-patch+json"
          },
          body: json.encode({
            "id": index ,
            "title": newproduct.title,
            "description": newproduct.description,
            "imageUrl": newproduct.imageUrl,
            "price": newproduct.price,
            "quantity": newproduct.quantity,
            // "isFavorite": newproduct.isFavorite,
            // "ratings": newproduct.ratings,
          }));
      final indexToMod = _items.indexWhere((prod) => prod.id == index);

      _items[indexToMod] = newproduct;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

and you can see that this works perfectly