           import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';

import '../common/constants.dart';
import '../common/text_styles.dart';

class CustomDialog {
  //Circular Progress Indicator
  static circularProcessDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        // barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const Center(
                child: SizedBox(
                  // height: 50,
                  // width: 50,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 30,
                    ))),
          );
        });
  }

  static customSnackBar(BuildContext context, String message, {int duration = 3}) {
    showSimpleNotification(
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            gradient:  linearGradient0to72
            /* LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(
                  0.7, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                // HexColor('663dff'),
                HexColor('dce8e0'),
                // HexColor("d2d8d6")
                Colors.white
              ], // red to yellow
              tileMode: TileMode.clamp,
            )*/
            ,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: CustomStyles.white16,
              ),
            ),
          ),
        ),
        background: Colors.transparent,
        slideDismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: duration));
  }
}
