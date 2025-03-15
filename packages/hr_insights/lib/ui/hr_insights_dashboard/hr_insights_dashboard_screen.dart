import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/data/res/strings/hr_insights_navigator_strings.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/utils/shared_prefs.dart';
import 'package:hr_insights/widgets/custom_appbar.dart';
import 'package:hr_insights/widgets/custom_menu.dart';
import 'package:hr_insights/widgets/custom_tabbar.dart';
import 'package:hr_insights/widgets/salary_growth_screen.dart';
import 'package:hr_insights/widgets/turnover_screen.dart';

class HrInsightsDashboardScreen extends StatefulWidget {
  const HrInsightsDashboardScreen({super.key, required this.dashboardArgs});

  final HrInsightsDashboardArguments dashboardArgs;

  @override
  State<HrInsightsDashboardScreen> createState() =>
      _HrInsightsDashboardScreenState();
}

class _HrInsightsDashboardScreenState extends State<HrInsightsDashboardScreen> {
  late HrInsightsDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HrInsightsDashboardCubit>();
    _cubit.onTabChanged(
      widget.dashboardArgs.selectedTab ?? HrInsightsTabsEnums.turnover,
    );
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    _cubit.fetchEstablishmentDetails(estId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HrInsightsColors.backgroundColor,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
                buildWhen: (previous, current) =>
                    current is HrInsightsEstablishmentDetailsLoaded,
                builder: (context, state) {
                  if (state is HrInsightsEstablishmentDetailsLoaded) {
                    return Text(
                      state.estName,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16.sp,
                        color: HrInsightsColors.textColor,
                      ),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 16.h),
              CustomTabbar(),
              SizedBox(height: 24.h),
              BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
                  buildWhen: (previous, current) =>
                      current is HrInsightsYearChanged,
                  builder: (context, state) {
                    MenuOptions selected = MenuOptions.prevYear;
                    if (state is HrInsightsYearChanged) {
                      selected = state.option;
                    }
                    return CustomMenu(
                      value: selected.label,
                      options: MenuOptions.values,
                      onChange: (option) {
                        _cubit.onYearChange(option);
                      },
                    );
                  }),
              SizedBox(height: 24.h),
              BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
                buildWhen: (previous, current) =>
                    current is HrInsightsTabChanged ||
                    current is HrInsightsYearChanged,
                builder: (context, state) {
                  HrInsightsTabsEnums tab = _cubit.selectedTab;
                  if (state is HrInsightsTabChanged) {
                    tab = state.tabIndex;
                  }

                  final screensMap = {
                    HrInsightsTabsEnums.turnover: TurnoverScreen(),
                    HrInsightsTabsEnums.salaryGrowth: SalaryGrowthScreen(),
                  };

                  return screensMap[tab]!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
