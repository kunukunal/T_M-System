import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/tenant_screens/explore/explore_controller.dart';
import 'package:tanent_management/tenant_screens/explore/explore_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({
    super.key,
  });
  final exploreCntrl = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            'explore'.tr,
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreWidget().exploreSearch(
                    icon: occupiedIcon, titleUnit: 'rent_due'.tr, units: '20/40'),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() {
                  return Text(
                    "${'search_results'.tr} (${exploreCntrl.getUnitResult.length})",
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w700, fontFamily: 'Inter'),
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                ExploreWidget().searchResult(),
              ],
            ),
          ),
        ));
  }
}
