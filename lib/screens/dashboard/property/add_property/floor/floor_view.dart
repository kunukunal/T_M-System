import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_widget.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_widgets.dart';

class FloorView extends StatelessWidget {
  FloorView({super.key});
  final floorCntrl = Get.put(FloorCntroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: FloorWidget().appBar(),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:floorCntrl.floorList.value.length,
                itemBuilder: (context, index) {
                  return FloorWidget().floorList(
                      buildingTitle: floorCntrl.floorList.value[index]['buildingTitle'] as String,
                      floor:  floorCntrl.floorList.value[index]['floor'] as String,

                      isFeature:  floorCntrl.floorList.value[index]['isFeatured'] as bool
                  );}),
          ),
        ],
      ),
    );
  }
}
