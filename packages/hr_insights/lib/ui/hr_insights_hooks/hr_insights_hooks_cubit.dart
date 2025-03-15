import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_insights/data/hr_insights_repository_impl.dart';
import 'package:hr_insights/data/res/model/hooks_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/ui/hr_insights_hooks/hr_insights_hooks_state.dart';

class HrInsightsHooksCubit extends Cubit<HrInsightsHooksState> {
  HrInsightsHooksCubit() : super(HrInsightsHooksInitial());
  final HrInsightsRepositoryImpl repository = HrInsightsRepositoryImpl();
  HrInsightsCategoryEnums selectedCategory = HrInsightsCategoryEnums.jobTitle;
  HooksModel? allHooks;
  int index = 0;
  Timer? _timer;

  Future<void> fetchEstablishmentHooks(String estId) async {
    await repository
        .fetchEstablishmentHooks(estId: estId)
        .then(_parseHooksResponse)
        .onError((error, stackTrace) {
      print('error is ${error.toString()}');
    });
  }

  _parseHooksResponse(HooksModel response) {
    allHooks = response;
    emit(HrInsightsHooksLoaded(response));
    startTimer(getCurrentHooksList(response.jobTitle).length - 1);
  }

  void onChangeCategory(HrInsightsCategoryEnums category) {
    selectedCategory = category;
    emit(HrInsightsHooksCategoryChanged(category));
    _timer?.cancel();
    index = 0;
    startTimer(
      getCurrentHooksList(getCurrentCategoryHooks(category)).length - 1,
    );
  }

  HooksCategory getCurrentCategoryHooks(HrInsightsCategoryEnums category) {
    switch (category) {
      case HrInsightsCategoryEnums.jobTitle:
        return allHooks!.jobTitle;
      case HrInsightsCategoryEnums.age:
        return allHooks!.ageGroup;
      case HrInsightsCategoryEnums.gender:
        return allHooks!.gender;
      case HrInsightsCategoryEnums.tenure:
        return allHooks!.tenureGroup;

      default:
        return allHooks!.jobTitle;
    }
  }

  List<Insight> getCurrentHooksList(HooksCategory hooksCat) {
    final salaryHooks = hooksCat.salary.insights;
    final turnoverHooks = hooksCat.turnover.insights;

    return [...salaryHooks, ...turnoverHooks];
  }

  void startTimer(int length) {
    final hooks =
        getCurrentHooksList(getCurrentCategoryHooks(selectedCategory));

    emit(HrInsightsHookChange(hooks[index].message, hooks[index].type));

    _timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        if (index < length) {
          final hooks =
              getCurrentHooksList(getCurrentCategoryHooks(selectedCategory));
          index += 1;
          emit(HrInsightsHookChange(hooks[index].message, hooks[index].type));
        } else {
          index = 0;
          final newSelectedCategory = _getNextCategory(selectedCategory);
          onChangeCategory(newSelectedCategory);

          final newHooks =
              getCurrentHooksList(getCurrentCategoryHooks(newSelectedCategory));
          emit(HrInsightsHookChange(newHooks[index].message, hooks[index].type));
        }
      },
    );
  }

  HrInsightsCategoryEnums _getNextCategory(
      HrInsightsCategoryEnums currentCategory) {
    final categoryList = HrInsightsCategoryEnums.values
        .where((ele) => ele != HrInsightsCategoryEnums.workExp)
        .toList();
    int currentIndex = categoryList.indexOf(currentCategory);
    int nextIndex = (currentIndex + 1) % categoryList.length;
    return categoryList[nextIndex];
  }
}
