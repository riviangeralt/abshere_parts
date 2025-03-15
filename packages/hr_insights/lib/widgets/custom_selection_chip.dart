import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_asset_strings.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_strings.dart';
import 'package:hr_insights/widgets/custom_radio.dart';
import 'package:hr_insights/widgets/custom_tooltip.dart';

class CustomSelectionChip extends StatelessWidget {
  const CustomSelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });

  final String label;
  final bool isSelected;
  final Function() onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      tooltipChildren: !isDisabled
          ? null
          : [
              Text(
                HrInsightsStrings.comingSoon,
                style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.7),
              ),
              Text(
                HrInsightsStrings.diveDeeperText,
                style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.7),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    HrInsightsStrings.registerForUpcoming,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.85,
                      color: HrInsightsColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward,
                    color: HrInsightsColors.primaryColor,
                    size: 18.h,
                  )
                ],
              ),
            ],
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            color: isDisabled
                ? Colors.transparent
                : isSelected
                    ? HrInsightsColors.primaryColor
                    : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: isDisabled
                ? Border.all(color: HrInsightsColors.disableBorderColor)
                : isSelected
                    ? null
                    : Border.all(
                        color: HrInsightsColors.inActiveText,
                        width: 1.5,
                      ),
          ),
          child: Row(
            children: [
              CustomRadio(
                isSelected: isSelected,
                toggleSelection: (value) {},
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.aBeeZee(
                  color: isSelected
                      ? HrInsightsColors.textColor
                      : HrInsightsColors.inActiveText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isDisabled) ...[
                SizedBox(width: 8.w),
                SvgPicture.asset(HrInsightsAssetStrings.lockSvg)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
