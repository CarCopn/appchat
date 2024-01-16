import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String label;

  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType inputType;
  const CustomTextFormFieldWidget(
      {Key? key,
      required this.label,
      required this.controller,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.suffix})
      : super(key: key);

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        hintText: widget.label,
        suffixIcon: Container(
            width: 40,
            alignment: Alignment.topCenter,
            child: Center(child: widget.suffix)),
        hintStyle: TextStyle(
            fontSize: 16.h, color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(width: 1.0),
        ),
      ),
    );
  }
}
