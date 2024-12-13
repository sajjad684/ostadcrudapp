
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';
import '../screen/update_product_screen.dart';

class productItem extends StatelessWidget {
  const productItem({ super.key, required this.product, required this.deleteProduct });
  final Product product;
  final VoidCallback   deleteProduct;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Image.network(product.img ??" not imaage"),
      title: Text("${product.productName}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quentity:${product.quantity}"),
          Text("product code:${product.productCode}"),
          Text("total Price:${product.totalPrice}"),
          Text("Price:${product.unitPrice}"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: deleteProduct
          , icon: Icon(Icons.delete)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,
                UpdateProductScreen.name,
                arguments: product);
          }, icon: Icon(Icons.edit)),
        ],
      ),
    );
  }




}