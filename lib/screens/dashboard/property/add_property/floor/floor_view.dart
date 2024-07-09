import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_widget.dart';

class FloorView extends StatelessWidget {
  FloorView({super.key});
  final floorCntrl = Get.put(FloorCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloorWidget().appBar(floorCntrl.buildingName.value),
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: floorCntrl.isFloorDataLoaded.value == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : floorCntrl.floorList.isEmpty
                      ? const Center(
                          child: Text("No Floor available"),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: floorCntrl.floorList.length,
                              itemBuilder: (context, index) {
                                return FloorWidget().floorList(
                                  floorId: floorCntrl.floorList[index]
                                        ['id'] ,
                                    buildingTitle: floorCntrl.floorList[index]
                                        ['name'],
                                    floor: floorCntrl.floorList[index]
                                            ['number_of_units']
                                        ,
                                    isFeature: floorCntrl.floorList[index]
                                        ['is_active']);
                              }),
                        ),
            );
          }),
        ],
      ),
    );
  }
}
