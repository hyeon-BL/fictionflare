import 'package:fictionflare_app/common/widgets/error.dart';
import 'package:fictionflare_app/features/auth/screens/auth_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreens.routeName:
      return MaterialPageRoute(builder: (_) => AuthScreens());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: ErrorScreen(error: 'No route defined'),
              ));
  }
}
