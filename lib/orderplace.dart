import 'package:app/controllers/main_controller.dart';
import 'package:app/finalpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import 'constraints.dart';
import 'widgets.dart';

class OrderPlace extends StatelessWidget {
  int count = 1;
  final MainController c = Get.put(MainController());
  final client = SupabaseClient(sbemail, sbauth);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        elevation: 0,
        title: Center(
          child: BText(
              t: 'Confirm Order', s: 22, c: Colors.white, w: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BText(
                    t: 'Wallet Total:',
                    s: 20,
                    c: Colors.white,
                  ),
                  Obx(
                    () => BText(
                      t: '\$ ${c.totalmoney.value}',
                      s: 20,
                      c: Colors.white,
                      w: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BText(
                    t: 'Bag Total:',
                    s: 20,
                    c: Colors.white,
                  ),
                  Obx(
                    () => BText(
                      t: '\$ ${c.totalprice.value}',
                      s: 20,
                      c: Colors.white,
                      w: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BText(
                    t: 'Amount Left:',
                    s: 20,
                    c: Colors.white,
                  ),
                  BText(
                    t: '\$ ${c.totalmoney.value - c.totalprice.value}',
                    s: 20,
                    c: Colors.white,
                    w: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xff0041C4),
                child: TextButton(
                  onPressed: () async {
                    if (c.totalmoney.value < c.totalprice.value) {
                      c.invalidfunds.value = true;
                      c.update();
                    } else {
                      c.totalmoney.value -= c.totalprice.value;
                      c.totalprice.value = 0;
                      c.cartitems = {};
                      c.cartitemslist = [];
                      final cart = c.emptycart;
                      final res = await client.from('users').update({
                        'cart': cart,
                        'money': c.totalmoney.value
                      }).match({'userid': c.userid}).execute();
                      c.update();
                      Get.to(() => finalpage());
                    }
                  },
                  child: BText(
                    t: 'PLACE ORDER',
                    s: 32,
                    c: Colors.white,
                    w: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Obx(
                  () => Visibility(
                    visible: c.invalidfunds.value,
                    child: BText(
                      t: 'Insufficient Funds\nadd more in profile',
                      s: 22,
                      c: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
