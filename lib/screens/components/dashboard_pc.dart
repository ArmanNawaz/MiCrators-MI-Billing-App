import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/new_payment.dart';

class DashPC extends StatelessWidget {
  const DashPC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xffc7c7c7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 20),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/person.jpg'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, bottom: 30.0, right: 40),
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Arman Asim"),
                        Text("Employee"),
                        Text("Payment Authorised: 40")
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 30),
              SizedBox(
                height: 200,
                width: size.width - 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewPayment()));
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
                          width: max(size.width - 700, 200),
                          child: const Center(
                            child: Text(
                              "New Payment",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: max(size.width - 750, 200),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Payments: ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int ind) =>
                      RecentCustomerCard(
                    ind: ind + 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class RecentCustomerCard extends StatelessWidget {
  RecentCustomerCard({Key? key, this.ind}) : super(key: key);
  int? ind;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xffc7c7c7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text("Hello Customer $ind")),
      ),
    );
  }
}
