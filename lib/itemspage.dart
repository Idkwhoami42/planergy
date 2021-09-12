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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:supabase/supabase.dart';
import 'login.dart';
import 'userprofile.dart';
import 'widgets.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final MainController c = Get.put(MainController());
  bool initfinish = false;
  f() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      initfinish = true;
    });
  }

  @override
  void initState() {
    super.initState();
    f();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/logo.svg',
                color: Colors.white,
                height: 65,
              ),
            ),
            Center(child: BText(t: 'PLANERGY\n', s: 22, c: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 5; i++)
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (i != c.currenttypeindex.value) {
                            c.typevisible[c.currenttypeindex.value].value =
                                false;
                            c.typevisible[i].value = true;
                            c.currenttypeindex.value = i;
                            c.update();
                          }
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/${c.typeimages[i]}',
                              color: Colors.white,
                            ),
                            BText(
                                t: '${c.typenames[i]}\n',
                                s: 12,
                                c: Colors.white),
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: c.typevisible[i].value,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xff0041C4),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
            Expanded(
              child: !initfinish
                  ? const SpinKitFoldingCube(
                      color: Colors.white,
                    )
                  : Obx(
                      () => Container(
                        child: GridView.builder(
                          itemCount: c.items[c.currenttypeindex.value].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.8),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ItemPage(
                                      item: c.items[c.currenttypeindex.value]
                                          [index]));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4b4b4b),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(
                                        c.items[c.currenttypeindex.value][index]
                                            .imagelink,
                                        height: 100,
                                      ),
                                      BText(
                                        t: c
                                            .items[c.currenttypeindex.value]
                                                [index]
                                            .name,
                                        s: 18,
                                        c: Colors.white,
                                        a: TextAlign.center,
                                      ),
                                      BText(
                                        t: '\$ ${c.items[c.currenttypeindex.value][index].cost}',
                                        s: 20,
                                        c: const Color(0xff002251),
                                        w: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
