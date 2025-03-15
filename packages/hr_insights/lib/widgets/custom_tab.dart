import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:
              isSelected ? HrInsightsColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(110.r),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.aBeeZee(
              color: isSelected
                  ? HrInsightsColors.textColor
                  : HrInsightsColors.inActiveText,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
