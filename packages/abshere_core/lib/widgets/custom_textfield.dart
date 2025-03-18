
import 'package:abshere_core/data/res/strings/abshere_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.leadingIcon,
    this.controller,
    required this.placeholder,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
  });

  final String leadingIcon;
  final TextEditingController? controller;
  final String placeholder;
  final bool isPassword;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: AbshereAppColors.primaryColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            leadingIcon,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: AbshereAppColors.primaryColor,
              keyboardType: textInputType,
              textAlign: TextAlign.center,
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: AbshereAppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
