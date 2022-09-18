import 'package:flutter/material.dart';
import 'dart:io' show Platform;

Color primaryColor = const Color.fromRGBO(255, 105, 0, 1);
String backendUrlMobile = 'http://10.0.2.2:3000/';
String backendUrlPc = 'http://127.0.0.1:3000/';
String local_data = 'local_data';
String prevTransactions = 'prevTransactions';
String succesfulTransactions = 'succesfulTransactions';
String unsuccessfulTransactions = 'unsuccessfulTransactions';
String stock = 'stockBox';
String operatorControllerTag = 'operatorControllerTag';


PreferredSizeWidget createAppBar({String? title, bool? backButton}) {
  return AppBar(
    title: Text(title!),
    elevation: 10.0,
    backgroundColor: primaryColor,
    automaticallyImplyLeading: backButton!,
  );
}

String getHostUrl(){

  if(Platform.isWindows){
    return backendUrlPc;
  }else if(Platform.isAndroid || Platform.isIOS){
    return backendUrlMobile;
  }
  return "";

}