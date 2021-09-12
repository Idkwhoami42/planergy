import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app/constraints.dart';
import 'package:app/controllers/main_controller.dart';
import 'package:app/itempage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:supabase/supabase.dart';
import 'login.dart';
import 'orderplace.dart';
import 'widgets.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final client = SupabaseClient(sbemail, sbauth);
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return c.cartitemslist.length == 0
        ? Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/emptycart.png',
                  color: Colors.white,
                  scale: 1.5,
                ),
                BText(
                  t: 'Cart Empty',
                  s: 32,
                  c: Colors.white,
                )
              ],
            ),
          )
        : SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
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
                                  s: 24,
                                  c: Colors.white,
                                  w: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff0041C4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => OrderPlace());
                                },
                                child: BText(
                                  t: 'Checkout',
                                  s: 28,
                                  c: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: c.cartitemslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      ITEM? currentitem =
                          c.getitembyname(c.cartitemslist[index].toString());
                      int count = int.parse(
                          c.userdata[0]['cart'][currentitem!.name].toString());
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width,
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Color(0xffC4C4C4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(currentitem.imagelink),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          BText(
                                              t: currentitem.name,
                                              s: 15,
                                              c: Colors.white),
                                          IconButton(
                                            onPressed: () async {
                                              c.cartitemslist
                                                  .remove(currentitem.name);
                                              c.cartitems
                                                  .remove(currentitem.name);
                                              c.totalprice.value -= int.parse(c
                                                      .userdata[0]['cart']
                                                          [currentitem.name]
                                                      .toString()) *
                                                  currentitem.cost;
                                              c.userdata[0]['cart']
                                                  [currentitem.name] = '0';
                                              final cart =
                                                  c.userdata[0]['cart'];
                                              final res = await client
                                                  .from('users')
                                                  .update(
                                                      {'cart': cart}).match({
                                                'userid': c.userid
                                              }).execute();
                                              c.update();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          BText(
                                            t: "\$ ${currentitem.cost}",
                                            s: 15,
                                            c: Color(0xff0041C4),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              if (count >= 1) {
                                                final x = count - 1;
                                                c.totalprice.value -=
                                                    currentitem.cost;
                                                c.userdata[0]['cart']
                                                    [currentitem.name] = '$x';
                                                final cart =
                                                    c.userdata[0]['cart'];
                                                final res = await client
                                                    .from('users')
                                                    .update(
                                                        {'cart': cart}).match({
                                                  'userid': c.userid
                                                }).execute();
                                                c.update();
                                                setState(() {});
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          BText(
                                              t: '$count',
                                              s: 15,
                                              c: Colors.white),
                                          IconButton(
                                            onPressed: () async {
                                              final x = count + 1;
                                              c.totalprice.value +=
                                                  currentitem.cost;
                                              c.userdata[0]['cart']
                                                  [currentitem.name] = '$x';
                                              final cart =
                                                  c.userdata[0]['cart'];
                                              final res = await client
                                                  .from('users')
                                                  .update(
                                                      {'cart': cart}).match({
                                                'userid': c.userid
                                              }).execute();
                                              c.update();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.add_circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
