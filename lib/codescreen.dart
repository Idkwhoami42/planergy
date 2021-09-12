import 'package:app/constraints.dart';
import 'package:app/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main.dart';
import 'widgets.dart';


class codepage extends StatelessWidget {
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Center(
              child:
                  BText(t: 'Create Code', s: 43, w: FontWeight.bold, c: pcolor),
            )),
            Expanded(
              child: BText(
                  t: 'To quickly enter the application and\nconfirm shipment',
                  s: 15,
                  w: FontWeight.w400,
                  c: const Color(0xff1E56A0),
                  a: TextAlign.center),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 6; i++)
                    Obx(
                      () => Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: c.codedots[i].value ? pcolor : Colors.white,
                          border: Border.all(color: pcolor, width: 2),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Center(
                  child: GridView.builder(
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index < 9 || index == 10) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  if (c.currentdotindex.value < 6) {
                                    c.codedots[c.currentdotindex.value].value =
                                        true;
                                    c.currentdotindex.value++;
                                    c.code.value +=
                                        index < 9 ? '${index + 1}' : '0';
                                    // print(c.code.value);
                                    c.update();

                                    if (c.currentdotindex.value == 6) {
                                      Get.to(() => HomeScreen());
                                    }
                                  }
                                },
                                child: BText(
                                  t: index < 9 ? '${index + 1}' : '0',
                                  s: 32,
                                  c: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (index == 9) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  if (c.currentdotindex.value > 0) {
                                    c.currentdotindex.value--;
                                    c.codedots[c.currentdotindex.value].value =
                                        false;
                                    c.code.value = c.code.value
                                        .substring(0, c.code.value.length - 1);
                                    // print(c.code.value);
                                    c.update();
                                  }
                                },
                                icon: const Icon(
                                  Icons.backspace,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}