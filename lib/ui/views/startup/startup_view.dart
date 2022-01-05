// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

// Project imports:
import 'startup_viewmodel.dart';

/// The class StartupView is the view for the startup route
class StartupView extends StatelessWidget {
  const StartupView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => ViewModelBuilder<StartupViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Column()
              ],
            )
          )
        ),
        viewModelBuilder: () => StartupViewModel(),
      )
    );
  }
}
