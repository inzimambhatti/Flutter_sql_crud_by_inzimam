import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/utils/localization_service.dart';
import 'package:get/get.dart';

import 'package:open_mail_app/open_mail_app.dart';

class Settings extends StatelessWidget {
  final langCtrl = Get.put(LocalizationService());

  void openMail() async {
    var result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      Get.snackbar("Warning", "No mail apps installed");
    }
  }

  /// build list of items to show in sliver
  List<Widget> _buildList() {
    List<Widget> listItems = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.language),
              const SizedBox(
                width: 10,
              ),
              Text("Language".tr),
            ],
          ),
          ElevatedButton(
            child: const Text("فارسی"),
            onPressed: () => langCtrl.changeLocale('فارسی'),
          ),
          ElevatedButton(
            child: const Text("English"),
            onPressed: () => langCtrl.changeLocale('English'),
          ),
        ],
      ),
      ListTile(
          leading: const Icon(Icons.report_problem),
          title: Text("Report Problem".tr),
          onTap: () {
            openMail();
          }),
      const SizedBox(
        height: 700,
      )
    ];

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            elevation: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network('https://i.pinimg.com/originals/82/60/8e/82608e302686b610a5c1c55563ea4cda.png'),
              centerTitle: true,
              title: Text(
                "Settings".tr,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(_buildList())),
        ],
      ),
    );
  }
}
