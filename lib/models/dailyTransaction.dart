import 'package:flutter/material.dart';

class DailyTransaction{

  int id;
  String title;
  double price;
  DateTime dateTime = DateTime.now();

  DailyTransaction({@required this.title, @required this.price, @required this.dateTime});

}
