import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget bottom() {
  return Container(
    width: double.infinity,
    color: Colors.white,
    child: buildBottom(),
  );
}

Widget buildBottom() {
  return Column(
    children: [
      Expanded(child: SizedBox(height: 13)),
      Container(
        width: double.infinity,
        child: SvgPicture.asset('assets/BackgroundBottom.svg',
          fit: BoxFit.fill
        )
      )

    ],
  );
}