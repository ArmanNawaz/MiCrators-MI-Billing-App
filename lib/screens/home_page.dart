import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double pd = size.width >= 700 ? 0.4296875 * size.width : 0.34 * size.width;
    double textInputSize = size.width * 0.390625;
    return Container(
      color: primaryColor,
      child: ListView(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: max(size.height * 0.25, 150),
                width: max(size.width * 0.15, 150),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/mi_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 100,
                    )
                  ],
                  borderRadius: BorderRadius.circular(
                    max(size.aspectRatio * 25, 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          createInputFields(
              isPc: size.width >= 700, textInputSize: textInputSize),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: pd, right: pd),
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
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
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
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
            _textInput(text: "Username", width: textInputSize),
            _textInput(text: "Password", width: textInputSize)
          ],
        ),
        _textInput(text: "POS ID", width: textInputSize)
      ],
    );
  } else {
    return Column(
      children: [
        _textInput(text: "Username", width: textInputSize),
        _textInput(text: "Password", width: textInputSize),
        _textInput(text: "POS ID", width: textInputSize)
      ],
    );
  }
}

Widget _textInput({String? text, double? width}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: SizedBox(
      width: width,
      child: TextField(
        onChanged: (value) {},
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.6),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(color: Colors.black),
          hintText: 'Enter Your ${text!}',
          hintStyle: const TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}
