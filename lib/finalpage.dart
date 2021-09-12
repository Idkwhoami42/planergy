import 'package:app/controllers/main_controller.dart';
import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import 'constraints.dart';
import 'widgets.dart';

class finalpage extends StatelessWidget {
  int count = 1;
  final MainController c = Get.put(MainController());
  final client = SupabaseClient(sbemail, sbauth);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: bgcolor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.to(HomeScreen()),
          ),
        ),
        body: Center(
          child: BText(t: 'Order Placed!', s: 42, c: Colors.white),
        ),
      ),
    );
  }
}
