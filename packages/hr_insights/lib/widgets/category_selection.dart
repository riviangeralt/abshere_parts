import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/widgets/custom_selection_chip.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({
    super.key,
    required HrInsightsDashboardCubit cubit,
    this.isSalaryGrowth = false
  }) : _cubit = cubit;

  final HrInsightsDashboardCubit _cubit;
  final bool isSalaryGrowth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
          buildWhen: (previous, current) =>
              current is HrInsightsStatisticsCategoryChanged,
          builder: (context, state) {
            HrInsightsCategoryEnums selectedCategory =
                HrInsightsCategoryEnums.jobTitle;
            if (state is HrInsightsStatisticsCategoryChanged) {
              selectedCategory = state.category;
            }
            return Row(
              children: HrInsightsCategoryEnums.values.expand((e) {
                return [
                  CustomSelectionChip(
                    label: e.label,
                    isSelected: e == selectedCategory,
                    onTap: () => isSalaryGrowth? _cubit.onSgStatisticsCategoryChanged(e): _cubit.onStatisticsCategoryChanged(e),
                    isDisabled: e == HrInsightsCategoryEnums.workExp,
                  ),
                  SizedBox(width: 8.w),
                ];
              }).toList()
                ..removeLast(),
            );
          }),
    );
  }
}
