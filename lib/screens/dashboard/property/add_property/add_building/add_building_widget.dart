import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_building_controller.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';
import '../../../../../common/widgets.dart';

class AddBuildingWidgets {
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
      title: Text('Add Building', style: CustomStyles.otpStyle050505W700S16),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: lightBorderGrey,
        ),
      ),
    );
  }

  commomText(String title, {bool? isMandatory = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: isMandatory!
          ? Row(
              children: [
                Text(title,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#111111'),
                        fontSize: 16.sp)),
                Text('*',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#EF5E4E'),
                        fontSize: 16.sp)),
              ],
            )
          : Text(title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor('#111111'),
                  fontSize: 16.sp)),
    );
  }

  addBuildingContainer({
    required int index,
  }) {
    final addBuildingCntrl = Get.find<AddBuildingCntroller>();
    return Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightBorderGrey),
                borderRadius: BorderRadius.circular(10.r),
              ),
              width: 309.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commomText('Building Name', isMandatory: true),
                    customTextField(
                      controller: addBuildingCntrl.addMultipleBuilding[index]
                          ['building_name'] as TextEditingController,
                      textInputAction: TextInputAction.done,
                      // keyboardType: TextInputType.number,

                      hintText: 'Type Here...',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,
                    ),
                    commomText('No. of Floors ', isMandatory: true),
                    customTextField(
                      controller: addBuildingCntrl.addMultipleBuilding[index]
                          ['floor'] as TextEditingController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      hintText: 'Type Here...',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,
                    ),
                    commomText('No. of Units', isMandatory: true),
                    customTextField(
                      controller: addBuildingCntrl.addMultipleBuilding[index]
                          ['units'] as TextEditingController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      hintText: 'Type Here...',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              children: List.generate(
                                  (addBuildingCntrl.addMultipleBuilding[index]
                                          ['amenities'] as List)
                                      .length, (ind) {
                                return Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: HexColor("#D9E3F4"),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          (addBuildingCntrl.addMultipleBuilding[
                                                      index]['amenities']
                                                  as List)[ind]['amenity_name']
                                              .text,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            (addBuildingCntrl
                                                        .addMultipleBuilding[
                                                    index]['amenities'] as List)
                                                .removeAt(ind);
                                            addBuildingCntrl.addMultipleBuilding
                                                .refresh();
                                          },
                                          child: crossIcon),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      );
                    }),
                    GestureDetector(
                      onTap: () {
                        addBuildingCntrl.onAmenitiesTap(index: index);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: Row(
                          children: [
                            addIcon,
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Add Amenities(s)',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  addBuildingCntrl.addMultipleBuilding.removeAt(index);
                },
                child: crossIcon)
          ],
        ));
  }
}
