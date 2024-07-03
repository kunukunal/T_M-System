import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
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
        preferredSize: Size.fromHeight(1),
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

  addBuildingContainer(
    String title,
  ) {
    final addBuildingCntrl =Get.find<AddBuildingCntroller>();
    return Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightBorderGrey),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 280.h,
              width: 309.w,
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commomText('Building Name',isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: 'Type Here...                                  Sq.ft',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,



                    ),
                    commomText('No. of Floors ',isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: 'Type Here...                                  Sq.ft',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,



                    ),
                    commomText('No. of Units',isMandatory: true),
                    customTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      hintText: 'Type Here...                                  Sq.ft',
                      isBorder: true,
                      // color: HexColor('#F7F7F7'),
                      isFilled: false,



                    ),
                    GestureDetector(
                      onTap: (){
                        addBuildingCntrl.onAmenitiesTap();
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(top: 8.h,bottom: 8.h),
                        child: Row(
                          children: [
                            GestureDetector
                              (onTap: (){

                            },
                                child
                                    :addIcon),
                            SizedBox(width: 10.w,),
                            GestureDetector(
                              onTap: (){

                              },
                                child: Text('Add Amenities(s)',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: black),)),


                          ],
                        ),

                      ),
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
