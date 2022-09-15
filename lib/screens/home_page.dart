import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mi_crators/constants.dart';
import 'package:mi_crators/screens/dashboard.dart';

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController posId = TextEditingController();

class HomePageController extends GetxController {
  final isLoading = false.obs;
  switchLoading() => isLoading.value = !isLoading.value;
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double pd = size.width >= 700 ? 0.4296875 * size.width : 0.34 * size.width;
    double textInputSize = size.width * 0.390625;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            child: ListView(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: "appIcon",
                            child: Container(
                              height: max(size.width * 0.1, 100) + 25,
                              width: max(size.width * 0.1, 100) + 25,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                image: const DecorationImage(
                                  image: AssetImage('images/app_log.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffe35d00),
                                    blurRadius: 20,
                                    spreadRadius: 0.0,
                                    offset: Offset(20, 20),
                                  ),
                                  BoxShadow(
                                    color: Color(0xffff7500),
                                    blurRadius: 20,
                                    spreadRadius: 0.0,
                                    offset: Offset(-20, -20),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  max(size.aspectRatio * 25, 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      createInputFields(
                          isPc: size.width > 900, textInputSize: textInputSize),
                      const SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: pd, right: pd),
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              bool valid = isValid();
                              controller.switchLoading();
                              Timer(const Duration(seconds: 3), () {
                                controller.switchLoading();
                                if (valid) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DashBoard(),
                                    ),
                                  );
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Invalid details",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    margin: const EdgeInsets.all(10),
                                    icon:
                                        const Icon(Icons.warning_amber_rounded),
                                  );
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.black,
                              elevation: 20.0,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 0.6,
                              ),
                            ),
                            child: const SizedBox(
                              width: 150.0,
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() => LoadingOverlay(
                isLoading: controller.isLoading.value,
              ))
        ],
      ),
    );
  }
}

Widget createInputFields({bool? isPc, double? textInputSize}) {
  if (isPc!) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _textInput(
              text: "Username",
              width: textInputSize,
              isPass: false,
              controller: username,
            ),
            _textInput(
              text: "Password",
              width: textInputSize,
              isPass: true,
              controller: password,
            )
          ],
        ),
        const SizedBox(height: 20),
        _textInput(
            text: "POS ID",
            width: textInputSize,
            isPass: false,
            controller: posId)
      ],
    );
  } else {
    return Column(
      children: [
        _textInput(
          text: "Username",
          width: textInputSize,
          isPass: false,
          controller: username,
        ),
        _textInput(
          text: "Password",
          width: textInputSize,
          isPass: true,
          controller: password,
        ),
        _textInput(
          text: "POS ID",
          width: textInputSize,
          isPass: false,
          controller: posId,
        ),
      ],
    );
  }
}

Widget _textInput(
    {String? text,
    double? width,
    bool? isPass,
    TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.6),
        keyboardType: TextInputType.text,
        obscureText: isPass!,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.yellow),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          labelText: text,
          labelStyle: const TextStyle(color: Colors.grey),
          hintText: 'Enter Your ${text!}',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    ),
  );
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key, this.isLoading}) : super(key: key);
  final isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitCircle(
                    color: Colors.blueGrey,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Authenticating....",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox(height: 0, width: 0);
  }
}

bool isValid() {
  if (username.text.isEmpty || password.text.isEmpty || posId.text.isEmpty) {
    return false;
  }
  if (username.text == "operator1" &&
      password.text == "password" &&
      posId.text == "DLH_01_01_3SDK34") return true;
  return false;
}
