import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';

class HrInsightsNavigatorStrings {
  static const String hrInsightsEstIdRoute = "/";
  static const String hrInsightsHooksRoute = "/hrInsightsHooks";
  static const String hrInsightsDashboardRoute = "/hrInsightsDashboard";
}

class HrInsightsDashboardArguments {
  final HrInsightsTabsEnums? selectedTab;

  HrInsightsDashboardArguments({
    this.selectedTab,
  });
}
