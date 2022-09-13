// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/components/checkout_pc.dart';

class CheckoutPhone extends StatelessWidget {
  const CheckoutPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cart Items: ", style: TextStyle(fontSize: 25)),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    // height: 20,
                    width: size.width - 100,
                    decoration: BoxDecoration(
                      // color: const Color(0xffc7c7c7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ItemCard(
                          itemName: "Redmi Note 11 5G",
                          saleAmount: 25000,
                          discount: 30000,
                        ),
                        ItemCard(
                          itemName: "Mi Notebook Ultra",
                          saleAmount: 80000,
                          discount: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xffc7c7c7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomerCard(
                    title: "Phone Number",
                    keyboardType: TextInputType.phone,
                    enableFields: true,
                  ),
                  CustomerCard(
                    title: "Name",
                    keyboardType: TextInputType.text,
                    enableFields: verified,
                  ),
                  CustomerCard(
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                    enableFields: verified,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 30, right: 50, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2eeeb),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Select Payment Method",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CreatePaymentButtons(title: "Cash"),
                      CreatePaymentButtons(title: "UPI"),
                      CreatePaymentButtons(title: "Card")
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: size.width / 2,
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
                child: const Text(
                  "Confirm Payment",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  CustomerCard({Key? key, this.title, this.keyboardType, this.enableFields})
      : super(key: key);
  String? title;
  TextInputType? keyboardType;
  bool? enableFields;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title :  ", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          SizedBox(
            // width: max(size.width - 250, 200),
            child: TextField(
              onChanged: (value) {},
              keyboardType: keyboardType,
              enabled: enableFields,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                labelText: title!,
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'Enter $title',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePaymentButtons extends StatelessWidget {
  CreatePaymentButtons({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
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
          width: 100,
          height: 100,
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
