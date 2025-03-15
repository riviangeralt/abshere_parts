import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/model/hooks_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/data/res/strings/hr_insights_navigator_strings.dart';
import 'package:hr_insights/data/res/strings/hr_insights_strings.dart';
import 'package:hr_insights/hr_insights.dart';
import 'package:hr_insights/ui/hr_insights_hooks/hr_insights_hooks_cubit.dart';
import 'package:hr_insights/ui/hr_insights_hooks/hr_insights_hooks_state.dart';

class HrInsightsHooksScreen extends StatefulWidget {
  const HrInsightsHooksScreen({super.key});

  @override
  State<HrInsightsHooksScreen> createState() => _HrInsightsHooksScreenState();
}

class _HrInsightsHooksScreenState extends State<HrInsightsHooksScreen> {
  late HrInsightsHooksCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HrInsightsHooksCubit>();
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    _cubit.fetchEstablishmentHooks(estId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: HrInsightsColors.textColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: BlocBuilder<HrInsightsHooksCubit, HrInsightsHooksState>(
                buildWhen: (previous, current) =>
                    current is HrInsightsHooksLoaded ||
                    current is HrInsightsHooksCategoryChanged ||
                    current is HrInsightsHookChange,
                builder: (context, state) {
                  List<Insight> hooksToDisplay = [];
                  HooksCategory hooksCategory;
                  String hookMessage = '';
                  HrInsightsTabsEnums type = HrInsightsTabsEnums.salaryGrowth;

                  if (state is HrInsightsHooksLoaded) {
                    hooksCategory =
                        _cubit.getCurrentCategoryHooks(_cubit.selectedCategory);
                    hooksToDisplay = [
                      ...hooksCategory.salary.insights,
                      ...hooksCategory.turnover.insights
                    ];
                  }

                  if (state is HrInsightsHooksCategoryChanged) {
                    hooksCategory =
                        _cubit.getCurrentCategoryHooks(state.category);
                    hooksToDisplay = [
                      ...hooksCategory.salary.insights,
                      ...hooksCategory.turnover.insights
                    ];
                  }

                  if (state is HrInsightsHookChange) {
                    hookMessage = state.hookMessage;
                    type = state.type;
                    hooksCategory =
                        _cubit.getCurrentCategoryHooks(_cubit.selectedCategory);
                    hooksToDisplay = [
                      ...hooksCategory.salary.insights,
                      ...hooksCategory.turnover.insights
                    ];
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHooksCount(hooksToDisplay, _cubit.index),
                      SizedBox(height: 16.h),
                      Text(
                        hookMessage,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            HrInsightsNavigatorStrings.hrInsightsDashboardRoute,
                            arguments: HrInsightsDashboardArguments(
                              selectedTab: type,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              HrInsightsStrings.moreText,
                              style: GoogleFonts.aBeeZee(
                                color: HrInsightsColors.primaryColor,
                                fontSize: 16.sp,
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
                      ),
                      SizedBox(height: 16.h),
                      _buildHooksCategory()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHooksCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<HrInsightsHooksCubit, HrInsightsHooksState>(
          buildWhen: (previous, current) =>
              current is HrInsightsHooksCategoryChanged,
          builder: (context, state) {
            HrInsightsCategoryEnums selectedCat = _cubit.selectedCategory;

            if (state is HrInsightsHooksCategoryChanged) {
              selectedCat = state.category;
            }

            return Row(
              children: HrInsightsCategoryEnums.values
                  .where((ele) => ele != HrInsightsCategoryEnums.workExp)
                  .toList()
                  .asMap()
                  .entries
                  .map(
                (entry) {
                  final value = entry.value;
                  return GestureDetector(
                    onTap: () => selectedCat == value
                        ? null
                        : _cubit.onChangeCategory(value),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                        color: selectedCat == value
                            ? HrInsightsColors.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        value.label,
                        style: GoogleFonts.aBeeZee(
                            color: HrInsightsColors.textColor),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }),
    );
  }

  Widget _buildHooksCount(List<Insight> hooksToDisplay, int current) {
    return Row(
      children: List.generate(
        hooksToDisplay.length,
        (int index) {
          return Container(
            width: index == current ? 30.w : 10.w,
            height: 10.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: index == current
                  ? HrInsightsColors.primaryColor
                  : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
