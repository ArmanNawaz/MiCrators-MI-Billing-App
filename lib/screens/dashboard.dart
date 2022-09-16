import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/controller/stock_controller.dart';
import 'package:mi_crators/screens/components/dashboard_pc.dart';
import 'package:mi_crators/screens/components/dashboard_phone.dart';
import 'package:mi_crators/screens/new_payment.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {

  final stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {

    var hiveBox = Hive.box(local_data);
    String name = hiveBox.get('first_name') + hiveBox.get('second_name');
    String paymentsAuthorised = hiveBox.get('total_items_billed').toString();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: size.width >= 900
          ? null
          : FloatingActionButton(
              elevation: 10,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewPayment()));
              },
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              tooltip: "New Payment",
              child: const Icon(Icons.add),
            ),
      appBar: createAppBar(title: "Dashboard", backButton: false),
      body: size.width > 900 ?  DashPC(name, paymentsAuthorised) :  DashPhone(name, paymentsAuthorised),
    );
  }
}
