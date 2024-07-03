import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_widget.dart';

import '../../../common/constants.dart';

class FloorDetailView extends StatelessWidget {
   FloorDetailView({super.key});
  final floorDetailCntrl =Get.put(FloorDetailController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: appBar(title: 'Building A - Floor 1'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding:  EdgeInsets.only(left: 10.w,bottom: 10.h,top: 10.h),

          child: commonText(title: 'Units')
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:floorDetailCntrl.items.value.length,
            itemBuilder: (context, index) {
              return FloorDetailWidget().unitList(
                  unitTitle: floorDetailCntrl.items.value[index]['unitTitle'] as String,
                  price: floorDetailCntrl.items.value[index]['price'] as String,
                  availablityTitle: floorDetailCntrl.items.value[index]['availablityTitle'] as String,
                  icon: floorDetailCntrl.items.value[index]['icon'] as String,
                  buildingIcon: floorDetailCntrl.items.value[index]['buildingIcon'] as String,
                  property: floorDetailCntrl.items.value[index]['property'] as String,
                  building: floorDetailCntrl.items.value[index]['building'] as String,
                  floor: floorDetailCntrl.items.value[index]['floor'] as String,
                  isOccupied: floorDetailCntrl.items.value[index]['isOccupied'] as bool
              );
            },

          ),
        )
      ],),
    ));

  }
}
