import 'package:flutter/material.dart';
import 'package:weather_app/utilities/helpers.dart';

class StatusBar extends StatelessWidget {
  final bool isConnected;
  const StatusBar({Key? key, required this.isConnected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: Helpers(context).getScreenWidth(),
      color: (() {
        if (isConnected) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      }()),
      child: (() {
        if (isConnected) {
          return const SizedBox(
            width: 200,
            child: Icon(Icons.cloud_queue),
          );
        } else {
          return const SizedBox(
            width: 200,
            child: Icon(Icons.cloud_off),
          );
        }
      }()),
    );
  }
}