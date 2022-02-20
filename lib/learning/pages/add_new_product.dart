import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';

class AddNewProduct extends StatefulWidget{
  @override 
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct>{
  final _titleDispose = FocusNode();
  final _priceDispose = FocusNode();
  final _descriptionDispose = FocusNode();

  final _titleController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  final form  = GlobalKey<FormState>();
  var _isLoading = false;
  var _initValue = false;
  String? id;

  @override 
  void didChangeDependencies() async {
    if(_initValue){
      setState(() {
        _isLoading = true;
      });

      String? id = ModalRoute.of(context)?.settings.arguments as String;

      if(id != null){
        final response = await Provider.of<Products>(context).findById(id);
        _titleController.text = response.title;
        _stockController.text = response.stock.toString();
        _descriptionController.text = response.description;
      }

      setState(() {
        _isLoading = false;
      });
    }

    _initValue = false;
    super.didChangeDependencies();
  }

  @override 
  void dispose(){
    _titleDispose.dispose();
    _priceDispose.dispose();
    _descriptionDispose.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
      final isValid = _form.currentState.validate();

      if(!isValid){
        return;
      }

      _form.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if(id == null){
        await Provider.of<Products>(context,listen : false)
          .addProduct(ProductItem(
            id : null,
            title : _titleController.text,
            stock : int.parse(_stockController.text),
            description : _descriptionController.text 
          ));
      }else{
        await Provider.of<Products>(context,listen: false)
          .updateProduct(ProductItem(
            id : null,
            title : _titleController.text,
            stock : int.parse(_stockController.text),
            description:  _descriptionController.text
          ));
      }

      setState((){
        _isLoading = false;
      });

      Navigator.of(context).pop();
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold( 
      appBar: AppBar(
        title : Text(id == null ? 'Add New Product' : 'Edit Product'),
        actions: <Widget>[
          IconButton(
            icon : Icon(Icons.save),
            onPressed: _submit,
          )
        ],
      ),
      body : _isLoading  
        ? Center (
            child : CircularProgressIndicator()
          )
        : Padding (
            padding : EdgeInsets.all(10),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Barang'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_priceDispose);
                    },
                    validator: (value){
                      if(value == null){
                        return 'Nama Barang tidak boleh kosong';
                      }
                      if(value.toString().isEmpty){
                        return 'Nama Barang tidak boleh kosong';
                      }

                      return null;
                    },
                    controller: _titleController,
                  ), 
                  TextFormField( 
                    decoration: InputDecoration(labelText: 'Stock Barang'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_descriptionDispose)
                    },
                    validator: (value){
                      if(value == null){
                        return "Stock Kosong";
                      }

                      if(value.toString().isEmpty){
                        return "Stock Kosong";
                      }

                      if(int.parse(value) <= 0){
                        return "Stock Kosong";
                      }

                      return null;
                    },
                    controller: _stockController,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    validator: (value){
                      if(value == null){
                        return "Kosong";
                      }

                      if(value.toString().isEmpty){
                        return "Kosong";
                      }

                      return null;
                    },
                    controller:  _descriptionController,
                  )
                ],
              ),
            ),
        )
    );
  }
}