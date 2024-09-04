import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tanent_management/landlord_screens/navbar_management/property_detail/property_detail_controller.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class PropertyDetailWidget {
  final propertyCntrl = Get.find<PropertyDetailCntroller>();

  appBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          Get.back(result: propertyCntrl.isRefreshmentRequired.value);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      title: Text('${propertyCntrl.propertTitle}',
          style: CustomStyles.otpStyle050505W700S16),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Divider(
          height: 1,
          color: lightBorderGrey,
        ),
      ),
    );
  }

  propertyList({
    int? index,
    String? propertyTitle,
    String? propertyDec,
    int? unitsAvailable,
    int? unitsOccupied,
    int? totalUnits,
    List? floor,
  }) {
    final propertyCntrl = Get.find<PropertyDetailCntroller>();

    return GestureDetector(
      onTap: () {},
      child: Obx(() {
        return Padding(
          padding:
              EdgeInsets.only(left: 0.h, right: 0.w, bottom: 5.h, top: 10.h),
          child: Container(
            height: propertyCntrl.selectedIndex.value == index &&
                    propertyCntrl.isExpand.value
                ? 210.h
                : 120.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightBorderGrey)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    propertyCntrl.isExpand.value =
                        !propertyCntrl.isExpand.value;
                    propertyCntrl.selectedIndex.value = index!;
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      propertyTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp - commonFontSize,
                                          color: black),
                                    ),
                                  ),
                                  Obx(() {
                                    return propertyCntrl.selectedIndex.value ==
                                                index &&
                                            propertyCntrl.isExpand.value
                                        ? upArrow
                                        : dropDownArrowIcon;
                                  })
                                ],
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 12.0,
                            lineWidth: 4.0,
                            percent: unitsAvailable! / totalUnits!,
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
                            percent: unitsOccupied! / totalUnits,
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
                propertyCntrl.selectedIndex.value == index &&
                        propertyCntrl.isExpand.value
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Divider(
                          color: HexColor('#EBEBEB'),
                          height: 1.h,
                        ),
                      )
                    : const SizedBox(),
                propertyCntrl.selectedIndex.value == index &&
                        propertyCntrl.isExpand.value
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: floor!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  propertyCntrl.onBuildingTap(
                                      floor[index]['id'],
                                      "$propertyTitle - " +
                                          floor[index]['name']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${floor[index]['name']}",
                                              style: TextStyle(
                                                  fontSize: 14.sp - commonFontSize,
                                                  fontWeight: FontWeight.w700,
                                                  color: black),
                                            ),
                                            // const Spacer(),
                                            Text(
                                                "${floor[index]['available_units']}/${floor[index]['total_units']}",
                                                style: TextStyle(
                                                    fontSize: 14.sp - commonFontSize,
                                                    fontWeight: FontWeight.w500,
                                                    color: lightBlue)),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: HexColor('#EBEBEB'),
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      }),
    );
  }
}
