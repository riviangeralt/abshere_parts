import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: HrInsightsColors.textColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.h),
        child: Text(
          label,
          style: GoogleFonts.aBeeZee(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
