import 'package:app/data/res/strings/abshere_app_asset_strings.dart';
import 'package:app/data/res/strings/abshere_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AbshereAppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(AbshereAppAssetStrings.menuSvg),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.home_sharp,
                color: Colors.white,
                size: 24.h,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(57.h);
}
