import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/utils/localization_service.dart';
import 'package:flutter_sql_crud_by_inzimam/views/product_list_screen.dart';
import 'package:get/route_manager.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallBackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      darkTheme: ThemeData.dark(),
      title: 'My Shopp App',
      home: ProductListScreen(),
    );
  }
}
