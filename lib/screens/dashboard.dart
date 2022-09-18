import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/controller/customer_controller.dart';
import 'package:mi_crators/controller/stock_controller.dart';
import 'package:mi_crators/screens/components/dashboard_pc.dart';
import 'package:mi_crators/screens/components/dashboard_phone.dart';
import 'package:mi_crators/screens/new_payment.dart';

import '../controller/cart_controller.dart';
import '../controller/previoud_search_controller.dart';

class DashBoard extends StatelessWidget {
  final stockController = Get.put(StockController());
  final cartController = Get.put(CartController());
  final customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    final getTransactionsController = Get.put(PreviousSearchController());
    var hiveBox = Hive.box(local_data);
    String name = hiveBox.get('first_name') + ' ' + hiveBox.get('second_name');
    String paymentsAuthorised = hiveBox.get('total_items_billed').toString();
    String posId = hiveBox.get('pos_id');
    String gender = hiveBox.get('gender');
    String age = hiveBox.get('age').toString();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: size.width >= 900
          ? null
          : GetX<StockController>(builder: (controller) {
              return FloatingActionButton(
                heroTag: null,
                elevation: 10,
                onPressed: () {
                  cartController.clearCart();
                  if (controller.retriving.value == false) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPayment()));
                  }
                },
                backgroundColor:
                    controller.retriving.value ? Colors.grey : primaryColor,
                foregroundColor: Colors.white,
                tooltip: "New Payment",
                child: const Icon(Icons.add),
              );
            }),
      appBar: createAppBar(title: "Dashboard", backButton: false),
      body: size.width > 900
          ? DashPC(name, paymentsAuthorised, posId, gender, age)
          : DashPhone(name, paymentsAuthorised, posId, gender, age),
    );
  }
}
