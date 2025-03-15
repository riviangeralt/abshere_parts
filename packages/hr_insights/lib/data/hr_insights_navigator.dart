import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_insights/data/res/strings/hr_insights_navigator_strings.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_screen.dart';
import 'package:hr_insights/ui/hr_insights_est/hr_insights_est_screen.dart';
import 'package:hr_insights/ui/hr_insights_hooks/hr_insights_hooks_cubit.dart';
import 'package:hr_insights/ui/hr_insights_hooks/hr_insights_hooks_screen.dart';

class HrInsightsNavigator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HrInsightsNavigatorStrings.hrInsightsEstIdRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: HrInsightsNavigatorStrings.hrInsightsEstIdRoute,
          ),
          builder: (context) {
            return const HrInsightsEstScreen();
          },
        );
      case HrInsightsNavigatorStrings.hrInsightsHooksRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: HrInsightsNavigatorStrings.hrInsightsHooksRoute,
          ),
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HrInsightsHooksCubit())
              ],
              child: const HrInsightsHooksScreen(),
            );
          },
        );
      case HrInsightsNavigatorStrings.hrInsightsDashboardRoute:
        final args = settings.arguments as HrInsightsDashboardArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: HrInsightsNavigatorStrings.hrInsightsDashboardRoute,
          ),
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HrInsightsDashboardCubit())
              ],
              child: HrInsightsDashboardScreen(dashboardArgs: args),
            );
          },
        );
    }
    return null;
  }
}
