import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_asset_strings.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_enums.dart';
import 'package:hr_insights/widgets/custom_card.dart';

class CustomMenu extends StatefulWidget {
  const CustomMenu({
    super.key,
    required this.options,
    required this.onChange,
    required this.value,
  });

  final List<MenuOptions> options;
  final Function(MenuOptions option) onChange;
  final String value;

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  late MenuController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MenuController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: 0.w,
      radius: 8.r,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MenuAnchor(
            controller: _controller,
            style: MenuStyle(
              shadowColor: WidgetStatePropertyAll(Colors.transparent),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
            ),
            builder: (
              BuildContext context,
              MenuController controller,
              Widget? child,
            ) {
              return GestureDetector(
                onTap: () {
                  if (_controller.isOpen) {
                    _controller.close();
                  } else {
                    _controller.open();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _controller.isOpen ? Colors.red : Colors.white,
                    border: Border.all(
                      color: HrInsightsColors.inActiveText,
                    ),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  padding: EdgeInsets.all(16.h),
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      Text(
                        widget.value,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16.sp,
                          color: HrInsightsColors.textColor,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        HrInsightsAssetStrings.dropdownSvg,
                        color: HrInsightsColors.textColor,
                      ),
                    ],
                  ),
                ),
              );
            },
            menuChildren: List.generate(
              widget.options.length,
              (int index) => GestureDetector(
                onTap: () {
                  final selectedValue = widget.options[index];
                  widget.onChange(selectedValue);
                  _controller.close();
                },
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
                  width: constraints.maxWidth,
                  child: Text(widget.options[index].label),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
