import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/property/property_list/property_list_controller.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';

class PropertyWidget{

  appBar() {
    final propertyCntrl = Get.find<PropertyListController>();

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
      title: Text('Property List', style: CustomStyles.otpStyle050505W700S16),
      actions: [
        InkWell(
            onTap: (){
              propertyCntrl.onAddTap();
            },
            child: Padding(
              padding:  EdgeInsets.all(8.r),
              child: addIcon,
            )),


      ],
    );
  }

  unitList(
      {
        String? propertyTitle,
        String? location,
        String? icon,
        String? buildingIcon,
        bool? isFeature,
      }) {
    final propertyCntrl = Get.find<PropertyListController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
propertyCntrl.onItemTap();
        },
        child: Container(
          height: 114.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 94.h,
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        propertyTitle!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: black),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        children: [
                            featureRentContainer(isFeatured: true,title: 'Featured'),
                            featureRentContainer(isFeatured: false,title: 'For Rent'),
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
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Text(
                              location!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: black),
                            ),
                          ),
                  
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  featureRentContainer({bool? isFeatured,String? title}){
    return Padding(
      padding:  EdgeInsets.only(right: 10.w),
      child: Container(
        height: 25.h,
        width: 90.w,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color:isFeatured!? lightBlue:lightBorderGrey  )
        ),
        child: Center(child: Text(title!,style: TextStyle(fontSize: 12.sp,color: black,fontWeight: FontWeight.w500),)),
      ),
    );
  }
}