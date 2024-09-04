import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/onboarding/walk_through/walk_through_controller.dart';

class WalkThroughWidget {
  //variables

  //functions
  static pageViewWidget() {
    final walkCntrl = Get.find<WalkThroughController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Container(
              height: 420.h,
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: HexColor('#050505'),
                  borderRadius: BorderRadius.circular(10.r)),
              child: walkCntrl.isBannerDataLoading.value
                  ? const CircularProgressIndicator()
                  : Stack(
                      children: [
                        PageView(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          controller: walkCntrl.pageController.value,
                          children: [
                            ...walkCntrl.walkThrougImageList
                                .map((element) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  element['image'],
                                  height: 420.h,
                                  fit: BoxFit.cover,
                                ),
                              );
                            })
                          ],
                        ),
                        Positioned(
                          bottom: 20.h,
                          right: Get.width / 2.5,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: SmoothPageIndicator(
                              controller: walkCntrl.pageController.value,
                              count: walkCntrl.walkThrougImageList.length,
                              effect: SlideEffect(
                                  dotWidth: 14,
                                  dotHeight: 14,
                                  dotColor: HexColor('#EBEBEB'),
                                  activeDotColor: HexColor('#679BF1')),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }),

          SizedBox(
            height: 10.h,
          ),
          Text(
            'find_your_sweet_dream_place'.tr,
            style: CustomStyles.otpStyle050505.copyWith(fontSize: 20.sp - commonFontSize),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'find_your_dream_place_a_few_click'.tr,
            style: CustomStyles.desc606060.copyWith(fontSize: 14.sp - commonFontSize),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
