import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/navbar_management/navbar_management_controller.dart';

import '../../common/text_styles.dart';

class NavBarManagementWidget {
  appBar() {
    // final managementCntrl = Get.find<NavBarManagementCntroller>();
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text('management'.tr, style: CustomStyles.otpStyle050505W700S16),
      // actions: [
      //   InkWell(
      //       onTap: () {
      //         managementCntrl.onSearchTap();
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.all(8.r),
      //         child: searchIcon,
      //       )),
      // ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Divider(
          height: 1,
          color: lightBorderGrey,
        ),
      ),
    );
  }

  //Occupied Container
  occUnoccContainer({String? icon, String? titleUnit, String? units}) {
    return Container(
      width: Get.width / 2.2,
      height: 95.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: lightBorderGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
            child: Row(
              children: [
                Image.asset(
                  icon!,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  titleUnit!,
                  style:
                      TextStyle(fontSize: 14.sp - commonFontSize, color: black),
                ),
              ],
            ),
          ),
          Divider(
            color: lightBorderGrey,
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              units!,
              style: TextStyle(
                  fontSize: 20.sp - commonFontSize,
                  color: black,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  commonText({String? title}) {
    // final managementCntrl = Get.find<NavBarManagementCntroller>();

    return GestureDetector(
        onTap: () {
          // managementCntrl.onBuildingTap();
        },
        child: Text(
          title!,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp - commonFontSize,
              color: black),
        ));
  }

  propertyList({
    int? id,
    String? propertyTitle,
    String? propertyDec,
    int? unitsAvailable,
    int? unitsOccupied,
    int? totalUnit,
  }) {
    final managementCntrl = Get.find<NavBarManagementCntroller>();

    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h, top: 10.h),
      child: GestureDetector(
        onTap: () {
          managementCntrl.onItemTap(id!, propertyTitle);
        },
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 50.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: HexColor('#BCD1F3'),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                            child: Text(propertyTitle![0].toUpperCase())),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            propertyTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp - commonFontSize,
                                color: black),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Text(
                            propertyDec!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp - commonFontSize,
                                color: grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Divider(
                  color: HexColor('#EBEBEB'),
                  height: 1.h,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // availableIcon,
                          CircularPercentIndicator(
                            radius: 12.0,
                            lineWidth: 4.0,
                            percent: unitsAvailable! / totalUnit!,
                            progressColor: Colors.blue,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              "$unitsAvailable ${'units_available'.tr}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp - commonFontSize,
                                  color: black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 12.0,
                            lineWidth: 4.0,
                            percent: unitsOccupied! / totalUnit,
                            progressColor: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              "$unitsOccupied ${'units_occupied'.tr}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp - commonFontSize,
                                  color: black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
