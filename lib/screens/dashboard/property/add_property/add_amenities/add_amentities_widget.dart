import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';
import '../../../../../common/widgets.dart';

class AddAmenitiesWidget{

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

  addAmenitiesContainer(
      String title,
      ) {

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
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commomText('Amenities',isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: 'Drinking Water',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,



                    ),
                    commomText('Amount',isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: '\u0024 1,00,000',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,



                    ),


                  ],
                ),
              ),
            ),
            crossIcon
          ],
        ));
  }
}