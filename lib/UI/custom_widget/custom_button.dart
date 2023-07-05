import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.titleWidget,
      this.width = double.infinity,
      this.onPressed});
  Widget? titleWidget;
  Widget? buttonWidget;
  double? width;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 52.h,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: const Color(0xffD9D9D9),
          ),
          child: Center(child: titleWidget)),
    );
  }
}
