import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    centerTitle: false,
    title: SvgPicture.asset('assets/Logo.svg',),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color.fromRGBO(56, 39, 180, 1),
                Color.fromRGBO(108, 24, 164, 1)
              ]
          )
      ),
    ),
    scrolledUnderElevation: 0.0,
    elevation: 6,
    shadowColor: Colors.black,
  );
}