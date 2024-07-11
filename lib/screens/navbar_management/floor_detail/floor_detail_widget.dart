import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/unit_history.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class FloorDetailWidget {
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
      title: Text('Building A - Floor 1',
          style: CustomStyles.otpStyle050505W700S16),
    );
  }

  unitList({
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
    final floorCntrl = Get.find<FloorDetailController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          floorCntrl.onBuildingTap();
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
                                : FittedBox(
                                    child: Text(
                                      availablityTitle!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                          color: green),
                                    ),
                                  ),
                            SizedBox(
                              width: isOccupied! ? 2.w : 17.w,
                            ),
                            isOccupied!
                                ? Container(
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(() => UnitHistory());
                                    },
                                    child: Image.asset(
                                      'assets/icons/timer.png',
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                            SizedBox(
                              width: 2.w,
                            ),
                            isOccupied!
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(() => UnitHistory());
                                    },
                                    child: Image.asset(
                                      'assets/icons/timer.png',
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/icons/Frame.png',
                                    height: 20.h,
                                    width: 20.w,
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
