import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/navbar_management/navbar_management_controller.dart';
import 'package:tanent_management/screens/navbar_management/navbar_management_widgets.dart';

import '../../common/constants.dart';
import '../../common/text_styles.dart';

class NavbarManagementScreen extends StatelessWidget {
   NavbarManagementScreen({super.key});
  final navBarManagementCntrl = Get.put(NavBarManagementCntroller());


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: NavBarManagementWidget().appBar(),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
          NavBarManagementWidget().occUnoccContainer(
              icon: occupiedIcon,
              titleUnit: 'Occupied Units',
              units: '300'),
          NavBarManagementWidget().occUnoccContainer(
              icon: unOccupiedIcon,
              titleUnit: 'Unoccupied Units',
              units: '200'),
        ],),
      ),
        Padding(
          padding:   EdgeInsets.symmetric(horizontal: 10.w),

      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            NavBarManagementWidget().commonText(title: 'Property'),
           Row(
             children: [ NavBarManagementWidget().commonText(title: 'All Units'),
             SizedBox(width: 10.w,),
             filterIcon2],)
          ],),
        )
          ,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:navBarManagementCntrl.items.length,
              itemBuilder: (context, index) {
                return NavBarManagementWidget().propertyList(
                    propertyTitle: navBarManagementCntrl.items[index]['propTitle'],
                    propertyDec: navBarManagementCntrl.items[index]['propDesc'] ,
                   unitsAvailable : navBarManagementCntrl.items[index]['availablityTitle'],
                    unitsOccupied: navBarManagementCntrl.items[index]['occupiedTitle'],



                );
              },

            ),
          )

      ],),
    ));
  }
}
