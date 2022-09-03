import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:yanndevshop/models/products/products.dart';
import 'package:yanndevshop/providers/product_providers.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/user/product/edits';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool isInit = true;

  var _editedProduct = ProductModel(
      quantity: 0,
      id: '',
      title: '',
      description: '',
      price: 0.0,
      imageUrl: '');

  var _initValues = {
    'quantity': 0,
    'id': '',
    'title': '',
    'description': '',
    'price': 0.0,
    'imageUrl': ''
  };

  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;

      if (productId != null) {
        var product = Provider.of<Products>(context, listen: false)
            .findById(productId as String);

        _editedProduct = product;

        _initValues = {
          'quantity': product.quantity,
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': ""
        };

        _imageUrlController.text = product.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    bool isFormValid = _form.currentState!.validate();
    if (isFormValid) {
      _form.currentState!.save();

      if (_editedProduct.id.isNotEmpty) {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (error) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('An error occured'),
                    content: Text(error.toString()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Ok'))
                    ],
                  ));
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit or Add new product'),
          actions: [
            IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'].toString(),
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }

                          return null;
                        },
                        onFieldSubmitted: ((_) => {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode)
                            }),
                        onSaved: (value) {
                          _editedProduct = ProductModel(
                              quantity: _editedProduct.quantity,
                              id: _editedProduct.id,
                              title: value!,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'].toString(),
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (double.parse(value) < 0) {
                              return 'Invalid price entered! Should be > 0';
                            }
                          } else {
                            return 'The price field is required';
                          }

                          return null;
                        },
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: ((_) => {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode)
                            }),
                        onSaved: (value) {
                          _editedProduct = ProductModel(
                              quantity: _editedProduct.quantity,
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: double.parse(value!),
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'].toString(),
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The Description field is required';
                          } else {
                            if (value.length < 15) {
                              return 'Description too short! Minimum characters 15';
                            }
                          }

                          return null;
                        },
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = ProductModel(
                              quantity: _editedProduct.quantity,
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: value!,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Image url')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'The image field is required';
                              }
                              if (!value.startsWith('http://') &&
                                  !value.startsWith('https://')) {
                                return 'Invalid URL, please enter a valid url';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('jpeg') &&
                                  !value.endsWith('jpg')) {
                                return 'Unsupported type image, supported types are : [png , jpg , jpeg]';
                              }

                              return null;
                            },
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (value) {
                              _editedProduct = ProductModel(
                                  quantity: _editedProduct.quantity,
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value!);
                            },
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
