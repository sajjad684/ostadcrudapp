import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' ;
import 'package:ostadcrud/ui/screen/add_product_screen.dart';
import '../../models/product.dart';
import '../widget/product_item.dart';


class ProductItemScreen extends StatefulWidget {
   const ProductItemScreen({super.key});

  @override
  State<ProductItemScreen> createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  List <Product> productList =[];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(onPressed: (){
            _getData();
          }, icon: Icon(Icons.refresh)),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
        return productItem(
            product: productList[index],
            deleteProduct: () => deleteProduct(productList[index].id??""),
        );
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AddProductScreen.name);
      },child: Icon(Icons.add),),
    );
  }

  Future<void> _getData()async {
    productList.clear();
    setState(() {});
    Uri url = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(url);
    if(response.statusCode==200){
      final dataDecode = jsonDecode(response.body);
      for (Map<String, dynamic> p in dataDecode["data"]) {
        Product product = Product(
            id : p["_id"],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          img: p['Img'],
          unitPrice: p['UnitPrice'],
          quantity: p['Qty'],
          totalPrice: p['TotalPrice'],
          CreatedDate: p['CreatedDate'],

        );
        productList.add(product);
      }
      setState(() {});
    }

  }
  Future<void> deleteProduct(String id)async {
    Uri url = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
    print("URL: $url");
    Response response = await delete(url,
      headers:{'Content-type': 'application/json'},
    );
    print(id);
    print("Response status: ${response.statusCode}, Body: ${response.body}");
    if(response.statusCode==200){
      setState(() {
        productList.removeWhere((product) => product.id == id);
      });
      print("Product delet");
    }else{
      print("Have a problem");
    }
  }


}

