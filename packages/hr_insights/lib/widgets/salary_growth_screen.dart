import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/utils/shared_prefs.dart';
import 'package:hr_insights/widgets/salary_growth_statistics.dart';
import 'package:hr_insights/widgets/stats_card_list.dart';

class SalaryGrowthScreen extends StatefulWidget {
  const SalaryGrowthScreen({super.key});

  @override
  State<SalaryGrowthScreen> createState() => _SalaryGrowthScreenState();
}

class _SalaryGrowthScreenState extends State<SalaryGrowthScreen> {
  late HrInsightsDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HrInsightsDashboardCubit>();
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    _cubit.fetchEmployeeSalaryDetails(estId, _cubit.selectedYear.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SalaryGrowthStatisticsGraph(),
        SizedBox(height: 24.h),
        BlocBuilder(
          bloc: _cubit,
          buildWhen: (previous, current) =>
              current is HrInsightsTurnoverStatsLoaded,
          builder: (context, state) {
            if (state is HrInsightsTurnoverStatsLoaded) {
              return StatsCardList(
                  list: state.statsList, message: state.message);
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
