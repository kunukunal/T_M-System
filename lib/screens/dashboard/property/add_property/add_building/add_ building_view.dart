import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_building_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_building_widget.dart';

import '../../../../../common/widgets.dart';

class AddBuildingView extends StatelessWidget {
  AddBuildingView({super.key});
  final addBuildingCntrl = Get.put(AddBuildingCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddBuildingWidgets().appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  // AddBuildingWidgets()
                  //     .commomText('Property', isMandatory: true),
                  // bigDropDown(
                  //     selectedItem: addBuildingCntrl.selectedProperty.value,
                  //     color: lightBorderGrey,
                  //     items: addBuildingCntrl.propertyList,
                  //     onChange: (item) {
                  //       addBuildingCntrl.selectedProperty.value = item;
                  //     }),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      'Building Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: black),
                    ),
                  ),
                  Divider(
                    color: lightBorderGrey,
                    height: 1.h,
                  ),
                  Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addBuildingCntrl.addMultipleBuilding.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddBuildingWidgets()
                              .addBuildingContainer(index: index);
                        });
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        if (addBuildingCntrl.addMultipleBuilding.length <= 10) {
                          addBuildingCntrl.addMultipleBuilding.add(
                            {
                              "building_name": TextEditingController(),
                              "floor": TextEditingController(),
                              "units": TextEditingController(),
                              "amenities": [],
                            },
                          );
                        } else {
                          customSnackBar(
                              context, "You can 10 building at a time");
                        }
                      },
                      child: Row(
                        children: [
                          addIcon,
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Add New Building',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            addBuildingCntrl.isBuildingDataUploaded.value==true? const CircularProgressIndicator():
            customButton(
                onPressed: () {
                  if (addBuildingCntrl.addMultipleBuilding.isNotEmpty) {
                    bool allFieldsFilled = addBuildingCntrl.addMultipleBuilding
                        .every((e) =>
                            e['building_name'] != null &&
                            (e['building_name'] as TextEditingController)
                                .text
                                .isNotEmpty &&
                            e['floor'] != null &&
                            (e['floor'] as TextEditingController)
                                .text
                                .isNotEmpty &&
                            e['units'] != null &&
                            (e['units'] as TextEditingController)
                                .text
                                .isNotEmpty);
                    if (allFieldsFilled) {
                      // final propertyIndex = Get.arguments[0].value;
                      addBuildingCntrl.isBuildingDataUploaded.value=true;
                      addBuildingCntrl.addBuildingData();
                    } else {
                      customSnackBar(context,
                          "Please check all field are filled correctly");
                    }
                  } else {
                    customSnackBar(
                        context, "No building data aavailable for add");
                  }

                  // Get.back();
                },
                text: 'Save',
                width: Get.width,
                verticalPadding: 10.h),
          ],
        ),
      ),
    );
  }
}
