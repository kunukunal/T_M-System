import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_building_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_building_widget.dart';

import '../../../../../common/widgets.dart';

class AddBuildingView extends StatelessWidget {
   AddBuildingView({super.key});
  final addBuildingCntrl =Get.put(AddBuildingCntroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AddBuildingWidgets().appBar(),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Expanded(
          child: ListView(children: [
            AddBuildingWidgets().commomText('Property',isMandatory: true),
            bigDropDown(selectedItem: addBuildingCntrl.selectedProperty.value,color:lightBorderGrey , items: addBuildingCntrl.propertyList.value, onChange: (item){
              addBuildingCntrl.selectedProperty.value=item;
            }),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.h),
              child: Text('Building Details',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp,color:black),),
            ),
            Divider(color: lightBorderGrey,height: 1.h,),
            ListView.builder(
                shrinkWrap: true,
                itemCount:2,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AddBuildingWidgets().addBuildingContainer(''

                  );}),
            Padding(
              padding:  EdgeInsets.only(top: 0.h,bottom: 5.h),
              child: Row(
                children: [
                  GestureDetector
                    (onTap: (){
                    addBuildingCntrl.onAmenitiesTap();
                  },
                      child
                          :addIcon),
                  SizedBox(width: 10.w,),
                  Text('Add New Building',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: black),),

                ],
              ),

            ),

          ],),
        ),
            customButton(
                onPressed: () {
                    Get.back();
                },
                text: 'Save',
                width: Get.width,
                verticalPadding: 10.h),
        ],),
      ),
    );
  }
}
