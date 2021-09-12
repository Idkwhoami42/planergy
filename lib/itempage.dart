import 'package:app/controllers/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import 'constraints.dart';
import 'widgets.dart';

class ItemPage extends StatefulWidget {
  ItemPage({Key? key, required this.item}) : super(key: key);

  final ITEM item;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int count = 1;
  final MainController c = Get.put(MainController());
  final client = SupabaseClient(sbemail, sbauth);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: const Color(0xff525252),
        elevation: 0,
        title: Center(
          child: BText(
              t: widget.item.name, s: 22, c: Colors.white, w: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: Color(0xff525252),
                  child: Image.network(
                    widget.item.imagelink,
                    scale: 0.2,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      BText(
                        t: '\$ ${widget.item.cost}',
                        s: 48,
                        c: const Color(0xff0041C4),
                      ),
                      BText(
                        t: '${widget.item.name}',
                        a: TextAlign.center,
                        s: 32,
                        c: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(52),
                      topRight: Radius.circular(52),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff163172),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                if (count >= 2) {
                                  setState(() {
                                    count--;
                                  });
                                }
                              },
                              child: BText(
                                  t: '-',
                                  s: 22,
                                  c: Color(0xff002251),
                                  w: FontWeight.bold),
                            ),
                            BText(
                                t: '$count',
                                s: 22,
                                c: Color(0xff002251),
                                w: FontWeight.bold),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  count += 1;
                                });
                              },
                              child: BText(
                                  t: '+',
                                  s: 22,
                                  c: Color(0xff002251),
                                  w: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Color(0xff163172),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final x = count +
                                int.parse(c.userdata[0]['cart']
                                        [widget.item.name]
                                    .toString());
                            c.userdata[0]['cart'][widget.item.name] = '$x';
                            c.cartitems.add(widget.item.name);
                            c.cartitemslist = c.cartitems.toList();

                            final cart = c.userdata[0]['cart'];
                            c.totalprice += int.parse(c.userdata[0]['cart']
                                        [widget.item.name]
                                    .toString()) *
                                c
                                    .getitembyname(widget.item.name.toString())!
                                    .cost;

                            final res = await client
                                .from('users')
                                .update({'cart': cart}).match(
                                    {'userid': c.userid}).execute();
                            // print(res.data);
                          },
                          child: BText(
                            t: 'Add to Cart',
                            s: 16,
                            c: Colors.white,
                            w: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
