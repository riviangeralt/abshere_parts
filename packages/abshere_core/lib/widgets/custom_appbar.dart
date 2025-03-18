import 'package:abshere_core/data/res/strings/abshere_app_asset_strings.dart';
import 'package:abshere_core/data/res/strings/abshere_app_colors.dart';
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
              icon: SvgPicture.asset(
                AbshereAppAssetStrings.menuSvg,
                height: 21.h,
                width: 21.w,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            Spacer(),
            IconButton(
              icon: SvgPicture.asset(
                AbshereAppAssetStrings.loginHomeSvg,
                height: 23.h,
                width: 16.w,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AbshereAppAssetStrings.carSvg,
                height: 19.h,
                width: 16.w,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AbshereAppAssetStrings.heartSvg,
                height: 20.h,
                width: 20.w,
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                AbshereAppAssetStrings.cartSvg,
                height: 30.h,
                width: 30.w,
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
