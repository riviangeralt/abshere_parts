import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_insights/data/res/strings/hr_insights_colors.dart';
import 'package:hr_insights/data/res/strings/hr_insights_strings.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HrInsightsColors.backgroundColor,
      centerTitle: true,
      automaticallyImplyLeading: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(
        HrInsightsStrings.businessConsultations,
        style:
            GoogleFonts.aBeeZee(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
