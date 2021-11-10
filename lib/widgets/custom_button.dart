import 'package:flutter/material.dart';
import 'package:weather_app/utilities/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Icon icon;
  const CustomButton({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(text,style: const AppTextStyle().button,)),

         Align(
            alignment: Alignment.centerRight,
            child: icon),

      ],
    );
  }
}
