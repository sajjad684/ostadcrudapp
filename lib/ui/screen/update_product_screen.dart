import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  static const name = "/update-prodct-screen";
   final Product product;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}


class _UpdateProductScreenState extends State<UpdateProductScreen> {

  final TextEditingController  _nameController = TextEditingController();
  final TextEditingController  _priceController = TextEditingController();
  final TextEditingController  _totalPirceController = TextEditingController();
  final TextEditingController  _imageController = TextEditingController();
  final TextEditingController  _quentityController = TextEditingController();
  final TextEditingController  _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text= widget.product.productName ?? "";
    _priceController.text= widget.product.unitPrice ?? "";
    _totalPirceController.text= widget.product.totalPrice ?? "";
    _codeController.text= widget.product.productCode ?? "";
    _imageController.text= widget.product.img ?? "";
    _quentityController.text= widget.product.quantity ?? "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product Name',
                    labelText: "Product Name"
                ),
              ),
              TextFormField(
                controller: _codeController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct code";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product code',
                    labelText: "Product code"
                ),
              ),
              TextFormField(
                controller: _priceController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct Price";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product price',
                    labelText: "Product Price"
                ),
              ),
              TextFormField(
                controller: _quentityController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct quentity";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product quentity',
                    labelText: "Product quentity"
                ),
              ),
              TextFormField(
                controller: _totalPirceController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct total price";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product total price',
                    labelText: "Product total price"
                ),
              ),
              TextFormField(
                controller: _imageController,
                validator: (String? value){
                  if(value?.trim().isEmpty??true){
                    return "Enter porduct image";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Product image',
                    labelText: "Product image"
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  updateProduct();
                  setState(() {

                  });
                }

              }, child: Text("Update")),
            ],
          ),
        ),
      ),
    );
  }
  
  Future <void> updateProduct()async {
    Uri url = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}");
    Map<String, dynamic> responseBody={
      "ProductName": _nameController.text.trim(),
      "ProductCode": _codeController.text.trim(),
      "Img": _imageController.text.trim(),
      "UnitPrice": _priceController.text.trim(),
      "Qty": _quentityController.text.trim(),
      "TotalPrice": _totalPirceController.text.trim(),
    };
    Response  response = await post(url, 
        headers:{'Content-type': 'application/json'},
      body: jsonEncode(responseBody),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been updated!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product update failed! Try again.'),
        ),
      );
    }
  } 
}
