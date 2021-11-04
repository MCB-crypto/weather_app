import 'package:flutter/material.dart';
import 'package:weather_app/utilities/app_colors.dart';
import 'package:weather_app/utilities/helpers.dart';
import 'package:weather_app/widgets/gradient_background.dart';
import 'package:weather_app/widgets/scrollable_list.dart';

class WeatherNow extends StatelessWidget {
  const WeatherNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Helpers(context).getScreenHeight();
    // double width = Helpers(context).getScreenWidth();
    return Stack(
      fit: StackFit.expand,
      children: const [
        GradientBackground(),
        ScrollableList(),
      ],
    );
  }
}

// Positioned(
//   bottom: 0,
//   child: Container(
//     height: height / 2,
//     width: width,
//     decoration: BoxDecoration(
//       color: const AppColors().backgroundGrey,
//       borderRadius: const BorderRadius.only(
//           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
//     ),
//   ),
// )
