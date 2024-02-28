import 'package:flutter/material.dart';

Widget errorMessageForUserItem(String message) {
  return Container(
    height: 128,
    width: double.infinity,
    color: Colors.white,
    child: errorMessageForUserWidget(message),
  );
}

Widget errorMessageForUserWidget(String message) {
  return SizedBox(
    width: 255,
    child: Center(
      child: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          height: 1.2,
          color: Color.fromRGBO(230, 30, 173, 1),
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: 'SF-Pro',
        ),
      ),
    )
  );
}