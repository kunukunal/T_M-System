import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_widget.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_widgets.dart';

class UnitView extends StatelessWidget {
  UnitView({super.key});
  final unitCntrl = Get.put(UnitCntroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: UnitWidget().appBar(),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:unitCntrl.unitList.value.length,
                itemBuilder: (context, index) {
                  return UnitWidget().unitList(
                      buildingTitle: unitCntrl.unitList.value[index]['buildingTitle'] as String,
                      floor:  unitCntrl.unitList.value[index]['floor'] as String,

                      isOccupied:  unitCntrl.unitList.value[index]['isOccupied'] as bool
                  );}),
          ),
        ],
      ),
    );
  }
}
