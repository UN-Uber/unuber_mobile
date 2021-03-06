// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/config/development.dart';
import 'package:unuber_mobile/ui/widgets/organisms/dialogs/setup_dialog_ui.dart';
import 'env.dart';
import 'utils/colors.dart' as appColors;

void main() {
  setupLocator();
  setupDialogUI();
  Development();
}

/// Main widget for the app
class MyApp extends StatelessWidget {
  final Env env;
  MyApp(this.env);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UnUber',
        theme: ThemeData(
            canvasColor: appColors.background,
            primaryColor: appColors.primary,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: appColors.secondary)),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.startupView);
  }
}
