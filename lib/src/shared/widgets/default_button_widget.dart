import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const DefaultButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color(0xff1B202D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      clipBehavior: Clip.antiAlias,
      child: Text(
        label,
        style: TextStyle(
            fontSize: 17.h, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
