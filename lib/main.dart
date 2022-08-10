import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/screens/productList.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: ProductListPage(),
    );
  }
}