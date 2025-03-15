import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDisabled;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isDisabled) {
          widget.onChanged(!widget.value);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 24.h,
        width: 42.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: widget.isDisabled
              ? HrInsightsColors.borderColor
              : widget.value
                  ? HrInsightsColors.primaryColor
                  : HrInsightsColors.borderColorDark,
        ),
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.all(2.h),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: 20.h,
            width: 20.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2.r,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.2),
                ),
                BoxShadow(
                  offset: Offset(0, 0.1),
                  blurRadius: 0.3.r,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
