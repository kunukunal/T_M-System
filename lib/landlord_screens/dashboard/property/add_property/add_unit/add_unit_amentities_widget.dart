import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets.dart';

class AddUnitAmenitiesWidget {
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
                        fontSize: 16.sp - commonFontSize)),
                Text('*',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: HexColor('#EF5E4E'),
                        fontSize: 16.sp - commonFontSize)),
              ],
            )
          : Text(title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor('#111111'),
                  fontSize: 16.sp - commonFontSize)),
    );
  }

  addAmenitiesContainer(
      {required dynamic amenitiesElement, required VoidCallback onCancelTap}) {
    return Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightBorderGrey),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 170.h,
              width: 309.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commomText('amenities'.tr, isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      controller: amenitiesElement['amenity_name']
                          as TextEditingController,
                      hintText: 'drinking_water'.tr,
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,
                    ),
                    commomText('amount'.tr, isMandatory: true),
                    customTextField(
                      controller:
                          amenitiesElement['ammount'] as TextEditingController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: '₹ 1,00,000',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(onTap: onCancelTap, child: crossIcon)
          ],
        ));
  }
}
