import 'package:flutter/material.dart';
import 'package:ostadcrud/ui/screen/add_product_screen.dart';
import 'package:ostadcrud/ui/screen/product_item_screen.dart';
import 'package:ostadcrud/ui/screen/update_product_screen.dart';

import 'models/product.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name=="/"){
          widget =const ProductItemScreen();
        } else if(settings.name== AddProductScreen.name){
          widget=  const AddProductScreen();
        } else if (settings.name==UpdateProductScreen.name){
          final Product product= settings.arguments as Product;
          widget=UpdateProductScreen(product: product,);
        }
        return MaterialPageRoute(builder: (context){
         return widget;
        });
      } ,
    );
  }
}
