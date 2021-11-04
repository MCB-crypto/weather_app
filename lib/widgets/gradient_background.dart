import 'package:flutter/material.dart';
import 'package:weather_app/utilities/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const AppColors().gradient1,
              const AppColors().gradient2,
              const AppColors().gradient3,
              const AppColors().gradient4,
            ],
          )
      ),
    );
  }
}
