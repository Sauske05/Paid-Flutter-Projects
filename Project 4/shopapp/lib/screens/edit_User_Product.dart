import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class EditUserProduct extends StatefulWidget {
  static const route = './EditUSerProduct';
  @override
  State<EditUserProduct> createState() => _EditUserProductState();
}

class _EditUserProductState extends State<EditUserProduct> {
  final _amountfocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageURL = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _imageUrlFocusNode = FocusNode();
  var _editedproduct = Product(
      id: null,
      description: '',
      imageUrl: 'imageUrl',
      title: 'title',
      price: 0);
  var _initvalues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': 0,
  };
  @override
  void dispose() {
    // _imageUrlFocusNode.removeListener(_updateimageUrl);
    _amountfocus.dispose();
    _descriptionfocus.dispose();
    _imageURL.dispose();
    //understand
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateimageUrl);
//     super.initState();
//   }

// // understand this _updateimageUrl.
//   void _updateimageUrl() {
//     if (_imageUrlFocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

  var _isinit = true;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        _editedproduct =
            Provider.of<Products>(context, listen: false).findbyID(productID);
        _initvalues = {
          'title': _editedproduct.title,
          'description': _editedproduct.description,
          'price': _editedproduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageURL.text = _editedproduct.imageUrl;
      }
      print('Hello There $productID');
      // Provider.of<Products>(context).
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  var _isLoading = false;

  void _saveform() async {
    final validate = _form.currentState.validate();
    if (!validate) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_editedproduct.title);

    if (_editedproduct.id != null) {
      await Provider.of<Products>(
              // explain why  false/
              context,
              listen: false)
          .updateProduct(_editedproduct.id, _editedproduct);
      //this is written down
      // setState(() {
      //   _isLoading = false;
      // });
      // //// watch
      // Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addproducts(_editedproduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text(' An Error Occured'),
                //error.toString() not really good idea.
                // just sdhow a simple text.
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ],
              );
            });
      }

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();

      //check this!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveform, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  child: ListView(children: [
                    TextFormField(
                      decoration: const InputDecoration(label: Text('title')),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_amountfocus);
                      },
                      onSaved: (value) {
                        _editedproduct = Product(
                            id: null,
                            description: 'description',
                            imageUrl: 'imageUrl',
                            title: value,
                            price: 0);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a Value';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Price')),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      focusNode: _amountfocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionfocus);
                      },
                      onSaved: (value) {
                        _editedproduct = Product(
                            id: _editedproduct.id,
                            description: _editedproduct.description,
                            imageUrl: _editedproduct.imageUrl,
                            title: _editedproduct.title,
                            price: double.parse(value));
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a Value';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Description')),
                      maxLines: 3,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocus,
                      onSaved: (value) {
                        _editedproduct = Product(
                            id: null,
                            description: value,
                            imageUrl: 'imageUrl',
                            title: _editedproduct.title,
                            price: _editedproduct.price);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide a Value';
                        }
                        return null;
                      },
                    ),
                    Row(children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 4, color: Colors.grey[800])),
                        child: _imageURL.text.isEmpty
                            ? const Text('Enter Image URL')
                            : FittedBox(
                                child: Image.network(_imageURL.text),
                                fit: BoxFit.contain,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text('ImageURL')),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.url,
                          controller: _imageURL,
                          onEditingComplete: () {
                            setState(() {});
                          },
                          focusNode: _imageUrlFocusNode,
                          onSaved: (value) {
                            _editedproduct = Product(
                                id: _editedproduct.id,
                                description: _editedproduct.description,
                                imageUrl: value,
                                title: _editedproduct.title,
                                price: _editedproduct.price);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Provide a Value';
                            }
                            return null;
                          },
                        ),
                      ),
                    ])
                  ])),
            ),
    );
  }
}
