import 'package:hr_insights/data/res/model/hooks_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';

abstract class HrInsightsHooksState {}

class HrInsightsHooksInitial extends HrInsightsHooksState {}

class HrInsightsHooksLoaded extends HrInsightsHooksState {
  final HooksModel hooks;

  HrInsightsHooksLoaded(this.hooks);
}

class HrInsightsHooksCategoryChanged extends HrInsightsHooksState {
  final HrInsightsCategoryEnums category;

  HrInsightsHooksCategoryChanged(this.category);
}

class HrInsightsHookChange extends HrInsightsHooksState {
  final String hookMessage;
  final HrInsightsTabsEnums type;

  HrInsightsHookChange(this.hookMessage, this.type);
}
