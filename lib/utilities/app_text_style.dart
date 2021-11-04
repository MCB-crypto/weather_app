import 'package:flutter/material.dart';

import 'app_colors.dart';


@immutable
class AppTextStyle {
  final navBar=TextStyle(color:AppColors().weatherAppGrey, fontSize: 24, fontWeight: FontWeight.w300,);
  final headline=TextStyle(color:AppColors().weatherAppGrey, fontSize: 42, fontWeight: FontWeight.w300,);
  final subMenu=TextStyle(color:AppColors().weatherAppGrey, fontSize: 20, fontWeight: FontWeight.w300,);
  AppTextStyle();

}