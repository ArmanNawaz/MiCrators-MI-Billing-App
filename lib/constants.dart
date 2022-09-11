import 'package:flutter/material.dart';

Color primaryColor = const Color.fromRGBO(255, 105, 0, 1);

PreferredSizeWidget createAppBar({String? title, bool? backButton}) {
  return AppBar(
    title: Text(title!),
    elevation: 10.0,
    backgroundColor: primaryColor,
    automaticallyImplyLeading: backButton!,
  );
}
