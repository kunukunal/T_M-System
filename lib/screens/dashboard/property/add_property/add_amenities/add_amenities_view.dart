import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_amenities/add_amentities_widget.dart';

import '../../../../../common/constants.dart';

class AddAmentiesView extends StatelessWidget {
  const AddAmentiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        appBar:appBar(title: 'Amenities'),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.h),
                    child: Text('Amenities Details',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp,color:black),),
                  ),
                  Divider(color: lightBorderGrey,height: 1.h,),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount:2,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AddAmenitiesWidget().addAmenitiesContainer(''

                        );}),
                  Padding(
                    padding:  EdgeInsets.only(top: 0.h,bottom: 5.h),
                    child: Row(
                      children: [
                        GestureDetector
                          (onTap: (){

                        },
                            child
                                :addIcon),
                        SizedBox(width: 10.w,),
                        Text('Add Amenities(s)',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: black),),

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
      ),
    );
  }
}
