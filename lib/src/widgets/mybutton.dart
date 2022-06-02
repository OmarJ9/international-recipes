import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/consts_variables.dart';

class MyButton extends StatelessWidget {
  final Function() func;
  final IconData icon;
  final Color color;
  final Color iccolor;
  const MyButton(
      {Key? key,
      required this.func,
      required this.icon,
      required this.color,
      required this.iccolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              color: color),
          child: Icon(
            icon,
            color: iccolor,
          ),
        ),
      ),
    );
  }
}
