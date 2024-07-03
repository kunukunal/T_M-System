import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/property/property_list/property_list_controller.dart';
import 'package:tanent_management/screens/dashboard/property/property_list/property_list_widgets.dart';

class PropertyListView extends StatelessWidget {

   PropertyListView({super.key});
  final propertyCntrl = Get.put(PropertyListController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PropertyWidget().appBar(),
      body:  Column(children: [
        Divider(
          color: lightBorderGrey,
          height: 1.h,
        ),
      Expanded(
        child: Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:propertyCntrl.propertyList.value.length,
              itemBuilder: (context, index) {
              return PropertyWidget().unitList(
              propertyTitle: propertyCntrl.propertyList.value[index]['propertyTitle'] as String,
              location:  propertyCntrl.propertyList.value[index]['location'] as String,
              icon:  propertyCntrl.propertyList.value[index]['icon'] as String,
              buildingIcon:  propertyCntrl.propertyList.value[index]['buildingIcon'] as String,
              isFeature:  propertyCntrl.propertyList.value[index]['isFeatured'] as bool
              );}),
        ),
      )
      ],),
    );
  }
}
