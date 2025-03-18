import 'package:app/data/res/strings/abshere_app_navigator_strings.dart';
import 'package:app/ui/abshere_login/abshere_login.dart';
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
            return const AbshereLogin();
          },
        );
    }
    return null;
  }
}
