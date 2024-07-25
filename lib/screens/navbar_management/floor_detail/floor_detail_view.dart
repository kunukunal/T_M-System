import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_controller.dart';
import 'package:tanent_management/screens/navbar_management/floor_detail/floor_detail_widget.dart';

class FloorDetailView extends StatelessWidget {
  FloorDetailView({super.key});
  final floorDetailCntrl = Get.put(FloorDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: floorDetailCntrl.propertyFloorName.value),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
              child: commonText(title: 'Units')),
          Obx(() {
            return Expanded(
              child: floorDetailCntrl.isUnitsStatsLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : floorDetailCntrl.items.isEmpty
                      ? const Center(
                          child: Text("No units found"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: floorDetailCntrl.items.length,
                          itemBuilder: (context, index) {
                            return FloorDetailWidget().unitList(
                              index:index,
                                unitTitle: floorDetailCntrl.items[index]
                                    ['name'],
                                price: floorDetailCntrl.items[index]
                                    ['unit_rent'],
                                tenantName: floorDetailCntrl.items[index]
                                    ['tenant'],
                                availablityTitle: floorDetailCntrl.items[index]
                                    ['last_occupied_date'],
                                icon: 'assets/icons/homeIcon.png',
                                buildingIcon: floorDetailCntrl
                                        .items[index]['images'].isNotEmpty
                                    ? floorDetailCntrl.items[index]['images'][0]
                                        ['image_url']
                                    : null,
                                amenities: floorDetailCntrl.items[index]
                                    ['amenities'],
                    
                                unitId: floorDetailCntrl.items[index]['id'],
                                isOccupied: floorDetailCntrl.items[index]
                                    ['is_occupied']);
                          },
                        ),
            );
          })
        ],
      ),
    );
  }
}
