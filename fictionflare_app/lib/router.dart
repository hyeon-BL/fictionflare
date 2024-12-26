import 'package:fictionflare_app/common/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:fictionflare_app/features/auth/screens/login_screens.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => LoginScreen());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: ErrorScreen(error: 'No route defined'),
              ));
  }
}
