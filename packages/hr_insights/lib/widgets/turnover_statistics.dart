import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_asset_strings.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/data/res/strings/hr_insights_strings.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/utils/extensions.dart';
import 'package:hr_insights/widgets/category_selection.dart';
import 'package:hr_insights/widgets/custom_card.dart';
import 'package:hr_insights/widgets/custom_switch.dart';
import 'package:hr_insights/widgets/custom_tooltip.dart';
import 'package:hr_insights/widgets/market_comparison_legend.dart';
import 'package:hr_insights/widgets/statistics_graph.dart';

class TurnoverStatisticsGraph extends StatefulWidget {
  const TurnoverStatisticsGraph({super.key});

  @override
  State<TurnoverStatisticsGraph> createState() =>
      _TurnoverStatisticsGraphState();
}

class _TurnoverStatisticsGraphState extends State<TurnoverStatisticsGraph> {
  late HrInsightsDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HrInsightsDashboardCubit>();
    _cubit.onStatisticsCategoryChanged(HrInsightsCategoryEnums.jobTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(16.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            HrInsightsAssetStrings.barChartSvg,
            height: 35.h,
            width: 35.w,
            color: HrInsightsColors.primaryColor,
          ),
          SizedBox(height: 4.h),
          Text(
            HrInsightsStrings.viewTurnoverStatics,
            style: GoogleFonts.aBeeZee(
              color: HrInsightsColors.textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          CategorySelection(cubit: _cubit),
          SizedBox(height: 16.h),
          CustomCard(
            child: Column(
              children: [
                BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
                    buildWhen: (previous, current) =>
                        current is HrInsightsCompareWithMarketChanged,
                    builder: (context, state) {
                      bool value = false;
                      bool isDisabled = _cubit.selectedCategory !=
                          HrInsightsCategoryEnums.jobTitle;
                      if (state is HrInsightsCompareWithMarketChanged) {
                        value = state.compareWithMarket;
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (isDisabled) ...[
                            CustomTooltip(
                                tooltipChildren: [
                                  Text(
                                    HrInsightsStrings.comingSoon,
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1.7),
                                  ),
                                  Text(
                                    HrInsightsStrings.compareYourEstablishment
                                        .toInterpolate(
                                            _cubit.selectedCategory.label),
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
                                child: SvgPicture.asset(
                                    HrInsightsAssetStrings.lockSvg)),
                            SizedBox(width: 4.w)
                          ],
                          CustomSwitch(
                            onChanged: _cubit.onCompareWithMarketChanged,
                            value: value,
                            isDisabled: isDisabled,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            HrInsightsStrings.compareWithMarket,
                            style: GoogleFonts.aBeeZee(
                              color: isDisabled
                                  ? HrInsightsColors.inActiveText
                                  : HrInsightsColors.tooltipBackground,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      );
                    }),
                SizedBox(height: 8.h),
                MarketComparisonLegend(),
                SizedBox(height: 8.h),
                BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
                  buildWhen: (previous, current) =>
                      current is HrInsightsEstablishmentGraphLoaded ||
                      current is CompareDataLoaded,
                  builder: (context, state) {
                    List<CommonGraphModel> estList = [];
                    List<CommonGraphModel> marketList = [];

                    if (state is HrInsightsEstablishmentGraphLoaded) {
                      estList = state.itemsList;
                    }

                    if (state is CompareDataLoaded) {
                      estList = state.estList;
                      marketList = state.marketList;
                    }

                    return StatisticsGraph(
                      establishmentList: estList,
                      marketList: marketList,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
