import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_amenities/add_amentities_widget.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_building/add_building_controller.dart';

import '../../../../../common/constants.dart';

class AddAmentiesView extends StatelessWidget {
  final int ind;
  AddAmentiesView({required this.ind, super.key});
  final addBuildingCntrl = Get.find<AddBuildingCntroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "amenities".tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      'amenities_details'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp - commonFontSize,
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
                        itemCount: addBuildingCntrl.tempAmenitiestList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddAmenitiesWidget().addAmenitiesContainer(
                            amenitiesElement:
                                addBuildingCntrl.tempAmenitiestList[index],
                            onCancelTap: () {
                              addBuildingCntrl.tempAmenitiestList
                                  .removeAt(index);
                              addBuildingCntrl.tempAmenitiestList.refresh();
                            },
                          );
                        });
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        addBuildingCntrl.tempAmenitiestList.add(
                          {
                            "amenity_name": TextEditingController(),
                            "ammount": TextEditingController(),
                          },
                        );
                        addBuildingCntrl.tempAmenitiestList.refresh();
                      },
                      child: Row(
                        children: [
                          addIcon,
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'add_amenities'.tr,
                            style: TextStyle(
                                fontSize: 16.sp - commonFontSize,
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
            customButton(
                onPressed: () {
                  bool allFieldsFilled = addBuildingCntrl.tempAmenitiestList
                      .every((e) =>
                          e['amenity_name'] != null &&
                          e['amenity_name'].text.isNotEmpty &&
                          e['ammount'] != null &&
                          e['ammount'].text.isNotEmpty);

                  if (allFieldsFilled) {
                    addBuildingCntrl.addMultipleBuilding[ind]['amenities'] =
                        addBuildingCntrl.tempAmenitiestList
                            .map((e) => {
                                  "amenity_name": e['amenity_name'],
                                  "ammount": e['ammount'],
                                })
                            .toList();
                    addBuildingCntrl.addMultipleBuilding.refresh();
                    Get.back();
                  } else {
                    customSnackBar(context,
                        "please_check_all_fields_filled_correctly".tr);
                  }
                },
                text: 'save'.tr,
                width: Get.width,
                verticalPadding: 10.h),
          ],
        ),
      ),
    );
  }
}
