import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/navbar_management/navbar_management_controller.dart';
import 'package:tanent_management/screens/navbar_management/navbar_management_widgets.dart';

import '../../common/constants.dart';

class NavbarManagementScreen extends StatelessWidget {
  NavbarManagementScreen({super.key});
  final navBarManagementCntrl = Get.put(NavBarManagementCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarManagementWidget().appBar(),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            navBarManagementCntrl.getPropertyManagementStats();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavBarManagementWidget().occUnoccContainer(
                          icon: occupiedIcon,
                          titleUnit: 'Occupied Units',
                          units: navBarManagementCntrl.totalOccupiedUnits.value
                              .toString()),
                      NavBarManagementWidget().occUnoccContainer(
                          icon: unOccupiedIcon,
                          titleUnit: 'Unoccupied Units',
                          units: navBarManagementCntrl
                              .totalUnOccupiedUnits.value
                              .toString()),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavBarManagementWidget().commonText(title: 'Property'),
                    //  Row(
                    //    children: [ NavBarManagementWidget().commonText(title: 'All Units'),
                    //    SizedBox(width: 10.w,),
                    //    filterIcon2],)
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return navBarManagementCntrl.isPropertyStatsLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : navBarManagementCntrl.items.isEmpty
                          ? const SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Text("No Property Found"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: navBarManagementCntrl.items.length,
                              itemBuilder: (context, index) {
                                return NavBarManagementWidget().propertyList(
                                  id: navBarManagementCntrl.items[index]['id'],
                                  propertyTitle: navBarManagementCntrl
                                      .items[index]['title'],
                                  propertyDec: navBarManagementCntrl
                                      .items[index]['address'],
                                  unitsAvailable: navBarManagementCntrl
                                      .items[index]['available_units'],
                                  totalUnit: navBarManagementCntrl.items[index]
                                      ['total_units'],
                                  unitsOccupied: navBarManagementCntrl
                                      .items[index]['occupied_units'],
                                );
                              },
                            );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
