import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_widgets.dart';

class UnitView extends StatelessWidget {
  UnitView({super.key});
  final unitCntrl = Get.put(UnitCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnitWidget().appBar('${unitCntrl.buildingName.value.capitalize}-${unitCntrl.floorName.value}'),
      body: WillPopScope(
        onWillPop: () async {
          print("ffkalskfsad ${unitCntrl.isBackNeeded.value}");
          Get.back(result: unitCntrl.isBackNeeded.value);
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Obx(() {
                  return unitCntrl.isUnitLoaded.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : unitCntrl.unitList.isEmpty
                          ? const Center(
                              child: Text('No Data Found'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: unitCntrl.unitList.length,
                              itemBuilder: (context, index) {
                                return UnitWidget().unitList(
                                    unitId: unitCntrl.unitList[index]['id'],
                                    index: index,
                                    floorName: unitCntrl.unitList[index]
                                        ['name'],
                                    isOccupied: unitCntrl.unitList[index]
                                        ['is_occupied']);
                              });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
