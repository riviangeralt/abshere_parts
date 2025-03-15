import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({
    super.key,
    required this.toggleSelection,
    this.isSelected = false,
  });

  final void Function(bool value) toggleSelection;
  final bool isSelected;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  bool isSelected = false;

  void toggleSelection() {
    // setState(() {
    //   isSelected = !isSelected;
    // });
    widget.toggleSelection(widget.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.h,
      width: 17.w,
      padding: EdgeInsets.all(widget.isSelected ? 3.h : 0),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: widget.isSelected
              ? HrInsightsColors.textColor
              : HrInsightsColors.inActiveText,
          width: 1,
        ),
      ),
      child: Container(
        height: 10.h,
        width: 10.w,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Colors.white
              : HrInsightsColors.inactiveRadioColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}
