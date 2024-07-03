import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_controller.dart';

import '../../../common/text_styles.dart';

class AddExpenseWidgets{
  //Date picker
  datePickerContainer(){
    final addExCntrl = Get.find<AddExpenseController>();
    return InkWell(
      onTap: ()async{
        addExCntrl.selectDate(Get.context!);
        // DatePickerDialog(firstDate: DateTime.now(),lastDate: DateTime.now(),);
      // await  Future.delayed(const Duration(seconds: 1)).then((value) => DayPicker.single(selectedDate: DateTime.now(), onChanged: (date){}, firstDate: DateTime.now(), lastDate: DateTime.now()));
      },
      child: Container(
        height: 44.h,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r)
            ,border: Border.all(color: HexColor('#EBEBEB'),width: 2)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(addExCntrl.date.value==null?'Select':'${addExCntrl.date.value!.day}-${addExCntrl.date.value!.month}-${addExCntrl.date.value!.year} ',style:  CustomStyles.hintText,),
              dateIcon
            ],
          ),
        ),
      ),
    );
  }

  //Payment Type Radio Button
  radioButtons(){
    final addExCntrl = Get.find<AddExpenseController>();
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding:  const EdgeInsets.only(left: 8.0),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: addExCntrl.paymentTypeList.value.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 24 .h,mainAxisSpacing: 15.h,crossAxisSpacing: 10.w),
            itemBuilder: (context,index){

          return InkWell(
            onTap: (){
              addExCntrl.onPaymentTypeTap(index);
            },
            child: Row(
              children: [
                addExCntrl.paymentTypeList.value[index]['isSelected']?  selectedCheckboxIcon:checkboxIcon,
                SizedBox(width: 10.w,),
                 Text(addExCntrl.paymentTypeList.value[index]['name'],style:addExCntrl.paymentTypeList.value[index]['isSelected']?  CustomStyles.otpStyle050505W400S14.copyWith(fontSize: 16.sp):CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),)

              ],
            ),
          );
        }),
      ),
    );
  }

  filePickerContainer(){
    final addExCntrl = Get.find<AddExpenseController>();
    return Column(
      children: [
        InkWell(
        onTap: ()async{
          addExCntrl.getImages();
       },
          child: Container(
            height: 44.h,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r)
                ,border: Border.all(color: HexColor('#EBEBEB'),width: 2)
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload',style:  CustomStyles.hintText,),
                  attachIcon
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        addExCntrl.selectedImages.isEmpty?SizedBox():  SizedBox(
          height: 40.h,
          child: ListView.separated(
            separatorBuilder: (context, index){
              return SizedBox(width: 10.w,);
            },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Container(
                  height: 36.h,
                  // width: 137.w,
                  decoration: BoxDecoration(
                      color: HexColor('#D9E3F4'),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: HexColor('#EBEBEB'))
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(5.r),
                    child: Row(
                      children: [
                        Text(addExCntrl.selectedImages[index].name,style: CustomStyles.black16.copyWith(fontWeight: FontWeight.w400),)
                        ,
                        SizedBox(width: 5.w,),
                        crossIcon
                      ],
                    ),
                  ),
                );
              }, itemCount: addExCntrl.selectedImages.length,),
        ),
      ],
    );

  }
}