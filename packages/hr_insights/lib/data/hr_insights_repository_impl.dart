import 'package:dio/dio.dart';
import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/model/establishment_details.model.dart';
import 'package:hr_insights/data/res/model/hooks_model.dart';
import 'package:hr_insights/data/res/model/salary_details_model.dart';
import 'package:hr_insights/data/res/model/turnover_details_model.dart';
import 'package:hr_insights/dio/api_client.dart';
import 'package:hr_insights/domain/hr_insights_api.dart';
import 'package:hr_insights/domain/hr_insights_repository.dart';

class HrInsightsRepositoryImpl extends HrInsightsRepository {
  ApiClient apiClient = ApiClient();

  @override
  Future<TurnoverDetailsModel> fetchTurnoverDetails(
      {required String estId, required String year}) async {
    final Response response = await apiClient.get(
        HrInsightsApi.fetchTurnover(estId),
        queryParams: {'operation': 'turnover', "year": year});
    return TurnoverDetailsModel.fromJson(response.data);
  }

  @override
  Future<List<CommonGraphModel>> fetchEstablishmentGraphTurnoverStats({
    required String estId,
    required String filterBy,
    required String year,
  }) async {
    final Response response = await apiClient
        .get(HrInsightsApi.fetchTurnover(estId), queryParams: {
      'operation': 'graphTurnover',
      'filterBy': filterBy,
      'year': year
    });
    List<CommonGraphModel> graphModels = [];
    if (response.data is List) {
      response.data.forEach((jsonData) {
        graphModels.add(CommonGraphModel.fromJson(jsonData));
      });
    }
    return graphModels;
  }

  @override
  Future<List<CommonGraphModel>> fetchMarketGraphTurnoverStats(
      {required String estId,
      required String filterBy,
      required String year}) async {
    final Response response = await apiClient
        .get(HrInsightsApi.fetchIndustryDetails(estId), queryParams: {
      'operation': 'graphTurnover',
      'filterBy': filterBy,
      'year': year
    });
    List<CommonGraphModel> graphModels = [];
    if (response.data is List) {
      response.data.forEach((jsonData) {
        graphModels.add(CommonGraphModel.fromJson(jsonData));
      });
    }
    return graphModels;
  }

  @override
  Future<SalaryDetailsModel> fetchEmployeeSalaryDetails(
      {required String estId, required String year}) async {
    final Response response = await apiClient.get(
        HrInsightsApi.fetchEmployeeSalary(estId),
        queryParams: {'operation': 'salaryGrowth', "year": year});
    return SalaryDetailsModel.fromJson(response.data);
  }

  @override
  Future<List<CommonGraphModel>> fetchEstablishmentGraphSalaryGrowthStats(
      {required String estId,
      required String filterBy,
      required String year}) async {
    final Response response = await apiClient
        .get(HrInsightsApi.fetchEmployeeSalary(estId), queryParams: {
      'operation': 'salaryGraph',
      'filterBy': filterBy,
      'year': year
    });
    List<CommonGraphModel> graphModels = [];
    if (response.data is List) {
      response.data.forEach((jsonData) {
        graphModels.add(CommonGraphModel.fromJson(jsonData));
      });
    }
    return graphModels;
  }

  @override
  Future<List<CommonGraphModel>> fetchMarketGraphSalaryGrowthStats(
      {required String estId,
      required String filterBy,
      required String year}) async {
    final Response response = await apiClient
        .get(HrInsightsApi.fetchIndustryDetails(estId), queryParams: {
      'operation': 'industrySalary',
      'filterBy': filterBy,
      'year': year
    });
    List<CommonGraphModel> graphModels = [];
    if (response.data is List) {
      response.data.forEach((jsonData) {
        graphModels.add(CommonGraphModel.fromJson(jsonData));
      });
    }
    return graphModels;
  }

  @override
  Future<EstablishmentDetailsModel> fetchEstablishmentDetails({
    required String estId,
  }) async {
    final Response response =
        await apiClient.get(HrInsightsApi.fetchEstablishment(estId));
    return EstablishmentDetailsModel.fromJson(response.data);
  }

  @override
  Future<HooksModel> fetchEstablishmentHooks({required String estId}) async {
    final Response response =
        await apiClient.get(HrInsightsApi.fetchHookDetails(estId));
    return HooksModel.fromJson(response.data);
  }
}
