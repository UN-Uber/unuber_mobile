// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/custom_clipper.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class BezierContainer is a [StatelessWidget] used to generate a bezier curve for decoration purposes
class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        child: Transform.rotate(
            angle: -(pi / 4.0),
            child: ClipPath(
                clipper: ClipPainter(),
                child: Container(
                    height: _screenSize.height * .45,
                    width: _screenSize.width * .8,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          appColors.primary,
                          appColors.primaryVariant,
                          appColors.secondary
                        ]))))));
  }
}
