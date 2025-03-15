import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/widgets/custom_card.dart';
import 'package:hr_insights/widgets/custom_tab.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  late HrInsightsDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HrInsightsDashboardCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: CustomCard(
        radius: 110,
        child: BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
            bloc: _cubit,
            buildWhen: (previous, current) => current is HrInsightsTabChanged,
            builder: (context, state) {
              HrInsightsTabsEnums selectedIndex = HrInsightsTabsEnums.turnover;
              if (state is HrInsightsTabChanged) {
                selectedIndex = state.tabIndex;
              }

              return Row(
                children: HrInsightsTabsEnums.values.expand((element) {
                  final index = HrInsightsTabsEnums.values.indexOf(element);

                  return [
                    Expanded(
                      child: CustomTab(
                        label: element.value,
                        isSelected: element == selectedIndex,
                        onTap: () => _cubit.onTabChanged(element),
                      ),
                    ),
                    if (index != HrInsightsTabsEnums.values.length - 1)
                      SizedBox(width: 8.w),
                  ];
                }).toList(),
              );
            }),
      ),
    );
  }
}
