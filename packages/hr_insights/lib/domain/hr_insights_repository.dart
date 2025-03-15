import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/model/establishment_details.model.dart';
import 'package:hr_insights/data/res/model/hooks_model.dart';
import 'package:hr_insights/data/res/model/salary_details_model.dart';
import 'package:hr_insights/data/res/model/turnover_details_model.dart';

abstract class HrInsightsRepository {
  Future<TurnoverDetailsModel> fetchTurnoverDetails({required String estId, required String year});
  Future<List<CommonGraphModel>> fetchEstablishmentGraphTurnoverStats({required String estId, required String filterBy, required String year});
  Future<List<CommonGraphModel>> fetchMarketGraphTurnoverStats({required String estId, required String filterBy, required String year});
  Future<SalaryDetailsModel> fetchEmployeeSalaryDetails({required String estId, required String year});
  Future<List<CommonGraphModel>> fetchEstablishmentGraphSalaryGrowthStats({required String estId, required String filterBy, required String year});
  Future<List<CommonGraphModel>> fetchMarketGraphSalaryGrowthStats({required String estId, required String filterBy, required String year});
  Future<EstablishmentDetailsModel> fetchEstablishmentDetails({required String estId});
  Future<HooksModel> fetchEstablishmentHooks({required String estId});
}
