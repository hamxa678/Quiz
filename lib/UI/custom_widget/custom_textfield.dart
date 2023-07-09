import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.obscureText = false,
      this.controller,
      required this.hintText,
      this.prefexIcon,
      // this.suffexIcon,
      this.onTap,
      this.onChange,
      this.enable = true,
      this.width = double.infinity,
      // this.hintStyle,
      this.onSaved,
      this.validator,
      this.readOnly = false,
      this.keyboardtype,
      this.suffixIcon,
      this.counterText,
      this.maxLength})
      : super(key: key);
  final bool obscureText;
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefexIcon;
  // final Widget? suffexIcon;
  final VoidCallback? onTap;
  void Function(String)? onChange;
  TextInputType? keyboardtype;
  final bool enable;
  final double? width;
  final int? maxLength;
  bool readOnly;
  Widget? suffixIcon;
  String? counterText;

  // final TextStyle? hintStyle;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        readOnly: readOnly,
        maxLength: maxLength,
        keyboardType: keyboardtype,
        validator: validator,
        onSaved: onSaved,
        enabled: enable,
        onTap: onTap,
        onChanged: onChange,
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontSize: 15.sp,
          color: const Color(0xffD9D9D9),
        ),
        decoration: InputDecoration(
          counterText: counterText,
          suffixIcon: suffixIcon,
          prefixIcon: prefexIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
          hintText: hintText,
          // errorStyle: TextStyle(
          //   fontFamily: 'Poppins',
          //   fontWeight: FontWeight.w400,
          //   fontSize: 8.sp,
          //   color: const Color(0xffFF0000),
          // ),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            color: const Color(0xffD9D9D9),
          ),
          // suffixIcon: suffexIcon,
        ),
      ),
    );
  }
}
