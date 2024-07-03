import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_widget.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets.dart';

class AddUnitView extends StatelessWidget {
   AddUnitView({super.key});
final addUnitCntrl = Get.put(AddUnitController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AddUnitWidget().appBar() ,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Expanded
            (
            child
                : ListView(children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.h),
                child: Text('Unit Details',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp,color:black),),
              ),
              Divider(color: lightBorderGrey,height: 1.h,),

              AddUnitWidget().commomText('Unit Name',isMandatory: true),
              customTextField(
                controller: addUnitCntrl.unitNameCntrl.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                hintText: 'Flat 101',
                isBorder: true,
                // color: HexColor('#F7F7F7'),
                isFilled: false,



              ),
              AddUnitWidget().commomText('Unit Type',),
              bigDropDown(selectedItem: addUnitCntrl.selectedUnitType.value,color:whiteColor , items: addUnitCntrl.unitType.value, onChange: (item){
                addUnitCntrl.selectedUnitType.value=item;
              }),
              AddUnitWidget().commomText('Unit Features',),
              bigDropDown(selectedItem: addUnitCntrl.selectedUnitFeature.value,color:whiteColor , items: addUnitCntrl.unitFeature.value, onChange: (item){
                addUnitCntrl.selectedUnitFeature.value=item;
              }),
              AddUnitWidget().commomText('Unit Rent',),
              bigDropDown(selectedItem: addUnitCntrl.selectedUnitRent.value,color:whiteColor , items: addUnitCntrl.unitRent.value, onChange: (item){
                addUnitCntrl.selectedUnitRent.value=item;
              }),
              Obx(
                      () {
                    return Padding(
                      padding:  EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          GestureDetector
                            (onTap: (){
                            addUnitCntrl.isSelected.value=! addUnitCntrl.isSelected.value;
                          },
                              child
                                  :addUnitCntrl.isSelected.value?selectedCheckboxIcon: checkboxIcon),
                          SizedBox(width: 10.w,),
                          Text('Is Rent Negotiable',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: black),),

                        ],
                      ),
                    );
                  }
              ),
              AddUnitWidget().commomText('Area Size',),
              customTextField(
                controller: addUnitCntrl.areaSizeCntrl.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                hintText: 'Type Here...                                  Sq.ft',
                isBorder: true,
                // color: HexColor('#F7F7F7'),
                isFilled: false,



              ),
              AddUnitWidget().commomText('Note',),
              customTextField(
                controller: addUnitCntrl.noteCntrl.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                hintText: 'Type Here...',
                isBorder: true,
                maxLines: 3,
                // color: HexColor('#F7F7F7'),
                isFilled: false,



              ),

              Padding(
                padding:  EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    GestureDetector
                      (onTap: (){

                    },
                        child
                            :addIcon),
                    SizedBox(width: 10.w,),
                    Text('Add Amenities(s)',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: black),),

                  ],
                ),

              ),
              AddUnitWidget().commomText('Upload Picture/Video',),
              uploadPicture,



            ],),
          ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customBorderButton('Previous', () {

                  },
                      verticalPadding: 10.h,
                      horizontalPadding: 2.w,
                      btnHeight: 40.h,
                      width: Get.width / 2.3,
                      borderColor: HexColor('#679BF1'),
                      textColor: HexColor('#679BF1')),
                  customBorderButton('Save', () {

                  },
                      verticalPadding: 10.h,
                      horizontalPadding: 2.w,
                      btnHeight: 40.h,
                      width: Get.width / 2.3,
                      color: HexColor('#679BF1'),
                      textColor: HexColor('#FFFFFF'),
                      borderColor: Colors.transparent)
                ],
              )
            ],)
          ],),
      ),
    );
  }
}
