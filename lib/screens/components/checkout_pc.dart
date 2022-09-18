// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/controller/cart_controller.dart';
import 'package:mi_crators/screens/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/customer_controller.dart';
import 'checkout_phone.dart';

bool verified = false;

class PaymentController extends GetxController {
  final paymentMethod = "None".obs;
  updatePaymentMethod(String value) {
    paymentMethod.value = value;
  }
}

class DropDownController extends GetxController {
  final selectedValue = "Pick".obs;
  changeSelected(String value) => selectedValue.value = value;
}

class CheckoutPC extends StatelessWidget {
  CheckoutPC({Key? key}) : super(key: key);

  List<String> deliveryModes = <String>["Pick", "Home-Delivery"];
  DropDownController controller = DropDownController();

  PaymentController paymentController = PaymentController();

  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final CustomerController customerController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    showAlertDialog(
        BuildContext context, String message, void Function() onPressed) {
      // set up the button
      Widget okButton = TextButton(
        onPressed: onPressed,
        child: const Text("OK"),
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Response"),
        content: Text(message),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cart Items: ",
                          style: TextStyle(fontSize: 25)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          // height: 20,
                          width: size.width / 2 - 100,
                          decoration: BoxDecoration(
                            // color: const Color(0xffc7c7c7),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child:
                              GetX<CartController>(builder: (cartController) {
                            List<ItemCard> items = [];
                            for (var item in cartController.cart) {
                              items.add(ItemCard(
                                itemName: item.name,
                                saleAmount: int.parse(item.cost),
                                discount: 0,
                              ));
                            }

                            return Column(children: items);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 100.0, bottom: 50),
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 30, right: 50),
                  child: Container(
                    width: size.width / 2 - 100,
                    height: 240,
                    decoration: BoxDecoration(
                      color: const Color(0xfff2eeeb),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Select Payment Method",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CreatePaymentButtons(
                                  title: "Offline",
                                  onTap: () {
                                    paymentController
                                        .updatePaymentMethod("Offline");
                                  },
                                  color:
                                      paymentController.paymentMethod.value ==
                                              "Offline"
                                          ? primaryColor
                                          : Colors.white,
                                ),
                                CreatePaymentButtons(
                                  title: "Online",
                                  onTap: () {
                                    paymentController
                                        .updatePaymentMethod("Online");
                                  },
                                  color:
                                      paymentController.paymentMethod.value ==
                                              "Online"
                                          ? primaryColor
                                          : Colors.white,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: controller.selectedValue.value == deliveryModes[0]
                    ? 470
                    : 600,
                decoration: BoxDecoration(
                  color: const Color(0xffc7c7c7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    CustomerCard(
                      onChanged: (text) async {
                        if (text.length == 10) {
                          await customerController.getCustomer(phoneNo.text);
                          name.text = customerController.name.value;
                          email.text = customerController.email.value;
                          address.text = customerController.address.value;
                        }
                      },
                      controller: phoneNo,
                      title: "Phone Number",
                      keyboardType: TextInputType.phone,
                      enableFields: true,
                    ),
                    CustomerCard(
                      onChanged: (text) {},
                      controller: name,
                      title: "Name",
                      keyboardType: TextInputType.text,
                      enableFields: true,
                    ),
                    CustomerCard(
                      onChanged: (_) {},
                      controller: email,
                      title: "Email",
                      keyboardType: TextInputType.emailAddress,
                      enableFields: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 25, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          value: controller.selectedValue.value,
                          isExpanded: true,
                          icon: const Icon(Icons.expand_more),
                          iconSize: 40,
                          underline: const SizedBox(height: 0, width: 0),
                          elevation: 16,
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            controller.changeSelected(newValue!);
                          },
                          items: deliveryModes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    controller.selectedValue.value == deliveryModes[1]
                        ? CustomerCard(
                            onChanged: (_) {},
                            controller: address,
                            title: "Address",
                            keyboardType: TextInputType.text,
                            enableFields: true,
                          )
                        : const SizedBox(height: 0, width: 0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: size.width / 2,
              height: 45,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (paymentController.paymentMethod.value == "None") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Payment Method Error"),
                              content: const Text("Select a payment method"),
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
                    } else if (paymentController.paymentMethod.value ==
                        "Online") {
                      final Uri uri = Uri.parse("https://www.google.com/");
                      launchUrl(uri);
                    } else if (await cartController.sendCartPayment(
                            customerController.phoneNo.value) ==
                        false) {
                      showAlertDialog(context, 'Unsuccessful', () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DashBoard())),
                            (route) => false);
                      });
                    } else {
                      showAlertDialog(context, 'Successful', () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DashBoard())),
                            (route) => false);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.black,
                    elevation: 20.0,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 0.6,
                    ),
                  ),
                  child: Text(
                    paymentController.paymentMethod.value == "Online"
                        ? "Pay Online"
                        : "Confirm Payment",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class CustomerCard extends StatelessWidget {
//   CustomerCard({Key? key, this.title, this.keyboardType, this.enableFields})
//       : super(key: key);
//   String? title;
//   TextInputType? keyboardType;
//   bool? enableFields;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$title :  ", style: const TextStyle(fontSize: 20)),
//           SizedBox(
//             width: max(size.width - 250, 200),
//             child: TextField(
//               onChanged: (value) {},
//               keyboardType: keyboardType,
//               enabled: enableFields,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: primaryColor),
//                     borderRadius: BorderRadius.circular(15)),
//                 focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue)),
//                 labelText: title!,
//                 labelStyle: const TextStyle(color: Colors.grey),
//                 hintText: 'Enter $title',
//                 hintStyle: const TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ItemCard extends StatelessWidget {
  ItemCard({Key? key, this.itemName, this.saleAmount, this.discount})
      : super(key: key);
  String? itemName;
  int? saleAmount;
  double? discount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              itemName!,
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sale Amount: "),
                Text(saleAmount.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Discount: "), Text(discount.toString())],
            )
          ],
        ),
      ),
    );
  }
}

class CreatePaymentButtons extends StatelessWidget {
  CreatePaymentButtons({Key? key, required this.onTap, this.title, this.color})
      : super(key: key);
  String? title;
  Color? color;

  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color!,
          foregroundColor: Colors.black,
          elevation: 10.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: const BorderSide(
            color: Colors.black,
            width: 0.6,
          ),
        ),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
