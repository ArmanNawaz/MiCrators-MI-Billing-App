import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../new_payment.dart';

class NewPaymentPc extends StatelessWidget {
  const NewPaymentPc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: max(size.width - 120, 200),
                child: TextField(
                  onChanged: (value) {},
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
                  onPressed: () {},
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height - 200,
              width: size.width / 2 - 100,
              child: ListView(
                children: [
                  DetailsCard(
                    heading: "Category",
                    desc: "This is category desc",
                  ),
                  DetailsCard(
                    heading: "Product",
                    desc: "This is product desc",
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int ind) =>
                          WarrantyCard(
                              type: "MI Official",
                              name: "MI One Year",
                              period: "90",
                              desc: "This is desc"),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height - 300,
                  width: size.height - 300,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 30, right: 10, bottom: 10),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7c7c7),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 30, right: 10, bottom: 10),
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
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
                            "Payment",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
