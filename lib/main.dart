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

void main() async {
  // await  'https://vjifpzagjgmrzpovpyxo.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMTA0MDc0OSwiZXhwIjoxOTQ2NjE2NzQ5fQ.WfeCTxGi1rAndXVGSeYxwgB9joL7cO0BQ16-i8OnWI0');
  await dotenv.load(fileName: ".env");
  MainController c = Get.put(MainController());
  c.inititems();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 22,
            color: const Color(0xff7A869A),
            fontFamily: GoogleFonts.spaceMono().fontFamily,
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: GoogleFonts.spaceMono().fontFamily,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool initfinish = false;
  f() async {
    await Future.delayed(const Duration(seconds: 6));
    Get.to(() => Loginpage());
  }

  @override
  void initState() {
    super.initState();
    // f();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.1),
                    w: FontWeight.bold,
                  ),
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.1),
                    w: FontWeight.bold,
                  ),
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.5),
                    w: FontWeight.bold,
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/logo.svg',
                    color: Color(0xff2f2f2f),
                    height: 250,
                  ),
                  Spacer(),
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.5),
                    w: FontWeight.bold,
                  ),
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.1),
                    w: FontWeight.bold,
                  ),
                  BText(
                    t: 'PLANERGY',
                    s: 50,
                    c: Color(0xff0041C4).withOpacity(0.1),
                    w: FontWeight.bold,
                  ),
                ],
              ),
              Column(
                children: [
                  const Spacer(flex: 4),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => Loginpage());
                      },
                      child: BText(
                        t: 'sign in',
                        s: 22,
                        c: const Color(0xff163172),
                        f: GoogleFonts.montserrat().fontFamily,
                        w: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: bgcolor,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff3e3e3e), spreadRadius: 4)
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => SignupPage());
                      },
                      child: BText(
                        t: 'create account',
                        s: 22,
                        c: Colors.white,
                        f: GoogleFonts.montserrat().fontFamily,
                        w: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController c = Get.put(MainController());

  int _bottomNavIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.shopping_cart,
    Icons.account_circle,
    Icons.logout,
  ];

  final appbarlist = [
    null,
    AppBar(
      backgroundColor: bgcolor,
      title: Center(child: BText(t: 'Shopping Bag', s: 28, c: Colors.white)),
      automaticallyImplyLeading: false,
    ),
    AppBar(
      backgroundColor: bgcolor,
      title: Center(child: BText(t: 'User Profile', s: 28, c: Colors.white)),
      automaticallyImplyLeading: false,
    ),
  ];

  final bodylist = <Widget>[
    ItemsPage(),
    CartPage(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    // c.inititems();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: bgcolor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            focusColor: bgcolor,
            hoverColor: bgcolor,
            elevation: 1,
            child: Icon(
              iconList[_bottomNavIndex],
              color: bgcolor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: iconList,
              activeIndex: _bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.defaultEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) {
                if (index == 3) {
                  Get.to(() => HomePage());
                } else
                  setState(() => _bottomNavIndex = index);
              }
              //other params
              ),
          appBar: appbarlist[_bottomNavIndex],
          body: bodylist[_bottomNavIndex]),
    );
  }
}
