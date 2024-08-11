import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_unit/add_unit_amentities_widget.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_unit/add_unit_controller.dart';

import '../../../../../common/constants.dart';

class AddUnitAmentiesView extends StatelessWidget {
  AddUnitAmentiesView({super.key});
  final addUnitController = Get.find<AddUnitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Amenities"),
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
                      'Amenities Details',
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
                        itemCount: addUnitController.tempAmenitiestList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddUnitAmenitiesWidget().addAmenitiesContainer(
                            amenitiesElement:
                                addUnitController.tempAmenitiestList[index],
                            onCancelTap: () {
                              addUnitController.tempAmenitiestList
                                  .removeAt(index);
                              addUnitController.tempAmenitiestList.refresh();
                            },
                          );
                        });
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 0.h, bottom: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        addUnitController.tempAmenitiestList.add(
                          {
                            "amenity_name": TextEditingController(),
                            "ammount": TextEditingController(),
                          },
                        );
                        addUnitController.tempAmenitiestList.refresh();
                      },
                      child: Row(
                        children: [
                          addIcon,
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Add Amenities(s)',
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
                  bool allFieldsFilled = addUnitController.tempAmenitiestList
                      .every((e) =>
                          e['amenity_name'] != null &&
                          e['amenity_name'].text.isNotEmpty &&
                          e['ammount'] != null &&
                          e['ammount'].text.isNotEmpty);

                  if (allFieldsFilled) {
                    addUnitController.ametiesList.value =
                        addUnitController.tempAmenitiestList
                            .map((e) => {
                                  "amenity_name": e['amenity_name'],
                                  "ammount": e['ammount'],
                                })
                            .toList();
                    addUnitController.ametiesList.refresh();
                    Get.back();
                  } else {
                    customSnackBar(context,
                        "Please check all the field are filled correctly");
                  }
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
