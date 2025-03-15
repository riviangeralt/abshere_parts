import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/model/common_graph_model.dart';
import 'package:hr_insights/data/res/model/compare_graph_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_cubit.dart';
import 'package:hr_insights/ui/hr_insights_dashboard/hr_insights_dashboard_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:intl/intl.dart";

class StatisticsGraph extends StatefulWidget {
  const StatisticsGraph({
    super.key,
    required this.establishmentList,
    required this.marketList,
  });
  final List establishmentList;
  final List marketList;

  @override
  State<StatisticsGraph> createState() => _GraphState();
}

class _GraphState extends State<StatisticsGraph> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HrInsightsDashboardCubit, HrInsightsDashboardState>(
      buildWhen: (previous, current) =>
          current is HrInsightsCompareWithMarketChanged,
      builder: (context, state) {
        bool value = false;
        if (state is HrInsightsCompareWithMarketChanged) {
          value = state.compareWithMarket;
        }
        return value ? _buildMarketChart() : _buildEstablishmentChart();
      },
    );
  }

  SfCartesianChart _buildEstablishmentChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: GoogleFonts.aBeeZee(
          fontSize: 12.sp,
        ),
        labelsExtent: 30,
        maximumLabelWidth: 25.w,
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        numberFormat: NumberFormat.compact(),
      ),
      series: _getEstablishmentColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  SfCartesianChart _buildMarketChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: GoogleFonts.aBeeZee(
          fontSize: 12.sp,
        ),
        labelsExtent: 30,
        maximumLabelWidth: 25,
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        numberFormat: NumberFormat.compact(),
      ),
      series: _getMarketColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<BarSeries<CommonGraphModel, String>> _getEstablishmentColumnSeries() {
    return <BarSeries<CommonGraphModel, String>>[
      BarSeries<CommonGraphModel, String>(
        dataSource: widget.establishmentList.map((ele) {
          return CommonGraphModel(
            label: ele.label.toUpperCase(),
            value: ele.value,
          );
        }).toList(),
        xValueMapper: (CommonGraphModel sales, _) => sales.label,
        yValueMapper: (CommonGraphModel sales, _) => sales.value,
        pointColorMapper: (CommonGraphModel sales, _) =>
            HrInsightsColors.secondaryColor,
        width: 0.1,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: GoogleFonts.aBeeZee(fontSize: 12.sp),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      )
    ];
  }

  List<BarSeries<CompareGraphModel, String>> _getMarketColumnSeries() {
    return <BarSeries<CompareGraphModel, String>>[
      BarSeries<CompareGraphModel, String>(
        dataSource: makeChartData(),
        width: 0.4,
        spacing: 0.3,
        xValueMapper: (CompareGraphModel sales, _) => sales.establishmentLabel,
        yValueMapper: (CompareGraphModel sales, _) => sales.establishmentValue,
        pointColorMapper: (CompareGraphModel sales, _) =>
            HrInsightsColors.secondaryColor,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: GoogleFonts.aBeeZee(fontSize: 12.sp),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      BarSeries<CompareGraphModel, String>(
        dataSource: makeChartData(),
        width: 0.4,
        spacing: 0.3,
        xValueMapper: (CompareGraphModel sales, _) => sales.marketLabel,
        yValueMapper: (CompareGraphModel sales, _) => sales.marketValue,
        pointColorMapper: (CompareGraphModel sales, _) =>
            HrInsightsColors.primaryColor,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: GoogleFonts.aBeeZee(fontSize: 12.sp),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      )
    ];
  }

  List<CompareGraphModel> makeChartData() {
    List<CompareGraphModel> dataSrc = [];

    for (int i = 0; i < widget.establishmentList.length; i++) {
      if (i < widget.marketList.length) {
        final establistmentDetail = widget.establishmentList[i];
        final marketDetail = widget.marketList[i];

        dataSrc.add(
          CompareGraphModel(
            establishmentLabel: establistmentDetail.label.toUpperCase(),
            establishmentValue: establistmentDetail.value,
            marketValue: marketDetail.value,
            marketLabel: marketDetail.label.toUpperCase(),
          ),
        );
      }
    }

    return dataSrc;
  }
}
