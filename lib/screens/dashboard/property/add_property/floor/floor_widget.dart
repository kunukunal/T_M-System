import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class FloorWidget {
  appBar() {
    final floorCntrl = Get.find<FloorCntroller>();

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
      title: Text('Building 1', style: CustomStyles.otpStyle050505W700S16),
      actions: [
        InkWell(
            onTap: () {
              floorCntrl.onAddTap();
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

  floorList({
    String? buildingTitle,
    String? floor,
    bool? isFeature,
  }) {
    final propertyAbCntrl = Get.find<PropertyAbCntroller>();
    final floorCntrl = Get.find<FloorCntroller>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          floorCntrl.onFloorTap();
        },
        child: Container(
          height: 84.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.blue,
                  foregroundColor: whiteColor,
                  icon: Icons.edit,
                ),

                //

                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: whiteColor,
                  icon: Icons.cancel,

        
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buildingTitle!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: black),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            featureRentContainer(
                                isFeatured: true, title: 'Active'),
                            featureRentContainer(
                                isFeatured: false, title: 'Inactive'),
                            Padding(
                              padding: EdgeInsets.only(left: 60.w),
                              child: Text(
                                '$floor  Unit',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  featureRentContainer({bool? isFeatured, String? title}) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        height: 25.h,
        width: 80.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border:
                Border.all(color: isFeatured! ? lightBlue : lightBorderGrey)),
        child: Center(
            child: Text(
          title!,
          style: TextStyle(
              fontSize: 12.sp, color: black, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
