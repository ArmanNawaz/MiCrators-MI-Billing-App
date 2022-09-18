import 'package:code_scan/code_scan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_crators/constants.dart';

class BarcodeDataController extends GetxController {
  final code = "".obs;
  changeCode(String data) => code.value = data;
}

class BarcodeScanner extends StatelessWidget {
  BarcodeScanner({Key? key}) : super(key: key);
  final BarcodeDataController myController = BarcodeDataController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: createAppBar(title: "Scan Barcode", backButton: true),
        body: Center(
          child: CodeScanner(
            once: false,
            onScan: (code, details, controller) {
              myController.changeCode(code!);
              Navigator.pop(context, myController.code);
            },
            formats: const [BarcodeFormat.all],
            loading: const Center(
              child: Text(
                "Initialising Scan",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
