import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class UnitWidget {
  appBar(String title) {
    final unitCntrl = Get.find<UnitCntroller>();

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
      title: Text(title, style: CustomStyles.otpStyle050505W700S16),
      actions: [
        InkWell(
            onTap: () {
              unitCntrl.onAddTap();
            },
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: addIcon,
            )),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Divider(
          height: 1,
          color: lightBorderGrey,
        ),
      ),
    );
  }

  unitList({
    int? index,
    String? floorName,
    bool? isOccupied,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          ;
        },
        child: Container(
          height: 68.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unit ${index! + 1}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: black),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        floorName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  isOccupied! ? 'Occupied' : 'Available',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: isOccupied ? red : green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
