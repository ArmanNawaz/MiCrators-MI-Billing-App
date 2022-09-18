// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/controller/cart_controller.dart';
import 'package:mi_crators/controller/warranty_controller.dart';
import 'package:mi_crators/model/bill_item_model.dart';
import 'package:mi_crators/screens/components/barcode_scanner.dart';
import 'package:mi_crators/screens/new_payment.dart';

import '../../controller/new_payment_controller.dart';

class InputController extends GetxController {
  Rx<TextEditingController> textEditingController = TextEditingController().obs;
  updateText(String value) => textEditingController.value.text = value;
}

class NewPaymentPhone extends StatelessWidget {
  InputController controller = InputController();
  CartController cartController = Get.find();
  final warrantyController = Get.put(WarrantyController());


  NewPaymentController newPaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Obx(
                //   () =>
                // ),
                SizedBox(
                  width: max(size.width - 120, 200),
                  child: TextField(
                    onChanged: (text) async{
                      print(text.length);
                      if(text.length == 11){
                        print('Searching...');
                        await newPaymentController.loadItem(text);
                      }else newPaymentController.reset();
                    },
                    controller: controller.textEditingController.value,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: "Input Serial Number",
                      labelStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Enter BarCode Serial Number',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      var value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarcodeScanner()));
                      print(
                          "This is the value of barcode = ${value.toString()}");
                      controller.updateText(value.toString());
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
                    child: const Center(
                      child: Icon(
                        Icons.document_scanner_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height - 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 10),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7c7c7),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  GetX<NewPaymentController>(
                    builder: (controller) {
                      return Column(
                        children: [
                          DetailsCard(
                            heading: "Category",
                            desc: controller.categoryName.value,
                          ),
                          DetailsCard(
                            heading: "Product",
                            desc: controller.productName.value,
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.warranties.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap:(){
                                      warrantyController.selectWarranty(controller.warranties[index].warranty_id);
                                    },
                                    child: WarrantyCard(
                                        id: controller.warranties[index].warranty_id.toString(),
                                        type: controller.warranties[index].warranty_type,
                                        name: controller.warranties[index].warranty_name,
                                        period: controller.warranties[index].days_valid.toString(),
                                        desc: ""),
                                  ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 30, right: 10, bottom: 10),
                    child: SizedBox(
                      height: 45,

                      // ADD TO CART BUTTON

                      child: ElevatedButton(
                        onPressed: () async{
                          var serialNo =  controller.textEditingController.value.text.toString();
                          var details1= await Hive.lazyBox(stock).get(serialNo);
                          print(details1['cost']);
                          // Map<String, dynamic> details = await Hive.lazyBox(stock).get(serialNo);
                          String cost = details1['cost'].toString();
                          String warranty = warrantyController.warrantySelected.value.toString();
                          String name = details1['product_name'];
                          cartController.addInCart(BillItemModel(serial_no: serialNo, data: DateTime.now().toString(), cost: cost, warranty_id: warranty
                              , name: name));
                          newPaymentController.reset();
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
                        child: SizedBox(
                          width: size.height - 350,
                          child: const Center(
                            child: Text(
                              "Add to Cart",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
