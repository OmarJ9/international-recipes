import 'package:flutter/material.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/constants/consts_variables.dart';
import 'package:international_recipes/src/widgets/mybutton.dart';
import 'package:sizer/sizer.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function() func;
  final Function(String) onchange;
  const MyTextField(
      {Key? key,
      required this.controller,
      required this.func,
      required this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 7.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(18))),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              onChanged: onchange,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Recipes",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 13.sp, color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54)),
            ),
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
        MyButton(
            iccolor: Colors.black,
            func: func,
            icon: Icons.filter_list,
            color: (isfiltered) ? Colors.blue : Colors.white)
      ],
    );
  }
}
