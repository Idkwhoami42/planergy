import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const Color bgcolor = Color(0xff181818);
const Color pcolor = Color(0xff163172);
String sbemail = dotenv.env['SBEMAIL'].toString();
String sbauth = dotenv.env['SBAUTH'].toString();

class ITEM {
  ITEM(this.name, this.cost, this.imagelink, this.type);
  String name;
  int cost;
  String imagelink;
  String type;
}
