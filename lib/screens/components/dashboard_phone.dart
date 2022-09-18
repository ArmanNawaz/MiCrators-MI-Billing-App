import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../controller/previoud_search_controller.dart';
import 'dashboard_pc.dart';

class DashPhone extends StatelessWidget {

  final String name, paymentsAuthorised;

  DashPhone(this.name, this.paymentsAuthorised);

  final getTransactionsController = Get.put(PreviousSearchController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            height: 200,
            // width: size.width / 2,
            decoration: BoxDecoration(
              color: const Color(0xffc7c7c7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 20),
                  child: CircleAvatar(
                    radius: size.width >= 400 ? 50 : 30,
                    backgroundImage: const AssetImage('images/person.jpg'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 30.0, right: 20),
                  child: VerticalDivider(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text("Employee"),
                    Text("Payment Authorised: ${paymentsAuthorised}")
                  ],
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: max(size.width - 110, 200),
              child: TextField(
                onChanged: (value) {},
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: "Search payment by Customer ID",
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter Customer ID',
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
                child: const Center(child: Icon(Icons.search)),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            "Recent Payments: ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: size.width,
          child: GetX<PreviousSearchController>(
              builder: (prevController){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: prevController.previoudPayments.value.length,
                  itemBuilder: (BuildContext context, int index) =>
                  RecentCustomerCard(
                    ind: prevController.previoudPayments.value[index].customerId as int,
                  ),
                );
              },
            ),
        ),
      ],
    );
  }
}
