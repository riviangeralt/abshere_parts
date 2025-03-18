import 'package:abshere_core/data/res/strings/abshere_app_navigator_strings.dart';
import 'package:abshere_core/ui/absherbe_login/absherbe_login.dart';
import 'package:abshere_core/ui/absherbe_signup/absherbe_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbshereAppNavigator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AbshereAppNavigatorStrings.asbhereLoginRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: AbshereAppNavigatorStrings.asbhereLoginRoute,
          ),
          builder: (context) {
            return const AbsherbeLogin();
          },
        );
      case AbshereAppNavigatorStrings.abshereSignupRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(
            name: AbshereAppNavigatorStrings.abshereSignupRoute,
          ),
          builder: (context) {
            return const AbsherbeSignup();
          },
        );
    }
    return null;
  }
}
