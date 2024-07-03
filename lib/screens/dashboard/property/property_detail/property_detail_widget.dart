import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/property/property_detail/property_detail_controller.dart';

class PropertyDetailViewWidget{
   pageViewWidget(){
    final walkCntrl = Get.find<PropertyDetailViewController>();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            width: Get.width,
            decoration: BoxDecoration(
              // color: HexColor('#050505'),
                borderRadius: BorderRadius.circular(10.r)
            ),
            child: Stack(
              children: [
                PageView(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  controller: walkCntrl.pageController.value,
                  children: [
                    profileImage,
                    profileImage,
                    profileImage,
                    profileImage,

                  ],
                ),
                Positioned(
                  bottom: 10.h,
                  right: Get.width/2.8,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: SmoothPageIndicator(
                      controller: walkCntrl.pageController.value,
                      count: 4,
                      effect:  SlideEffect(
                          dotWidth: 8.w,
                          dotHeight: 8.h,
                          dotColor: HexColor('#EBEBEB'),
                          activeDotColor: HexColor('#679BF1')),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}