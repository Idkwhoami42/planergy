import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constraints.dart';

class BText extends StatelessWidget {
  BText({
    Key? key,
    required this.t,
    this.c,
    required this.s,
    this.w,
    this.a,
    this.f,
  }) : super(key: key);

  String t;
  Color? c;
  double s;
  TextAlign? a;
  FontWeight? w;
  String? f;

  @override
  Widget build(BuildContext context) {
    return Text(
      t,
      textAlign: a,
      style: TextStyle(
          color: c ?? pcolor,
          fontSize: s,
          fontFamily: f ?? GoogleFonts.spaceMono().fontFamily,
          fontWeight: w),
    );
  }
}
