import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_property_widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/floor/floor_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class FloorWidget {
  appBar(String title) {
    final floorCntrl = Get.find<FloorCntroller>();
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back(result: floorCntrl.isApiNeeded.value);
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
      //         addFloor(button1: "Cancel", button2: "Add", title: "Add Floor");
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

  floorList({
    int? floorId,
    String? buildingTitle,
    int? floor,
    bool? isFeature,
  }) {
    final floorCntrl = Get.find<FloorCntroller>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          floorCntrl.onFloorTap(floorId: floorId!, floorName: buildingTitle.capitalize.toString());
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
                  onPressed: (context) {
                    floorCntrl.updateFloorName.value.text = buildingTitle!;
                    floorCntrl.activeFloor.value = isFeature ?? false;
                    updateFloorDetails(
                        button1: "cancel".tr,
                        button2: "update".tr,
                        onButton1Tap: () {
                          Get.back();
                        },
                        onButton2Tap: () {
                          if (floorCntrl
                              .updateFloorName.value.text.isNotEmpty) {
                            Get.back();
                            floorCntrl.updateFloorData(
                                floorId: floorId!, noOfUnits: floor!);
                          } else {
                            customSnackBar(
                                context, "floor_name_cannot_be_empty".tr);
                          }
                        },
                        title: "update_floor".tr);
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
                          floorCntrl.deleteFloorData(floorId: floorId!);
                        },
                        title:
                            "${'are_you_sure_permanent_remove'.tr} $buildingTitle");
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buildingTitle!.capitalize.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp - commonFontSize,
                            color: black),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            featureRentContainer(
                                isFeatured: isFeature, title: 'active'.tr),
                            featureRentContainer(
                                isFeatured: !isFeature!, title: 'inactive'.tr),
                            Padding(
                              padding: EdgeInsets.only(left: 60.w),
                              child: Text(
                                '$floor  ${'unit'.tr}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp - commonFontSize,
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
              fontSize: 12.sp - commonFontSize, color: black, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  updateFloorDetails({
    required String title,
    required String button1,
    required String button2,
    required Function() onButton1Tap,
    required Function() onButton2Tap,
  }) async {
    final floorCntrl = Get.find<FloorCntroller>();
    return await Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp - commonFontSize,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddPropertyWidget()
                              .commomText('floor_name'.tr, isMandatory: false),
                          customTextField(
                            controller: floorCntrl.updateFloorName.value,
                            textInputAction: TextInputAction.done,
                            hintText: '${'type_here'.tr}...',
                            isBorder: true,
                            isFilled: false,
                          ),
                          AddPropertyWidget().commomText('${'active'.tr}/${'inactive'.tr}',
                              isMandatory: false),
                          Obx(() {
                            return Switch(
                              value: floorCntrl.activeFloor.value,
                              onChanged: (value) {
                                floorCntrl.activeFloor.value = value;
                                floorCntrl.activeFloor.refresh();
                              },
                            );
                          })
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(
                            button1,
                            onButton1Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            width: 140.w,
                            borderColor: HexColor('#679BF1'),
                            textColor: HexColor('#679BF1'),
                          ),
                          customBorderButton(
                            button2,
                            onButton2Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  addFloor({
    required String title,
    required String button1,
    required String button2,
  }) async {
    final floorCntrl = Get.find<FloorCntroller>();

    TextEditingController floorName = TextEditingController();
    TextEditingController floorUnits = TextEditingController();
    return await Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp - commonFontSize,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddPropertyWidget()
                              .commomText('floor_name'.tr, isMandatory: true),
                          customTextField(
                            controller: floorName,
                            textInputAction: TextInputAction.done,
                            hintText: '${'type_here'.tr}...',
                            isBorder: true,
                            isFilled: false,
                          ),
                          AddPropertyWidget()
                              .commomText('units'.tr, isMandatory: true),
                          customTextField(
                            controller: floorUnits,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            hintText: '${'type_here'.tr}...',
                            isBorder: true,
                            isFilled: false,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(
                            button1,
                            () {
                              Get.back();
                            },
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            width: 140.w,
                            borderColor: HexColor('#679BF1'),
                            textColor: HexColor('#679BF1'),
                          ),
                          customBorderButton(
                            button2,
                            () {
                              if (floorName.text.trim().isNotEmpty) {
                                if (floorUnits.text.trim().isNotEmpty) {
                                  Get.back();
                                  floorCntrl.addFloorData(
                                      floorName: floorName.text.trim(),
                                      units: int.parse(floorUnits.text));
                                } else {
                                  customSnackBar(Get.context!,
                                      "floor_unit_cannot_be_empty".tr);
                                }
                              } else {
                                customSnackBar(Get.context!,
                                    "floor_name_cannot_be_empty".tr);
                              }
                            },
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
