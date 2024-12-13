import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static final name = "/add-new-prodct-screen";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}
final TextEditingController  _nameController = TextEditingController();
final TextEditingController  _priceController = TextEditingController();
final TextEditingController  _totalPirceController = TextEditingController();
final TextEditingController  _imageController = TextEditingController();
final TextEditingController  _quentityController = TextEditingController();
final TextEditingController  _codeController = TextEditingController();
final _formKey= GlobalKey<FormState>();
class _AddProductScreenState extends State<AddProductScreen> {
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
                  _addProduct();
                  setState(() {});
                }
              }, child: Text("Add")),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _addProduct() async {
   Uri url=Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
   Map<String, dynamic> responseBody={
     "ProductName": _nameController.text.trim(),
     "ProductCode": _codeController.text.trim(),
     "Img": _imageController.text.trim(),
     "UnitPrice": _priceController.text.trim(),
     "Qty": _quentityController.text.trim(),
     "TotalPrice": _totalPirceController.text.trim(),
   };
   Response response = await post(
     url,
     headers:{'Content-type': 'application/json'},
     body: jsonEncode(responseBody),
   );
   if(response.statusCode==200){
     _clearTextFild();
     setState(() {});
   }
  }
 void _clearTextFild(){
    _priceController.clear();
    _codeController.clear();
    _imageController.clear();
    _nameController.clear();
    _quentityController.clear();
    _totalPirceController.clear();
 }
}
