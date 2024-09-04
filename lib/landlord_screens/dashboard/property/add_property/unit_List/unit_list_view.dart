import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_list_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_list_widgets.dart';

class UnitView extends StatelessWidget {
  UnitView({super.key});
  final unitCntrl = Get.put(UnitCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnitWidget().appBar('${unitCntrl.buildingName.value.capitalize}-${unitCntrl.floorName.value}'),
      floatingActionButton: Obx(() {
        return unitCntrl.unitList.isEmpty
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  unitCntrl.onAddTap();
                },
                backgroundColor: Colors.white,
                shape:
                    CircleBorder(side: BorderSide(color: HexColor('#EBEBEB'))),
                child: addIcon,
              );
      }),
      body: WillPopScope(
        onWillPop: () async {
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
                          ?  Center(
                              child: Text('no_data_found'.tr),
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
