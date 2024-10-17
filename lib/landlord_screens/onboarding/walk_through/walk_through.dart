import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/walk_through/walk_through_controller.dart';
import 'package:tanent_management/landlord_screens/onboarding/walk_through/walk_through_widgets.dart';

import '../../../common/constants.dart';

class WalkThroughScreen extends StatelessWidget {
  WalkThroughScreen({super.key});

  final cntrl = Get.put(WalkThroughController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 20.h, bottom: 5.h),
                child: SizedBox(height: 60.h, width: 135.w, child: splashImage),
              ),
              WalkThroughWidget.pageViewWidget(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: customButton(
                    onPressed: () {
                      cntrl.onGetStartedTap();
                    },
                    text: 'get_started'.tr,
                    width: Get.width,
                    // suffix: getStartedButtonIcon
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
