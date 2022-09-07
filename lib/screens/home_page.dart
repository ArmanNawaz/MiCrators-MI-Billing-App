import 'package:flutter/material.dart';
import 'package:mi_crators/constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: primaryColor,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width / 2 - 75, top: size.height / 10),
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/mi_logo.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              _textInput(text: "Username"),
              _textInput(text: "Password"),
              _textInput(text: "POS ID")
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: Colors.black,
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
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _textInput({String? text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: SizedBox(
      width: 500,
      child: TextField(
        onChanged: (value) {},
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.6),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: Colors.black),
            hintText: 'Enter Your ' + text!,
            hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    ),
  );
}
