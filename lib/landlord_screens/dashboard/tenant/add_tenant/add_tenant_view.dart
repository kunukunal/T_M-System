import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/add_tenant_widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';
import '../../../../common/widgets.dart';
import '../../../onboarding/auth/login_view/auth_controller.dart';
import '../../../profile/edit_profile/edit_profile_widget.dart';
import 'add_tenant_controller.dart';

class AddTenantScreen extends StatelessWidget {
  AddTenantScreen({super.key});

  final addTenantCntrl = Get.put(AddTenantController());
  final authCntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: Text(
            addTenantCntrl.isComingForEdit.value
                ? 'update_kirayedar'.tr
                : 'add_kirayedar'.tr,
            style: CustomStyles.otpStyle050505W700S16),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            AddTenantWidgets()
                                .showSelectionDialog(Get.context!, true);
                          },
                          child: Stack(
                            children: [
                              addTenantCntrl.profileImage.value != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Container(
                                        height: 99.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('#444444'),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: Image.file(File(
                                                      addTenantCntrl
                                                          .profileImage
                                                          .value!
                                                          .path))
                                                  .image,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  : addTenantCntrl.isComingForEdit.value &&
                                          addTenantCntrl
                                                  .profileImageEdit.value !=
                                              ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Container(
                                            height: 99.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                              color: HexColor('#444444'),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      addTenantCntrl
                                                          .profileImageEdit
                                                          .value),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Container(
                                            height: 99.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                              color: HexColor('#444444'),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: Image.asset(
                                                          'assets/icons/profile.png')
                                                      .image,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                              Positioned(
                                  bottom: 0.h,
                                  right: 0.w,
                                  child: Stack(
                                    children: [
                                      backgroundCameraIcon,
                                      Positioned(
                                          top: 11.h,
                                          bottom: 11.h,
                                          right: 10.w,
                                          left: 10.w,
                                          child: cameraTenantIcon)
                                    ],
                                  ))
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('name'.tr),
                  customTextField(
                      controller: addTenantCntrl.name.value,
                      focusNode: addTenantCntrl.firstNameFocus.value,
                      keyboardType: TextInputType.name,
                      hintText: '${'type_here'.tr}...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  // Row(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         EditProfileWidget.commomText('Name'),
                  //         customTextField(
                  //             controller: addTenantCntrl.name.value,
                  //             focusNode: addTenantCntrl.firstNameFocus.value,
                  //             keyboardType: TextInputType.name,

                  //             hintText: 'Type Here...',
                  //             isBorder: true,
                  //             color: HexColor('#F7F7F7'),
                  //             isFilled: false),
                  //       ],
                  //     ),
                  //     // SizedBox(width: 15.w),
                  //     // Column(
                  //     //   crossAxisAlignment: CrossAxisAlignment.start,
                  //     //   children: [
                  //     //     EditProfileWidget.commomText('last Name'),
                  //     //     customTextField(
                  //     //         controller: addTenantCntrl.lastNameCntrl.value,
                  //     //         focusNode: addTenantCntrl.lastNameFocus.value,
                  //     //         keyboardType: TextInputType.name,
                  //     //         width: Get.width / 2.3,
                  //     //         hintText: 'Type Here...',
                  //     //         isBorder: true,
                  //     //         color: HexColor('#F7F7F7'),
                  //     //         isFilled: false),
                  //     //   ],
                  //     // )
                  //   ],
                  // ),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('email_address'.tr),
                  customTextField(
                      controller: addTenantCntrl.emailCntrl.value,
                      focusNode: addTenantCntrl.emailFocus.value,
                      keyboardType: TextInputType.emailAddress,
                      hintText: '${'type_here'.tr}...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('enter_mobile'.tr),
                  customTextField(
                      controller: addTenantCntrl.phoneCntrl.value,
                      focusNode: addTenantCntrl.phoneFocus.value,
                      keyboardType: TextInputType.number,
                      hintText: 'enter_mobile_number'.tr,
                      isBorder: true,
                      onDropdownChanged: !addTenantCntrl.isFromCheckTenat.value,
                      readOnly: addTenantCntrl.isFromCheckTenat.value,
                      maxLength: 10,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      isForCountryCode: true),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('address'.tr),
                  customTextField(
                      controller: addTenantCntrl.permanentAddCntrl.value,
                      focusNode: addTenantCntrl.permanentFocus.value,
                      keyboardType: TextInputType.streetAddress,
                      hintText: '${'type_here'.tr}...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      maxLines: 3),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('landmark'.tr),
                          customTextField(
                              controller: addTenantCntrl.streetdCntrl.value,
                              focusNode: addTenantCntrl.streetdtFocus.value,
                              width: Get.width / 2.3,
                              hintText: '${'type_here'.tr}...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('pincode'.tr,
                              isMandatory: true),
                          customTextField(
                              maxLength: 6,
                              controller: addTenantCntrl.pinNoCntrl.value,
                              focusNode: addTenantCntrl.pinNoFocus.value,
                              keyboardType: TextInputType.number,
                              width: Get.width / 2.3,
                              hintText: '${'type_here'.tr}...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              onChange: (value) async {
                                if (value.length == 6) {
                                  await DioClientServices.instance
                                      .postCodeApi(value, context)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        if (value['state'] != "") {
                                          int index = state
                                              .indexOf(value['state'] ?? "");
                                          if (index != -1) {
                                            addTenantCntrl.selectedState.value =
                                                state[index];
                                          }
                                        }
                                        if (value['city'] != "") {
                                          addTenantCntrl.cityCntrl.value.text =
                                              value['city'] ?? "";
                                        }
                                      }
                                    },
                                  );
                                }
                              },
                              isFilled: false),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditProfileWidget.commomText('state'.tr,
                                isMandatory: true),
                            bigDropDown(
                                // width: 150.5.w,
                                width: Get.width / 2.3,
                                selectedItem:
                                    addTenantCntrl.selectedState.value,
                                items: state,
                                onChange: (item) {
                                  addTenantCntrl.selectedState.value = item;
                                }),
                            // customTextField(
                            //     controller: addTenantCntrl.stateCntrl.value,
                            //     focusNode: addTenantCntrl.stateFocus.value,
                            //     width: Get.width / 2.3,
                            //     hintText: 'Type Here...',
                            //     isBorder: true,
                            //     color: HexColor('#F7F7F7'),
                            //     isFilled: false),
                          ],
                        );
                      }),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('city'.tr,
                              isMandatory: true),
                          customTextField(
                              controller: addTenantCntrl.cityCntrl.value,
                              focusNode: addTenantCntrl.cityFocus.value,
                              width: Get.width / 2.3,
                              hintText: '${'type_here'.tr}...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  customButton(
                      onPressed: () {
                        addTenantCntrl
                            .onNextTap(addTenantCntrl.isComingForEdit.value);
                      },
                      text: addTenantCntrl.isComingForEdit.value
                          ? 'update'.tr
                          : 'next'.tr,
                      width: Get.width,
                      verticalPadding: 10.h),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
