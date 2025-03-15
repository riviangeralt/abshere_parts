
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/model/stat_item_model.dart';
import 'package:hr_insights/data/res/strings/hr_insights_asset_strings.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/widgets/custom_tooltip.dart';

class StatsCardList extends StatelessWidget {
  const StatsCardList({super.key, required this.list, required this.message});

  final List<StatItemModel> list;
  final String message;

  @override
  Widget build(BuildContext context) {
    return list.length == 2 ? _buildColumnCards() : _buildGridCards();
  }

  Widget _buildColumnCards() {
    return Column(
      children: [
        _buildCard(list[0]),
        SizedBox(height: 8.h),
        _buildCard(list[1]),
      ],
    );
  }

  Widget _buildGridCards() {
    return Column(children: [
      Row(
        children: [
          Expanded(child: _buildCard(list[0])),
        ],
      ),
      SizedBox(height: 8.h),
      Row(
        children: [
          Expanded(child: _buildCard(list[1])),
          SizedBox(width: 8.h),
          Expanded(child: _buildCard(list[2])),
        ],
      ),
    ]);
  }

  Widget _buildCard(StatItemModel card) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.label,
            style: GoogleFonts.aBeeZee(
              color: HrInsightsColors.lightGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                card.value.toString(),
                style: GoogleFonts.aBeeZee(
                  color: HrInsightsColors.lightGrey,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    card.percChange,
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomTooltip(
                    tooltipChildren: [
                      Text(
                        message,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.6,
                        ),
                      )
                    ],
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Transform.rotate(
                        angle: card.arrowDir == ArrowDirection.up ? 3.14 : 0,
                        child: SvgPicture.asset(
                          HrInsightsAssetStrings.arrowSvg,
                          width: 12,
                          height: 8,
                          color: card.isPositive
                              ? HrInsightsColors.lightGreen
                              : HrInsightsColors.lightRed,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
