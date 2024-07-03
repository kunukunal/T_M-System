import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/search/search_controller.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class SearchWidget {
  appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      centerTitle: true,
      title: Text('Search', style: CustomStyles.otpStyle050505W700S16),
    );
  }

  //Occupied Container
  occUnoccContainer({String? icon, String? titleUnit, String? units}) {
    return Container(
      width: Get.width / 2.2,
      height: 90.h,
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
                  style: TextStyle(fontSize: 14.sp, color: black),
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
                  fontSize: 20.sp, color: black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  unitList(

      {
    String? unitTitle,
    String? price,
    String? availablityTitle,
    String? icon,
    String? buildingIcon,
    String? property,
    String? building,
    String? floor,
    bool? isOccupied,
  }) {
    final searchCntl = Get.find<SearchCntroller>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          searchCntl.onItemTap(

          );
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
                        height: 55.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: HexColor('#444444'),
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                              image: Image.asset(buildingIcon!).image,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              unitTitle!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: black),
                            ),
                            SizedBox(
                              width: 110.w,
                            ),
                            Text(
                              price!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              icon!,
                              height: 23.h,
                              width: isOccupied! ? 25.w : 20.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            isOccupied!
                                ? RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Occupied From July/2024 ',
                                          style: TextStyle(
                                            color: red,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n John Wick',
                                          style: TextStyle(
                                              color: black, fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    availablityTitle!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                        color: green),
                                  ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              'assets/icons/Frame.png',
                              height: 24.h,
                              width: 24.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: HexColor('#EBEBEB'),
                height: 1.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    children: [
                      Text(
                        'Property $property    ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: grey),
                      ),
                      Text(
                        'Building $building    ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: grey),
                      ),
                      Text(
                        'Floor $floor    ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: grey),
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
