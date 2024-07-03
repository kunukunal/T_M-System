import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_widget.dart';

class PropertyDetailView extends StatelessWidget {
   PropertyDetailView({super.key});
  final navBarManagementCntrl = Get.put(PropertyDetailCntroller());


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: PropertyDetailWidget().appBar(),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          commonText(title: 'Buildings'),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:navBarManagementCntrl.items.length,
              itemBuilder: (context, index) {
                return PropertyDetailWidget().propertyList(
                  propertyTitle: navBarManagementCntrl.items[index]['propTitle'],
                  propertyDec: navBarManagementCntrl.items[index]['propDesc'],
                  unitsAvailable : navBarManagementCntrl.items[index]['availablityTitle'],
                  unitsOccupied: navBarManagementCntrl.items[index]['occupiedTitle'],
                );
              },

            ),
          )

        ],),
      ),
    ));
  }
}
