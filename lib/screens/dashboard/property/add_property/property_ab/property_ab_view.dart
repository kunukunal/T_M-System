import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_widgets.dart';

class PropertyAb extends StatelessWidget {
   PropertyAb({super.key});
  final propertyAbCntrl = Get.put(PropertyAbCntroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PropertyAbWidget().appBar(),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:propertyAbCntrl.propertyList.value.length,
                itemBuilder: (context, index) {
                  return PropertyAbWidget().propertyList(
                      buildingTitle: propertyAbCntrl.propertyList.value[index]['buildingTitle'] as String,
                      floor:  propertyAbCntrl.propertyList.value[index]['floor'] as String,

                      isFeature:  propertyAbCntrl.propertyList.value[index]['isFeatured'] as bool
                  );}),
          ),
        ],
      ),
    );
  }
}
