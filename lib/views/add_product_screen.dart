import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/controllers/product_controller.dart';
import 'package:get/get.dart';


class AddProductScreen extends StatelessWidget {
  final shoppingController = Get.put(ShoppingController());

  void onAddProductScreenPress() {
    if (Get.arguments != null) {
      shoppingController.handleAddButton(Get.arguments.id);
    } else {
      shoppingController.handleAddButton();
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      var args = Get.arguments;
      print(args);
      shoppingController.nameController.value.text = args.name;
      shoppingController.descriptionController.value.text = args.description;
      shoppingController.priceController.value.text = args.price.toString();
      shoppingController.imagePath.value = args.image;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.title_rounded),
                  hintText: "Name".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.nameController.value,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: "Description".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.descriptionController.value,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on_rounded),
                  hintText: "Price".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.priceController.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: FlatButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                label: FittedBox(
                  child: Obx(
                    () => Text(
                      shoppingController.imagePath.value == ""
                          ? "Select Image".tr
                          : shoppingController.imagePath.value.substring(44),
                    ),
                  ),
                ),
                onPressed: shoppingController.getImage,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.blue.shade700,
                  child: Text(
                    "Add Product".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onAddProductScreenPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
