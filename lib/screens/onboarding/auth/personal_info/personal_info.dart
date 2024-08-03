import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/personal_info/personal_info_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/personal_info/personal_info_widget.dart';

import '../../../../common/text_styles.dart';

class PersonalInfo extends StatefulWidget {
  final bool? isFromRegister;
  final String? mobileContrl;
  final String? phoneCode;
  final bool? isprofileDetailsRequired;
  const PersonalInfo(
      {required this.isFromRegister,
      this.mobileContrl,
      this.phoneCode,
      this.isprofileDetailsRequired = false,
      super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final personalInfoCntrl = Get.put(PersonalInfoController());
  final authCntrl = Get.put(AuthController());
  @override
  void initState() {
    if (widget.isprofileDetailsRequired == true) {
      personalInfoCntrl.getPersonalDetails();
    } else {
      personalInfoCntrl.phoneCntrl.value.text = widget.mobileContrl!;
      authCntrl.selectedItem.value = widget.phoneCode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information', style: CustomStyles.otpStyle050505),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: InkWell(
                onTap: () {
                  personalInfoCntrl.onSkipTap(
                      isFromRegister: widget.isFromRegister);
                },
                child: Text('Skip', style: CustomStyles.skipBlack)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                color: HexColor('#679BF1'),
                height: 5.h,
                width: Get.width / 2,
              ),
              Container(
                color: HexColor('#F8F8F8'),
                height: 5.h,
                width: Get.width / 2,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text('Personal Information', style: CustomStyles.skipBlack),
                  const Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      PersonlInfoWidget().showSelectionDialog(context);
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Obx(() {
                            return Container(
                              height: 99.h,
                              width: 110.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: HexColor('#444444'),
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: personalInfoCntrl.imageFile.value ==
                                              null &&
                                          personalInfoCntrl
                                                  .networkImage.value ==
                                              ""
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              "assets/icons/cameraIcon.png"),
                                        )
                                      : personalInfoCntrl.imageFile.value !=
                                              null
                                          ? DecorationImage(
                                              image: FileImage(File(
                                                  personalInfoCntrl
                                                      .imageFile.value!.path)),
                                              fit: BoxFit.cover)
                                          : personalInfoCntrl
                                                      .networkImage.value !=
                                                  ""
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                      personalInfoCntrl
                                                          .networkImage.value),
                                                  fit: BoxFit.cover)
                                              : const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/icons/cameraIcon.png"),
                                                )),
                            );
                          }),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Add Profile',
                            style: CustomStyles.skipBlack
                                .copyWith(fontWeight: FontWeight.w400)),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //   child: TextButton(
                        //     onPressed: () {

                        //     },
                        //     child: Text('Add Profile',
                        //         style: CustomStyles.skipBlack
                        //             .copyWith(fontWeight: FontWeight.w400)),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Full Name'),
                  customTextField(
                      controller: personalInfoCntrl.nameCntrl.value,
                      focusNode: personalInfoCntrl.nameFocus.value,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Email Id'),
                  customTextField(
                      controller: personalInfoCntrl.emailCntrl.value,
                      focusNode: personalInfoCntrl.emailFocus.value,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Mobile Number',
                      isMandatory: true),
                  customTextField(
                      controller: personalInfoCntrl.phoneCntrl.value,
                      focusNode: personalInfoCntrl.phoneFocus.value,
                      hintText: 'Enter Mobile Number',
                      isBorder: true,
                      maxLength: 10,
                      onDropdownChanged: false,
                      keyboardType: TextInputType.number,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      readOnly: true,
                      isForCountryCode: true),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Permanent Address'),
                  customTextField(
                      controller: personalInfoCntrl.permanentAddCntrl.value,
                      focusNode: personalInfoCntrl.permanentFocus.value,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      maxLines: 3),
                  SizedBox(
                    height: 5.h,
                  ),
                  PersonlInfoWidget.commomText('Pincode', isMandatory: true),
                  customTextField(
                      controller: personalInfoCntrl.pinNoCntrl.value,
                      focusNode: personalInfoCntrl.pinNoFocus.value,
                      keyboardType: TextInputType.number,
                      hintText: 'Type Here...',
                      maxLength: 6,
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PersonlInfoWidget.commomText('State'),
                            // customTextField(
                            //     controller: personalInfoCntrl.stateCntrl.value,
                            //     width: Get.width / 2.3,
                            //     hintText: 'Type Here...',
                            //     isBorder: true,
                            //     color: HexColor('#F7F7F7'),
                            //     isFilled: false),
                            bigDropDown(
                                // width: 150.5.w,
                                width: Get.width / 2.3,
                                selectedItem:
                                    personalInfoCntrl.selectedState.value,
                                items: state,
                                onChange: (item) {
                                  personalInfoCntrl.selectedState.value = item;
                                }),
                          ],
                        );
                      }),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PersonlInfoWidget.commomText('City'),
                          customTextField(
                              controller: personalInfoCntrl.cityCntrl.value,
                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                    ],
                  ),
                  customButton(
                      onPressed: () {
                        if (widget.isFromRegister!) {
                          personalInfoCntrl.onNextTap(
                              isFromRegister: widget.isFromRegister);
                        } else {
                          personalInfoCntrl.onNextTap(
                              isFromRegister: widget.isFromRegister);
                          personalInfoCntrl.onSubmitPressed();
                        }
                      },
                      text: 'Next',
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
