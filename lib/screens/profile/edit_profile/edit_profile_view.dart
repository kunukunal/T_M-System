import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/profile/edit_profile/edit_profile_controller.dart';
import 'package:tanent_management/screens/profile/edit_profile/edit_profile_widget.dart';

import '../../../../common/text_styles.dart';
import '../../../common/constants.dart';

class EditProfileVew extends StatelessWidget {
  final bool isFromProfile;
  EditProfileVew({super.key, required this.isFromProfile});

  final editCntrl = Get.put(EditProfileController());
  final authCntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile', style: CustomStyles.otpStyle050505),
      ),
      body: Obx(() {
        return editCntrl.isProfileLoadingGet.value
            ? const Center(
                child:  CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: HexColor('#EBEBEB'),
                    height: 1.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              EditProfileWidget().showSelectionDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Container(
                                        height: 99.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                          color: HexColor('#444444'),
                                          shape: BoxShape.circle,
                                          image: editCntrl
                                                      .selectedImage.value !=
                                                  null
                                              ? DecorationImage(
                                                  image: FileImage(
                                                      File(
                                                          editCntrl
                                                              .selectedImage
                                                              .value
                                                              .path)),
                                                  fit: BoxFit.cover)
                                              : editCntrl
                                                          .networkImage.value !=
                                                      ""
                                                  ? DecorationImage(
                                                      image:
                                                          NetworkImage(
                                                              editCntrl
                                                                  .networkImage
                                                                  .value),
                                                      fit: BoxFit.cover)
                                                  : DecorationImage(
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
                                        child: editIcon)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          EditProfileWidget.commomText('Full Name'),
                          customTextField(
                              controller: editCntrl.nameCntrl.value,
                              focusNode: editCntrl.nameFocus.value,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                          SizedBox(
                            height: 5.h,
                          ),
                          EditProfileWidget.commomText('Email Id'),
                          customTextField(
                              controller: editCntrl.emailCntrl.value,
                              focusNode: editCntrl.emailFocus.value,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Type Here...',
                              isBorder: true,
                              readOnly: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                          SizedBox(
                            height: 5.h,
                          ),
                          EditProfileWidget.commomText('Mobile Number'),
                          customTextField(
                              controller: editCntrl.phoneCntrl.value,
                              focusNode: editCntrl.phoneFocus.value,
                              keyboardType: TextInputType.number,
                              hintText: 'Enter Mobile Number',
                              isBorder: true,
                              readOnly: true,
                              onDropdownChanged: false,
                              maxLength: 10,
                              color: HexColor('#F7F7F7'),
                              isFilled: false,
                              isForCountryCode: true),
                          SizedBox(
                            height: 5.h,
                          ),
                          EditProfileWidget.commomText('Permanent Address'),
                          customTextField(
                              controller: editCntrl.permanentAddCntrl.value,
                              focusNode: editCntrl.permanentFocus.value,
                              keyboardType: TextInputType.streetAddress,
                              hintText: 'Type Here...',
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
                                  EditProfileWidget.commomText('State'),
                                  customTextField(
                                      controller: editCntrl.stateCntrl.value,
                                      width: Get.width / 2.3,
                                      hintText: 'Type Here...',
                                      isBorder: true,
                                      color: HexColor('#F7F7F7'),
                                      isFilled: false),
                                ],
                              ),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EditProfileWidget.commomText('Postalcode'),
                                  customTextField(
                                      controller: editCntrl.pinNoCntrl.value,
                                      keyboardType: TextInputType.phone,
                                      width: Get.width / 2.3,
                                      hintText: 'Type Here...',
                                      isBorder: true,
                                      color: HexColor('#F7F7F7'),
                                      isFilled: false),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          EditProfileWidget.commomText('City'),
                          customTextField(
                              controller: editCntrl.cityCntrl.value,
                              focusNode: editCntrl.pinNoFocus.value,
                              hintText: 'Select',
                              // suffixIcon: dropDownArrowIcon,
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                          editCntrl.isProfileUpdating.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : customButton(
                                  onPressed: () {
                                    // Get.to(() => LandlordDocView());
                                    editCntrl.userProfileUpdate();
                                  },
                                  text: 'Update',
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
              );
      }),
    );
  }
}
