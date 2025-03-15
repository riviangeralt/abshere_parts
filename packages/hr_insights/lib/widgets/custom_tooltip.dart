import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    super.key,
    required this.child,
    required this.tooltipChildren,
  });

  final Widget child;
  final List<Widget>? tooltipChildren;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: EdgeInsets.only(top: 5.h),
      triggerMode: TooltipTriggerMode.tap,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: HrInsightsColors.tooltipBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      showDuration: Duration(seconds: 5),
      richMessage: tooltipChildren != null && tooltipChildren!.isNotEmpty
          ? _buildTooltipContent(context)
          : TextSpan(),
      child: child,
    );
  }

  InlineSpan _buildTooltipContent(BuildContext context) {
    return TextSpan(
      children: [
        WidgetSpan(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tooltipChildren!,
          ),
        ),
      ],
    );
  }
}
