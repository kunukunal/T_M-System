import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_details_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_list_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class UnitWidget {
  appBar(String title) {
    final unitCntrl = Get.find<UnitCntroller>();

    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back(result: unitCntrl.isBackNeeded.value);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      centerTitle: true,
      title: Text(title, style: CustomStyles.otpStyle050505W700S16),
      // actions: [
      //   InkWell(
      //       onTap: () {
      //         unitCntrl.onAddTap();
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.all(8.r),
      //         child: addIcon,
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

  unitList({
    int? unitId,
    int? index,
    String? floorName,
    bool? isOccupied,
  }) {
    final unitCntrl = Get.find<UnitCntroller>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          print("dasdjkasl ${unitId}");

          Get.to(() => UnitDetails(), arguments: [unitId]);
        },
        child: Container(
          height: 68.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    unitCntrl.onEditTap(unitCntrl.unitList[index!]);
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: whiteColor,
                  icon: Icons.edit,
                ),

                //

                SlidableAction(
                  onPressed: (context) {
                    deleteFloorPopup(
                        button1: "no".tr,
                        button2: "yes".tr,
                        onButton1Tap: () {
                          Get.back();
                        },
                        onButton2Tap: () {
                          Get.back();
                          unitCntrl.deleteUnitData(unitId: unitId!);
                        },
                        title:
                            "${'are_you_sure_permanent_remove'.tr} $floorName");
                  },
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          floorName!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp - commonFontSize,
                              color: black),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${'unit'.tr} ${index! + 1}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp - commonFontSize,
                              color: grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    isOccupied! ? 'occupied'.tr : 'available'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp - commonFontSize,
                        color: isOccupied ? red : green),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
