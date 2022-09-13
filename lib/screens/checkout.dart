import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/components/checkout_pc.dart';
import 'package:mi_crators/screens/components/checkout_phone.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: createAppBar(title: "Checkout", backButton: true),
        body: size.width >= 900 ? const CheckoutPC() : const CheckoutPhone());
  }
}
