import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/navbar_management/navbar_management_controller.dart';
import 'package:tanent_management/landlord_screens/navbar_management/navbar_management_widgets.dart';

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: customTextField(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: searchIcon,
                    ),
                    hintStyle: CustomStyles.hintText,
                    hintText: 'search_management'.tr,
                    controller:
                        navBarManagementCntrl.managmentSearchController.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) {
                      navBarManagementCntrl.items.refresh();
                    },
                    isBorder: true,
                    isFilled: false),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavBarManagementWidget().occUnoccContainer(
                          icon: occupiedIcon,
                          titleUnit: 'occupied_units'.tr,
                          units: navBarManagementCntrl.totalOccupiedUnits.value
                              .toString()),
                      NavBarManagementWidget().occUnoccContainer(
                          icon: unOccupiedIcon,
                          titleUnit: 'unoccupied_units'.tr,
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
                    NavBarManagementWidget().commonText(title: 'property'.tr),
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
                          ?  SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Center(child: Text("no_property_found".tr)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: navBarManagementCntrl.items.length,
                              itemBuilder: (context, index) {
                                String tenantName = (navBarManagementCntrl
                                            .items[index]['title'] ??
                                        "")
                                    .toString()
                                    .trim();
                                String searchQuery = navBarManagementCntrl
                                    .managmentSearchController.value.text
                                    .trim()
                                    .toLowerCase();
                                if (tenantName
                                    .toLowerCase()
                                    .contains(searchQuery)) {
                                  return NavBarManagementWidget().propertyList(
                                    id: navBarManagementCntrl.items[index]
                                        ['id'],
                                    propertyTitle: navBarManagementCntrl
                                        .items[index]['title'],
                                    propertyDec: navBarManagementCntrl
                                        .items[index]['address'],
                                    unitsAvailable: navBarManagementCntrl
                                        .items[index]['available_units'],
                                    totalUnit: navBarManagementCntrl
                                        .items[index]['total_units'],
                                    unitsOccupied: navBarManagementCntrl
                                        .items[index]['occupied_units'],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
