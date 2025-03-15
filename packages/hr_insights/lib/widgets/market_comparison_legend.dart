import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';

class MarketComparisonLegend extends StatelessWidget {
  const MarketComparisonLegend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
      buildWhen: (previous, current) =>
          current is HrInsightsCompareWithMarketChanged,
      builder: (context, state) {
        if (state is HrInsightsCompareWithMarketChanged) {
          return state.compareWithMarket
              ? Row(
                  children: HrInsightMarketEstEnum.values
                      .map((e) => Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 14.h,
                                decoration: BoxDecoration(
                                  color: e.color,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                e.label,
                                style: GoogleFonts.aBeeZee(
                                  color: HrInsightsColors.textGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ))
                      .toList()
                      .expand((widget) => [widget, SizedBox(width: 32.w)])
                      .toList()
                    ..removeLast(),
                )
              : SizedBox.shrink();
        }

        return SizedBox.shrink();
      },
    );
  }
}
