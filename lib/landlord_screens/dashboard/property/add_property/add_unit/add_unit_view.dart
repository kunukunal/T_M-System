import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_unit/add_unit_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_unit/add_unit_widget.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets.dart';

class AddUnitView extends StatelessWidget {
  AddUnitView({super.key});
  final addUnitCntrl = Get.put(AddUnitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AddUnitWidget().appBar(addUnitCntrl.isEdit.value?"update_unit".tr:"add_unit".tr),
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
                      'unit_details'.tr,
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
                  AddUnitWidget().commomText('unit_name'.tr, isMandatory: true),
                  customTextField(
                    controller: addUnitCntrl.unitNameCntrl.value,
                    textInputAction: TextInputAction.done,
                    hintText: 'flat_number'.tr,
                    isBorder: true,
                    isFilled: false,
                  ),
                  AddUnitWidget().commomText('unit_type'.tr, isMandatory: true),
                  Obx(() {
                    return bigDropDown(
                        selectedItem: addUnitCntrl.selectedUnitType.value,
                        color: whiteColor,
                        items: addUnitCntrl.unitType,
                        onChange: (item) {
                          addUnitCntrl.selectedUnitType.value = item;
                        });
                  }),
                  AddUnitWidget()
                      .commomText('unit_features'.tr, isMandatory: true),
                  Obx(() {
                    return bigDropDown(
                        selectedItem: addUnitCntrl.selectedUnitFeature.value,
                        color: whiteColor,
                        items: addUnitCntrl.unitFeature,
                        onChange: (item) {
                          addUnitCntrl.selectedUnitFeature.value = item;
                        });
                  }),
                  AddUnitWidget().commomText('unit_rent'.tr, isMandatory: true),
                  customTextField(
                    controller: addUnitCntrl.unitRentCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    hintText: '5000.00',
                    isBorder: true,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  AddUnitWidget().commomText('area_size'.tr, isMandatory: true),
                  customTextField(
                    controller: addUnitCntrl.areaSizeCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    hintText: '${'type_here'.tr}... ${'sqft'.tr}',
                    isBorder: true,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          enableFeedback: false,
                          contentPadding: EdgeInsets.zero,
                          value: addUnitCntrl.isNegosiateSelected.value,
                          onChanged: (value) {
                            addUnitCntrl.isNegosiateSelected.value = value!;
                          },
                          title: Text(
                            "rent_negotiable".tr,
                            style: TextStyle(
                                fontSize: 16.sp - commonFontSize,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          enableFeedback: false,
                          contentPadding: EdgeInsets.zero,
                          value: addUnitCntrl.isActiveSelected.value,
                          onChanged: (value) {
                            addUnitCntrl.isActiveSelected.value = value!;
                          },
                          title: Text(
                            "available_for_rent".tr,
                            style: TextStyle(
                                fontSize: 16.sp - commonFontSize,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                        ),
                        // CheckboxListTile(
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   enableFeedback: false,
                        //   contentPadding: EdgeInsets.zero,
                        //   value: addUnitCntrl.isOccupiedSelected.value,
                        //   onChanged: (value) {
                        //     addUnitCntrl.isOccupiedSelected.value = value!;
                        //   },
                        //   title: Text(
                        //     "Is Available",
                        //     style: TextStyle(
                        //         fontSize: 16.sp - commonFontSize,
                        //         fontWeight: FontWeight.w500,
                        //         color: black),
                        //   ),
                        // ),
                      ],
                    );
                  }),
                  AddUnitWidget().commomText(
                    'note'.tr,
                  ),
                  customTextField(
                    controller: addUnitCntrl.noteCntrl.value,
                    textInputAction: TextInputAction.done,
                    hintText: '${'type_here'.tr}...',
                    isBorder: true,
                    maxLines: 3,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            children: List.generate(
                                (addUnitCntrl.ametiesList as List).length,
                                (ind) {
                              return Container(
                                width: 100,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: HexColor("#D9E3F4"),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        (addUnitCntrl.ametiesList as List)[ind]
                                                ['amenity_name']
                                            .text,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          (addUnitCntrl.ametiesList as List)
                                              .removeAt(ind);
                                          addUnitCntrl.ametiesList.refresh();
                                        },
                                        child: crossIcon),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: GestureDetector(
                      onTap: () {
                        addUnitCntrl.onAddAmeties();
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
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AddUnitWidget().commomText(
                    'upload_picture_video'.tr,
                  ),
                  Obx(() {
                    return addUnitCntrl.unitPickedImage.isEmpty
                        ? const SizedBox()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addUnitCntrl.unitPickedImage.length,
                            // padding: EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) {
                              if (addUnitCntrl.unitPickedImage[index]
                                      ['isDelete'] ==
                                  false) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    leading: Container(
                                      height: 150.h,
                                      width: 60.w,
                                      // padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade500),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: addUnitCntrl
                                                          .unitPickedImage[index]
                                                      ['isNetwork'] ==
                                                  true
                                              ? DecorationImage(
                                                  image: NetworkImage(addUnitCntrl
                                                          .unitPickedImage[index]
                                                      ['image']),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: FileImage(
                                                      File(addUnitCntrl.unitPickedImage[index]['image'].path)),
                                                  fit: BoxFit.cover)),
                                    ),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    title: Text("Image ${index + 1}"),
                                    trailing: IconButton(
                                        onPressed: () {
                                          if (addUnitCntrl
                                                      .unitPickedImage[index]
                                                  ['isNetwork'] ==
                                              false) {
                                            addUnitCntrl.unitPickedImage
                                                .removeAt(index);
                                          } else {
                                            addUnitCntrl.unitPickedImage[index]
                                                ['isDelete'] = true;
                                            addUnitCntrl.unitPickedImage
                                                .refresh();
                                          }
                                        },
                                        icon: const Icon(Icons.cancel)),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                            separatorBuilder: (context, index) {
                              if (addUnitCntrl.unitPickedImage[index]
                                      ['isDelete'] ==
                                  false) {
                                return const Divider();
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                  }),
                  GestureDetector(
                      onTap: () {
                        AddUnitWidget().showSelectionDialog(context);
                      },
                      child: uploadPicture),
                ],
              ),
            ),
            Obx(() {
              return addUnitCntrl.isAddUnitdataUploaded.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : customBorderButton(  addUnitCntrl.isEdit.value?"update".tr: 'save'.tr, () {
                      addUnitCntrl.onSaveTap();
                    },
                      verticalPadding: 10.h,
                      horizontalPadding: 2.w,
                      btnHeight: 40.h,
                      width: Get.width,
                      color: HexColor('#679BF1'),
                      textColor: HexColor('#FFFFFF'),
                      borderColor: Colors.transparent);
            })
          ],
        ),
      ),
    );
  }
}
