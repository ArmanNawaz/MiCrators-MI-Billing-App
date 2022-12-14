import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/controller/cart_controller.dart';
import 'package:mi_crators/controller/new_payment_controller.dart';
import 'package:mi_crators/controller/warranty_controller.dart';
import 'package:mi_crators/screens/checkout.dart';
import 'package:mi_crators/screens/components/new_payment_pc.dart';
import 'package:mi_crators/screens/components/new_payment_phone.dart';

late Size size;
late bool? isPc;

class WarrantySelectionController extends GetxController {
  final color = const Color(0xffc7c7c7).obs;
  updateSelection() => color.value = color.value == const Color(0xffc7c7c7)
      ? primaryColor
      : const Color(0xffc7c7c7);
}

class NewPayment extends StatelessWidget {
  final newPaymentController = Get.put(NewPaymentController());

  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    isPc = size.width > 900;
    return Scaffold(
        floatingActionButton: GetX<CartController>(builder: (controller) {
          return CreateFloatingButton(controller.total_amount.value.toString());
        }),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartDocked,
        appBar: createAppBar(title: "New Payment", backButton: true),
        body: isPc! ? NewPaymentPc() : NewPaymentPhone());
  }
}

// ignore: must_be_immutable
class WarrantyCard extends StatelessWidget {
  WarrantyController warrantyController = Get.find();
  WarrantySelectionController warrantySelectionController =
      WarrantySelectionController();
  WarrantyCard({Key? key, required this.id, this.type, this.name, this.period})
      : super(key: key);
  String? type;
  String? name;
  String? period;
  String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 30),
      child: Obx(() => GestureDetector(
            onTap: () {
              print("here");
              warrantyController.selectWarranty(int.parse(id));
              if (warrantyController.warrantySelected.value == int.parse(id)) {
                warrantySelectionController.updateSelection();
              }
            },
            onTapCancel: () {
              warrantyController.selectWarranty(0);
              warrantySelectionController.updateSelection();
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: warrantySelectionController.color.value,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Type: $type"),
                  Text("Name: $name"),
                  Text("Period: $period days"),
                ],
              ),
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class DetailsCard extends StatelessWidget {
  DetailsCard({Key? key, this.desc, this.heading}) : super(key: key);
  String? heading;
  String? desc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 40, right: 10),
          child: Text(
            heading!,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 10, left: 30, right: isPc! ? 10 : 30, bottom: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffc7c7c7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(desc!)),
          ),
        ),
      ],
    );
  }
}

class CreateFloatingButton extends StatelessWidget {
  String total_amount;

  CreateFloatingButton(this.total_amount);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: isPc! ? size.width / 2 : size.width - 20,
      child: FloatingActionButton(
        onPressed: () {
          if (int.parse(total_amount) == 0) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Empty Cart"),
                    content: const Text("Please add some items in cart"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      )
                    ],
                  );
                });
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Checkout()));
          }
        },
        elevation: 20,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Checkout : Rs. $total_amount/-",
            style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
