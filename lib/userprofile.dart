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
import 'widgets.dart';

class UserProfile extends StatelessWidget {
  final client = SupabaseClient(sbemail, sbauth);
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.network(
                'https://avatars.dicebear.com/api/bottts/${c.userid}.svg'),
            Center(
              child: BText(
                t: c.userdata[0]['name'].toString(),
                s: 32,
                c: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BText(
                  t: 'Wallet Money:',
                  s: 18,
                  c: Colors.white,
                ),
                Obx(
                  () => BText(
                    t: '\$ ${c.totalmoney}',
                    s: 22,
                    c: Colors.white,
                    w: FontWeight.bold,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              color: Color(0xff0041C4),
              child: TextButton(
                onPressed: () async {
                  c.totalmoney.value += 10000000000;
                  final res = await client
                      .from('users')
                      .update({'money': c.totalmoney.value}).match(
                          {'userid': c.userid}).execute();
                },
                child: BText(
                  t: 'FREE MONEY',
                  s: 32,
                  c: Colors.white,
                  w: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
