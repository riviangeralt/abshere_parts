import 'package:abshere_core/data/res/strings/abshere_app_asset_strings.dart';
import 'package:abshere_core/data/res/strings/abshere_app_strings.dart';
import 'package:abshere_core/widgets/custom_button.dart';
import 'package:abshere_core/widgets/custom_textfield.dart';
import 'package:abshere_core/widgets/signup_with_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          leadingIcon: AbshereAppAssetStrings.emailSvg,
          textInputType: TextInputType.emailAddress,
          placeholder: AbshereAppStrings.enterEmail,
        ),
        SizedBox(
          height: 30.h,
        ),
        CustomTextField(
          leadingIcon: AbshereAppAssetStrings.lockSvg,
          placeholder: AbshereAppStrings.enterPassword,
          isPassword: true,
        ),
        SizedBox(
          height: 30.h,
        ),
        CustomButton(text: AbshereAppStrings.logIn),
        SizedBox(
          height: 75.h,
        ),
        SignupWithGoogle()
      ],
    );
  }
}
