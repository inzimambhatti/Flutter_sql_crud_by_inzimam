import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/views/settings.dart';
import 'package:get/get.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(

            accountName: Text("Welcome".tr, style: TextStyle(fontSize: 20),),
            accountEmail: Text("drawer-subtitle".tr),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings".tr),
            onTap: () {
              Get.to(Settings());
            },
          )
        ],
      ),
    );
  }
}
