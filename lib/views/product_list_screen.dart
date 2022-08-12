import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/controllers/cart_controller.dart';
import 'package:flutter_sql_crud_by_inzimam/controllers/product_controller.dart';
import 'package:flutter_sql_crud_by_inzimam/views/add_product_screen.dart';
import 'package:flutter_sql_crud_by_inzimam/views/cart_screen.dart';
import 'package:flutter_sql_crud_by_inzimam/views/my_drawer.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingController = Get.put(ShoppingController());
    final cartController = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title property shows search field or app title
          title: Obx(
            () => !shoppingController.showSearchField.value
                ? Text("title".tr)
                : TextField(
                    onChanged: (text) {
                      if (text.length == 1) {
                        Get.snackbar(
                          "Error!",
                          "Sorry this feature not available yet",
                          icon: Icon(Icons.error, color: Colors.red),
                        );
                      }
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(Icons.search_rounded),
                      labelText: "Search".tr,
                    ),
                  ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              // Obx handles change event, and listens to changes then set the new
              // state based on the changed state.
              icon: Obx(
                () => Icon(shoppingController.showSearchField.value
                    ? Icons.search_off
                    : Icons.search),
              ),
              onPressed: shoppingController.toggleShowSearch,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(AddProductScreen()),
            )
          ],
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.orange,
        body: Column(
          children: [
            ProductList(cartController: cartController),
            GetX<CartController>(
              init: CartController(),
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Amount".tr,
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                    Text(
                      ": \$ ${controller.totalPrice.toPrecision(2)}",
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 100),
          ],
        ),
        floatingActionButton: GetX<CartController>(
          init: CartController(),
          builder: (controller) {
            return FloatingActionButton.extended(
              onPressed: () {
                Get.to(CartItemsScreen());
                if (shoppingController.showSearchField.value) {
                  shoppingController.toggleShowSearch();
                }
              },
              label: Text(controller.count.toString()),
              icon: Icon(Icons.shopping_cart_outlined),
            );
          },
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.cartController,
  }) : super(key: key);

  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<ShoppingController>(
        builder: (controller) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    size: 50,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteProduct(controller.products[index]);

                  Get.snackbar(
                    "${controller.products[index].name} Deleted!",
                    "",
                    icon: Icon(Icons.message),
                    onTap: (_) {},
                    barBlur: 20,
                    isDismissible: true,
                    duration: Duration(seconds: 2),
                  );
                },
                key: UniqueKey(),
                child: GestureDetector(
                  onDoubleTap: () {
                    // Open existing Product item  in Add New Product Screen.
                    // Get.to(
                    //   AddProductScreen(),
                    //   arguments: controller.products[index],
                    // );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.file(
                                File(controller.products[index].image!),
                                width: 64.0,
                                height: 64.0,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "\$${controller.products[index].price}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.products[index].name}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              RaisedButton.icon(
                                onPressed: () {
                                  cartController
                                      .addToCart(controller.products[index]);
                                },
                                color: Colors.blue,
                                textColor: Colors.white,
                                icon: Icon(Icons.add_shopping_cart),
                                label: Text("Add to Cart".tr),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.products.length,
          );
        },
      ),
    );
  }
}
