import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import 'management_controller.dart';

class ManagementWidgets{
  //Date picker
  datePickerContainer(String date,{double? width, required Function() onTap}){
    final addExCntrl = Get.find<ManagementController>();
    return InkWell(
      onTap:onTap,
      child: Container(
        height: 44.h,
        width: width?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r)
            ,border: Border.all(color: HexColor('#EBEBEB'),width: 2)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date,style:  CustomStyles.hintText,),
              dateIcon
            ],
          ),
        ),
      ),
    );
  }

  //Amenities list
  amenitiesList(){
    final manageCntrl = Get.find<ManagementController>();

    return  Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: manageCntrl.amenitiesList.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 24 .h,mainAxisSpacing: 10.h,crossAxisSpacing: 5.w),
          itemBuilder: (context,index){

            return InkWell(
              onTap: (){
                manageCntrl.onPaymentTypeTap(index);
              },
              child: Row(
                children: [
                  manageCntrl.amenitiesList.value[index]['isSelected']?  selectedCheckboxIcon:checkboxIcon,
                  SizedBox(width: 10.w,),
                  Text('${manageCntrl.amenitiesList.value[index]['name']} - ',style:manageCntrl.amenitiesList.value[index]['isSelected']?  CustomStyles.otpStyle050505W400S14.copyWith(fontSize: 14.sp):CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans',fontSize: 14.sp),),
                  InkWell(
                      onTap: (){
                        priceEditingPopup();
                      },
                      child: Text('${manageCntrl.amenitiesList.value[index]['amount']}',style:manageCntrl.amenitiesList.value[index]['isSelected']?  CustomStyles.otpStyle050505W400S14.copyWith(fontSize: 14.sp,decoration: TextDecoration.underline):CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans',fontSize: 14.sp,decoration: TextDecoration.underline),))

                ],
              ),
            );
          }),
    );
  }

  priceEditingPopup(){
    return Get.dialog(Padding(
      padding:  EdgeInsets.symmetric(vertical: 250.h,horizontal: 50.w),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),

        ),
        // child: ,
      ),
    ),

    );
  }
}