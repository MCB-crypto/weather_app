import 'package:flutter/material.dart';



@immutable
class AppTextStyle {
  final city=const TextStyle(color:Colors.black, fontSize: 30, fontWeight: FontWeight.w400,);
  final headline=const TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.w300,);
  final button=const TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.w400,);
  const AppTextStyle();
}