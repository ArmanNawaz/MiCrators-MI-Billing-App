import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/components/dashboard_pc.dart';
import 'package:mi_crators/screens/components/dashboard_phone.dart';
import 'package:mi_crators/screens/new_payment.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: size.width >= 900
          ? null
          : FloatingActionButton(
              elevation: 10,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewPayment()));
              },
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              tooltip: "New Payment",
              child: const Icon(Icons.add),
            ),
      appBar: createAppBar(title: "Dashboard", backButton: false),
      body: size.width > 900 ? const DashPC() : const DashPhone(),
    );
  }
}
