import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/model/stat_item_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';

abstract class HrInsightsDashboardState {}

class HrInsightsDashboardInitial extends HrInsightsDashboardState {}

class HrInsightsTabChanged extends HrInsightsDashboardState {
  final HrInsightsTabsEnums tabIndex;
  HrInsightsTabChanged({required this.tabIndex});
}

class HrInsightsYearChanged extends HrInsightsDashboardState {
  final MenuOptions option;
  HrInsightsYearChanged({required this.option});
}

class HrInsightsStatisticsCategoryChanged extends HrInsightsDashboardState {
  final HrInsightsCategoryEnums category;
  HrInsightsStatisticsCategoryChanged({required this.category});
}

class HrInsightsCompareWithMarketChanged extends HrInsightsDashboardState {
  final bool compareWithMarket;
  HrInsightsCompareWithMarketChanged({required this.compareWithMarket});
}

class HrInsightsTurnoverStatsLoaded extends HrInsightsDashboardState {
  final List<StatItemModel> statsList;
  final String message;

  HrInsightsTurnoverStatsLoaded(this.statsList, this.message);
}

class HrInsightsEstablishmentGraphLoaded extends HrInsightsDashboardState {
  final List<CommonGraphModel> itemsList;

  HrInsightsEstablishmentGraphLoaded(this.itemsList);
}

class CompareDataLoaded extends HrInsightsDashboardState {
  final List<CommonGraphModel> estList;
  final List<CommonGraphModel> marketList;

  CompareDataLoaded({required this.estList, required this.marketList});
}

class HrInsightsEstablishmentDetailsLoaded extends HrInsightsDashboardState {
  final String estName;

  HrInsightsEstablishmentDetailsLoaded(this.estName);
}
