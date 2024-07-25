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
    return Scaffold(
      appBar: PropertyDetailWidget().appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText(title: 'Buildings'),
            Obx(() {
              return Expanded(
                child: navBarManagementCntrl
                        .isPropertyBuildingStatsLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : navBarManagementCntrl.items.isEmpty
                        ? const Center(
                            child: Text("No Building data Found"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: navBarManagementCntrl.items.length,
                            itemBuilder: (context, index) {
                              return PropertyDetailWidget().propertyList(
                                index:index,
                                  propertyTitle: navBarManagementCntrl
                                      .items[index]['name'],
                                  propertyDec: navBarManagementCntrl
                                      .items[index]['address'],
                                  unitsAvailable: navBarManagementCntrl
                                      .items[index]['available_units'],
                                  totalUnits: navBarManagementCntrl.items[index]
                                      ['total_units'],
                                  unitsOccupied: navBarManagementCntrl
                                      .items[index]['occupied_units'],
                                  floor: navBarManagementCntrl.items[index]
                                      ['floors']);
                            },
                          ),
              );
            })
          ],
        ),
      ),
    );
  }
}
