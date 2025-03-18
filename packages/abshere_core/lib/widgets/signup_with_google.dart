import 'package:abshere_core/data/res/strings/abshere_app_asset_strings.dart';
import 'package:abshere_core/data/res/strings/abshere_app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupWithGoogle extends StatelessWidget {
  const SignupWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: Colors.black.withOpacity(.4),
            )),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AbshereAppAssetStrings.googleSvg),
            SizedBox(width: 16.w),
            Text(
              AbshereAppStrings.signUpWithGoogle,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
