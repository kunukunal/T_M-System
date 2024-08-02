import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_property_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_property_widgets.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';
import '../../../../common/widgets.dart';

class AddPropertyView extends StatelessWidget {
  AddPropertyView({super.key});
  final addPropertyCntrl = Get.put(AddPropertyCntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddPropertyWidget().appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text('Property Details', style: CustomStyles.skipBlack),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(
                      height: 1,
                      color: lightBorderGrey,
                    ),
                  ),
                  AddPropertyWidget()
                      .commomText('Property Title', isMandatory: true),
                  customTextField(
                    controller: addPropertyCntrl.propertyTitleCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Type Here...',
                    isBorder: true,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  AddPropertyWidget().commomText('Address', isMandatory: true),
                  customTextField(
                    controller: addPropertyCntrl.addressCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Type Here...',
                    isBorder: true,
                    maxLines: 2,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  AddPropertyWidget()
                      .commomText('Landmark', isMandatory: false),
                  customTextField(
                    controller: addPropertyCntrl.landmarkCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Type Here...',
                    isBorder: true,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  AddPropertyWidget().commomText('Pin Code', isMandatory: true),
                  customTextField(
                    controller: addPropertyCntrl.pinCodeCntrl.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    hintText: 'Type Here...',
                    maxLength: 6,

                    isBorder: true,
                    // color: HexColor('#F7F7F7'),
                    isFilled: false,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddPropertyWidget()
                              .commomText('City', isMandatory: true),
                          customTextField(
                            controller: addPropertyCntrl.cityCntrl.value,
                            textInputAction: TextInputAction.done,
                            // keyboardType: TextInputType.number,
                            hintText: 'Type Here...',
                            isBorder: true,
                            // color: HexColor('#F7F7F7'),
                            isFilled: false,
                            width: Get.width / 2.3,
                          ),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddPropertyWidget()
                              .commomText('State', isMandatory: true),
                          customTextField(
                            controller: addPropertyCntrl.stateCntrl.value,
                            textInputAction: TextInputAction.done,
                            // keyboardType: TextInputType.number,
                            hintText: 'Type Here...',
                            isBorder: true,
                            // color: HexColor('#F7F7F7'),
                            isFilled: false,
                            width: Get.width / 2.3,
                          ),
                        ],
                      )
                    ],
                  ),
                  AddPropertyWidget()
                      .commomText('Upload Picture', isMandatory: false),
                  Obx(() {
                    return addPropertyCntrl.propertyPickedImage.isEmpty
                        ? const SizedBox()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                addPropertyCntrl.propertyPickedImage.length,
                            // padding: EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) {
                              if (addPropertyCntrl.propertyPickedImage[index]
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
                                          image: addPropertyCntrl
                                                          .propertyPickedImage[index]
                                                      ['isNetwork'] ==
                                                  true
                                              ? DecorationImage(
                                                  image: NetworkImage(addPropertyCntrl
                                                          .propertyPickedImage[index]
                                                      ['image']),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: FileImage(
                                                      File(addPropertyCntrl.propertyPickedImage[index]['image'].path)),
                                                  fit: BoxFit.cover)),
                                    ),
                                    titleAlignment: ListTileTitleAlignment.top,
                                    title: Text("Image ${index + 1}"),
                                    trailing: IconButton(
                                        onPressed: () {
                                          if (addPropertyCntrl
                                                      .propertyPickedImage[
                                                  index]['isNetwork'] ==
                                              false) {
                                            addPropertyCntrl.propertyPickedImage
                                                .removeAt(index);
                                          } else {
                                            addPropertyCntrl
                                                    .propertyPickedImage[index]
                                                ['isDelete'] = true;
                                            addPropertyCntrl.propertyPickedImage
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
                              if (addPropertyCntrl.propertyPickedImage[index]
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
                        AddPropertyWidget().showSelectionDialog(context);
                      },
                      child: uploadPicture),
                ],
              ),
            ),
            Obx(
              () => addPropertyCntrl.isPropertyAdded.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : customButton(
                      onPressed: () {
                        addPropertyCntrl.onSaveTap();
                      },
                      text: addPropertyCntrl.isForEdit.value == true
                          ? "Update"
                          : 'Save',
                      width: Get.width,
                      verticalPadding: 10.h),
            )
          ],
        ),
      ),
    );
  }
}
