import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/property_ab/property_ab_widgets.dart';

class PropertyAb extends StatelessWidget {
  PropertyAb({
    super.key,
  });

  final propertyAbCntrl = Get.put(PropertyAbCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PropertyAbWidget().appBar(propertyAbCntrl.propertyName.value),
      floatingActionButton: Obx(() {
        return propertyAbCntrl.buildingList.isEmpty
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  propertyAbCntrl.onAddTap();
                },
                backgroundColor: Colors.white,
                shape:
                    CircleBorder(side: BorderSide(color: HexColor('#EBEBEB'))),
                child: addIcon,
              );
      }),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: propertyAbCntrl.isBuildingDataListLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : propertyAbCntrl.buildingList.isEmpty
                        ?  Center(
                            child: Text("no_building_data_found".tr),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: propertyAbCntrl.buildingList.length,
                            itemBuilder: (context, index) {
                              return PropertyAbWidget().propertyList(
                                  itemIndex: index,
                                  buildingId:
                                      propertyAbCntrl.buildingList[index]['id'],
                                  buildingTitle: propertyAbCntrl
                                      .buildingList[index]['name'],
                                  floor: propertyAbCntrl.buildingList[index]
                                          ['num_of_floors']
                                      .toString(),
                                  isFeature: true);
                            }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
