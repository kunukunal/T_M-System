import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_controller.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';

class PropertyDetailWidget{
appBar(){
  return  AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: InkWell(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: backArrowImage,
      ),
    ),
    title: Text('Property A', style: CustomStyles.otpStyle050505W700S16),

    bottom:  PreferredSize(
      preferredSize: Size.fromHeight(1.h),
      child: Divider(height: 1,color: lightBorderGrey,),
    ),
  );
}

propertyList(

    {
      String? propertyTitle,
      String? propertyDec,
      String? unitsAvailable,
      String? unitsOccupied,


    }) {
  final propertyCntrl = Get.find<PropertyDetailCntroller>();


  return GestureDetector(
    onTap: (){
      propertyCntrl.onBuildingTap();
    },
    child: Obx(
      () {
        return Padding(
          padding: EdgeInsets.only(left: 0.h, right: 0.w, bottom: 5.h,top: 10.h),
          child: Container(
            height:  propertyCntrl.isExpand.value?210.h: 120.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightBorderGrey)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                          child: Center(child: Text('A')),
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
                                    'Property $propertyTitle',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                        color: black),
                                  ),
                                ),
                              Obx(
                                () {
                                  return GestureDetector(
                                      onTap: (){
                                        propertyCntrl.isExpand.value=! propertyCntrl.isExpand.value;
                                      },
                                      child:  propertyCntrl.isExpand.value?upArrow: dropDownArrowIcon);
                                }
                              )


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
                                  fontSize: 13.sp,
                                  color: grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 5.h),
                  child: Row(

                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          availableIcon,
                          Padding(
                            padding:  EdgeInsets.only(left: 5.w),
                            child: Text(
                              unitsAvailable!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          occupiedIcon2,
                          Padding(
                            padding:  EdgeInsets.only(left: 5.w),

                            child: Text(
                              unitsOccupied!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: black),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                propertyCntrl.isExpand.value? Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical:
                  5.h),
                  child: Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                ):SizedBox(),
                propertyCntrl.isExpand.value?      Expanded(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: ListView.builder(
          shrinkWrap: true,
            itemCount:propertyCntrl.floorList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 5.h),
                    child: Row(children: [
                      Text("Floor  ${propertyCntrl.floorList[index]['floorTitle']}",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: black),),
                     Spacer(),
                      Text(propertyCntrl.floorList[index]['floorrate'],style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: lightBlue)),

                    ],),
                  ),
                  Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                ],
              );
            },

          ),
        ),):SizedBox()
              ],
            ),
          ),
        );
      }
    ),
  );
}
}