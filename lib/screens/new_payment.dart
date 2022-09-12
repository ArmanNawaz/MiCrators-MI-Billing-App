import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/components/new_payment_phone.dart';

import 'components/new_payment_pc.dart';

late Size size;
late bool? isPc;

class NewPayment extends StatelessWidget {
  const NewPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    isPc = size.width > 900;
    return Scaffold(
        appBar: createAppBar(title: "New Payment", backButton: true),
        body: isPc! ? NewPaymentPc() : NewPaymentPhone());
  }
}

// ignore: must_be_immutable
class WarrantyCard extends StatelessWidget {
  WarrantyCard({Key? key, this.type, this.name, this.period, this.desc})
      : super(key: key);
  String? type;
  String? name;
  String? period;
  String? desc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 30),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: const Color(0xffc7c7c7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Type: $type"),
              Text("Name: $name"),
              Text("Period: $period days"),
              Text("Desc: $desc"),
            ],
          ),
        ),
      ),
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
