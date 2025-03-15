import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_insights/data/hr_insights_repository_impl.dart';
import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/model/salary_details_model.dart';
import 'package:hr_insights/data/res/model/stat_item_model.dart';
import 'package:hr_insights/data/res/model/turnover_details_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/data/res/strings/hr_insights_strings.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:hr_insights/utils/shared_prefs.dart';

class HrInsightsDashboardCubit extends Cubit<HrInsightsDashboardState> {
  HrInsightsDashboardCubit() : super(HrInsightsDashboardInitial());
  final HrInsightsRepositoryImpl repository = HrInsightsRepositoryImpl();

  HrInsightsCategoryEnums selectedCategory = HrInsightsCategoryEnums.jobTitle;
  MenuOptions selectedYear = MenuOptions.prevYear;
  HrInsightsTabsEnums selectedTab = HrInsightsTabsEnums.turnover;

  void onTabChanged(HrInsightsTabsEnums tab) {
    selectedTab = tab;
    emit(HrInsightsTabChanged(tabIndex: tab));
  }

  void onYearChange(MenuOptions option) {
    selectedYear = option;
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    emit(HrInsightsYearChanged(option: option));
    if (selectedTab == HrInsightsTabsEnums.turnover) {
      fetchTurnoverDetails(estId, option.value);
      onStatisticsCategoryChanged(selectedCategory);
    } else {
      fetchEmployeeSalaryDetails(estId, option.value);
      onSgStatisticsCategoryChanged(selectedCategory);
    }
  }

  void onStatisticsCategoryChanged(
    HrInsightsCategoryEnums category,
  ) {
    selectedCategory = category;
    emit(HrInsightsStatisticsCategoryChanged(category: category));
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    fetchEstablishmentGraphTurnover(estId, category.value, selectedYear.value);
    emit(HrInsightsCompareWithMarketChanged(compareWithMarket: false));
  }

  void onCompareWithMarketChanged(bool value) {
    emit(HrInsightsCompareWithMarketChanged(compareWithMarket: value));
    if (value == true) {
      final estId = SharedPreferencesUtils().getString('estId') ?? '';
      fetchCompareData(estId, selectedCategory.value, selectedYear.value);
    }
  }

  void onSgStatisticsCategoryChanged(HrInsightsCategoryEnums category) {
    selectedCategory = category;
    emit(HrInsightsStatisticsCategoryChanged(category: category));
    final estId = SharedPreferencesUtils().getString('estId') ?? '';
    fetchEstablishmentGraphSallaryGrowth(
        estId, category.value, selectedYear.value);
    emit(HrInsightsCompareWithMarketChanged(compareWithMarket: false));
  }

  void onSgCompareWithMarketChanged(bool value) {
    emit(HrInsightsCompareWithMarketChanged(compareWithMarket: value));
    if (value == true) {
      final estId = SharedPreferencesUtils().getString('estId') ?? '';
      fetchSalaryGrowthCompareData(
          estId, selectedCategory.value, selectedYear.value);
    }
  }

  Future<void> fetchTurnoverDetails(String estId, String year) async {
    await repository
        .fetchTurnoverDetails(estId: estId, year: year)
        .then(_parseTurnoverDetailsResponse)
        .onError((error, stackTrace) {
      print('error is ${error.toString()}');
    });
  }

  Future<void> fetchEmployeeSalaryDetails(String estId, String year) async {
    await repository
        .fetchEmployeeSalaryDetails(estId: estId, year: year)
        .then(_parseEmployeeSalaryDetailsResponse)
        .onError((error, stackTrace) {
      print('error is ${error.toString()}');
    });
  }

  Future<List<CommonGraphModel>> fetchEstablishmentGraphTurnover(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> estList = [];
    await repository
        .fetchEstablishmentGraphTurnoverStats(
            estId: estId, filterBy: filterBy, year: year)
        .then((response) {
      estList = response;
      emit(HrInsightsEstablishmentGraphLoaded(response));
    }).onError((error, stackTrace) {
      print('error is ${error.toString()}');
      estList = [];
    });
    return estList;
  }

  Future<List<CommonGraphModel>> fetchMarketGraphTurnover(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> marketList = [];
    await repository
        .fetchMarketGraphTurnoverStats(
            estId: estId, filterBy: filterBy, year: year)
        .then((response) {
      marketList = response;
    }).onError((error, stackTrace) {
      print('error is ${error.toString()}');
      marketList = [];
    });
    return marketList;
  }

  Future<void> fetchCompareData(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> estList = [];
    List<CommonGraphModel> marketList = [];

    try {
      estList = await fetchEstablishmentGraphTurnover(estId, filterBy, year);
      marketList = await fetchMarketGraphTurnover(estId, filterBy, year);

      emit(CompareDataLoaded(estList: estList, marketList: marketList));
    } catch (e) {
      // emit(CompareDataError(error: e.toString()));
    }
  }

  Future<List<CommonGraphModel>> fetchEstablishmentGraphSallaryGrowth(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> estList = [];
    await repository
        .fetchEstablishmentGraphSalaryGrowthStats(
            estId: estId, filterBy: filterBy, year: year)
        .then((response) {
      estList = response;
      emit(HrInsightsEstablishmentGraphLoaded(response));
    }).onError((error, stackTrace) {
      print('error is ${error.toString()}');
      estList = [];
    });
    return estList;
  }

  Future<List<CommonGraphModel>> fetchMarketGraphSalaryGrowth(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> marketList = [];
    await repository
        .fetchMarketGraphSalaryGrowthStats(
            estId: estId, filterBy: filterBy, year: year)
        .then((response) {
      marketList = response;
    }).onError((error, stackTrace) {
      print('error is ${error.toString()}');
      marketList = [];
    });
    return marketList;
  }

  Future<void> fetchSalaryGrowthCompareData(
      String estId, String filterBy, String year) async {
    List<CommonGraphModel> estList = [];
    List<CommonGraphModel> marketList = [];

    try {
      estList =
          await fetchEstablishmentGraphSallaryGrowth(estId, filterBy, year);
      marketList = await fetchMarketGraphSalaryGrowth(estId, filterBy, year);

      emit(CompareDataLoaded(estList: estList, marketList: marketList));
    } catch (e) {
      // emit(CompareDataError(error: e.toString()));
    }
  }

  Future<void> fetchEstablishmentDetails(String estId) async {
    await repository.fetchEstablishmentDetails(estId: estId).then((response) {
      emit(HrInsightsEstablishmentDetailsLoaded(response.estName));
    }).onError((error, stackTrace) {
      print('error is ${error.toString()}');
    });
  }

  _parseTurnoverDetailsResponse(TurnoverDetailsModel response) {
    final statsList = [
      StatItemModel(
        label: HrInsightsStrings.totalEmployees,
        value: response.totalEmployeeResponse.totalEmployee.toDouble(),
        percChange: response.totalEmployeeResponse.employeePerChange.toString(),
        color: HrInsightsColors.textColor,
        arrowDir: response.totalEmployeeResponse.employeePerChange.isNegative
            ? ArrowDirection.down
            : ArrowDirection.up,
        isPositive:
            !response.totalEmployeeResponse.employeePerChange.isNegative,
      ),
      StatItemModel(
        label: HrInsightsStrings.totalLeavers,
        value: response.totalEmployeeResponse.totalLeavers.toDouble(),
        percChange: response.totalEmployeeResponse.leaverPercChange.toString(),
        color: HrInsightsColors.secondaryColor,
        arrowDir: response.totalEmployeeResponse.leaverPercChange.isNegative
            ? ArrowDirection.down
            : ArrowDirection.up,
        isPositive: response.totalEmployeeResponse.leaverPercChange.isNegative,
      ),
      StatItemModel(
          label: HrInsightsStrings.turnoverRate,
          value: response.turnover.totalTurnover.toDouble(),
          percChange: '${response.turnover.turnoverRatePerChange}%',
          color: HrInsightsColors.tertiaryColor,
          arrowDir: response.turnover.turnoverRatePerChange.isNegative
              ? ArrowDirection.down
              : ArrowDirection.up,
          isPositive: response.turnover.turnoverRatePerChange.isNegative),
    ];

    final message = response.turnoverMessage.message;

    emit(HrInsightsTurnoverStatsLoaded(statsList, message));
  }

  _parseEmployeeSalaryDetailsResponse(SalaryDetailsModel response) {
    final statsList = [
      StatItemModel(
        label: HrInsightsStrings.totalMonthlySalaries,
        value: response.totalSalary.toDouble(),
        percChange: response.totalSalaryChangePercent.toString(),
        color: HrInsightsColors.secondaryColor,
        arrowDir: response.totalSalaryChangePercent.isNegative
            ? ArrowDirection.down
            : ArrowDirection.up,
        isPositive: !response.totalSalaryChangePercent.isNegative,
      ),
      StatItemModel(
        label: HrInsightsStrings.totalAverageSalaries,
        value: response.avgSalary.toDouble(),
        percChange: response.avgSalaryChangePercent.toString(),
        color: HrInsightsColors.tertiaryColor,
        arrowDir: response.avgSalaryChangePercent.isNegative
            ? ArrowDirection.down
            : ArrowDirection.up,
        isPositive: !response.avgSalaryChangePercent.isNegative,
      ),
    ];

    final message = response.message;
    emit(HrInsightsTurnoverStatsLoaded(statsList, message));
  }
}
