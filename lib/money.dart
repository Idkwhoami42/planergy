import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app/constraints.dart';
import 'package:app/controllers/main_controller.dart';
import 'package:app/itempage.dart';
import 'package:app/itemspage.dart';
import 'package:app/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:supabase/supabase.dart';
import 'cartpage.dart';
import 'login.dart';
import 'userprofile.dart';
import 'widgets.dart';


class UserProfile extends StatelessWidget {
  final client = SupabaseClient(sbemail, sbauth);
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    f() async {
      print(c.userdata[0]['name']);
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.network(
              'https://avatars.dicebear.com/api/bottts/${c.userid}.svg'),
          Center(
            child: BText(
              t: c.userdata[0]['name'].toString(),
              s: 32,
              c: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}