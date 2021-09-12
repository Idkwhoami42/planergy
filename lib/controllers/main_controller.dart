import 'package:app/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'dart:io';
import 'package:app/constraints.dart';

class MainController extends GetxController {
  final List<RxBool> codedots = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];
  final RxInt currentdotindex = 0.obs;
  final RxString code = ''.obs,
      email = ''.obs,
      password = ''.obs,
      username = ''.obs;
  late String userid;
  late var userdata;

  RxBool emailexists = false.obs;

  late User? user;
  final RxBool initfinish = false.obs;

  List<List<ITEM>> items = [[], [], [], [], []];

  List<String> typeimages = [
    'Apps.png',
    'Sniper Rifle.png',
    'Clothes.png',
    'ATV.png',
    'Smartphone Tablet.png'
  ];
  List<String> typenames = ['All', 'Weapons', 'Suits', 'Vehicals', 'Utility'];

  List<RxBool> typevisible = [
    true.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];
  RxInt currenttypeindex = 0.obs;
  RxInt totalprice = 0.obs, totalmoney = 0.obs;
  RxBool invalidfunds = false.obs;
  Set<String> cartitems = {};
  late List<String> cartitemslist;

  void inititems() async {
    final client = SupabaseClient(sbemail, sbauth);
    final response = await client.from('items').select().execute();
    final totalitems = response.data.length;

    for (var i in response.data) {
      items[0].add(ITEM(i['name'].toString(), int.parse(i['cost'].toString()),
          i['imagelink'].toString(), i['type'].toString()));

      if (i['type'].toString() == 'Weapons')
        items[1].add(ITEM(i['name'].toString(), int.parse(i['cost'].toString()),
            i['imagelink'].toString(), i['type'].toString()));
      if (i['type'].toString() == 'Suits')
        items[2].add(ITEM(i['name'].toString(), int.parse(i['cost'].toString()),
            i['imagelink'].toString(), i['type'].toString()));
      if (i['type'].toString() == 'Vehicals')
        items[3].add(ITEM(i['name'].toString(), int.parse(i['cost'].toString()),
            i['imagelink'].toString(), i['type'].toString()));
      if (i['type'].toString() == 'Utility')
        items[4].add(ITEM(i['name'].toString(), int.parse(i['cost'].toString()),
            i['imagelink'].toString(), i['type'].toString()));

      // print("'${i['name'].toString()}' : 0");
      // print(i);
    }
    // print(items);
    // for (var i in items) {
    //   print(i.imagelink);
    // }
  }

  final emptycart = {
    "Space rover - III": "0",
    "Space rover - IV": "0",
    "Planetary weapon-I": "0",
    "Planetary weapon- III": "0",
    "Planetary weapon- IV": "0",
    "Anywhere door": "0",
    "Space suit pro - I": "0",
    "Planetary weapon-II": "0",
    "Space suit - I": "0",
    "Space suit - II": "0",
    "Space suit pro - II": "0",
    "Space rover - I": "0",
    "Space rover - II": "0",
    "Genie lamp": "0",
    "Space future": "0",
    "Earth cam ": "0"
  };

  ITEM? getitembyname(String name) {
    for (ITEM i in items[0]) {
      if (i.name == name) return i;
    }
  }
}
