import 'package:abshere_core/data/res/strings/abshere_app_colors.dart';
import 'package:abshere_core/data/res/strings/abshere_app_navigator_strings.dart';
import 'package:abshere_core/data/res/strings/abshere_app_strings.dart';
import 'package:abshere_core/widgets/custom_appbar.dart';
import 'package:abshere_core/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AbsherbeLogin extends StatelessWidget {
  const AbsherbeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              SizedBox(
                height: 42.h,
              ),
              LoginForm(),
              SizedBox(height: 65.w),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 47.h),
        Text(
          AbshereAppStrings.login,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 30.sp,
            letterSpacing: 2.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          AbshereAppStrings.enterDetails,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AbshereAppStrings.dontHaveAccount,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () => navigateToSignup(context),
          child: Text(
            AbshereAppStrings.signup,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AbshereAppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, AbshereAppNavigatorStrings.abshereSignupRoute);
  }
}
