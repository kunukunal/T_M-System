import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_controller.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_documents_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_widgets.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../common/constants.dart';

class AddTenantWidgets {
  static commonDocUpload({String? title, int? index}) {
    final tenantDocCntrl = Get.find<AddTenantDocumentController>();

    return Obx(() {
      return InkWell(
        onTap: () {
          AddTenantWidgets()
              .showSelectionDialog(Get.context!, false, index: index);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: tenantDocCntrl.documentList[index!]['image'] != null
                ? Container(
                    height: 120.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: HexColor('#EBEBEB'),
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          // image: Image.asset('assets/icons/profile.png').image,
                          image: FileImage(File(tenantDocCntrl
                              .documentList[index]['image'].path)),

                          // Image.file(File(tenantDocCntrl
                          //         .documentList[index!]['image'].path))
                          //     .image,
                          fit: BoxFit.cover),
                    ),
                  )
                : Container(
                    height: 120.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: HexColor('#EBEBEB'),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        cameraIcon,
                        Text(title!,
                            style: TextStyle(
                                color: HexColor('#606060'), fontSize: 14.sp)),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  //Show Gallery Dialogue
  Future<void> showSelectionDialog(BuildContext context, bool isFromProfile,
      {int? index}) {
    return Get.bottomSheet(Container(
      width: double.infinity,
      height: 250.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
          color: Colors.black87),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Text(
              "Choose one to upload a picture",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            )),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectionCont(
                    isFromProfile, 'Gallery', 'assets/icons/pictures.png', 1,
                    index: index),
                SizedBox(
                  width: 25.w,
                ),
                selectionCont(
                    isFromProfile, 'Camera', 'assets/icons/camera.png', 2,
                    index: index),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              )),
        ),
      ]),
    ));
  }

  static selectionCont(bool isFromProfile, String selectionTypeStr,
      String selectionIconStr, int btnTag,
      {int? index}) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Material(
        color: Colors.transparent,
        child: StatefulBuilder(
          builder: (context, setState) => InkWell(
            onTap: () {
              if (btnTag == 1) {
                Navigator.pop(context);
                getFromGallery(isFromProfile, index: index);
              } else {
                Navigator.pop(context);
                getFromCamera(isFromProfile, index: index);
              }
            }, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  selectionIconStr,
                  width: 60.0,
                  height: 60.0,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  selectionTypeStr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//get from gallery
  static getFromGallery(bool isFromProfile, {int? index}) async {
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (isFromProfile) {
        final tenantCntrl = Get.find<AddTenantController>();

        tenantCntrl.profileImage.value = pickedFile;
      } else {
        final tenantCntrl = Get.find<AddTenantDocumentController>();
        tenantCntrl.documentList[index!]['image'] = pickedFile;
        tenantCntrl.documentList.refresh();
      }
    } else {
      log("no file selected");
      // return null;
    }
  }

  /// Get from Camera
  static getFromCamera(bool isFromProfile, {int? index}) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        if (isFromProfile) {
          final tenantCntrl = Get.find<AddTenantController>();

          tenantCntrl.profileImage.value = pickedFile;
        } else {
          final tenantCntrl = Get.find<AddTenantDocumentController>();
          tenantCntrl.documentList[index!]['image'] = pickedFile;
          tenantCntrl.documentList.refresh();
        }
      } else {
        log('no file selected');
      }
    } catch (e) {
      log(e.toString());
      // return null;
    }
  }

  otpPop() async {
    final authCntrl = Get.find<AuthController>();
    final tenantCntrl = Get.find<AddTenantController>();
    return await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        titlePadding: EdgeInsets.only(top: 5.h, left: 14.w, right: 14.w),
        contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Enter the otp",
              style: TextStyle(
                  color: black,
                  fontSize: 18.sp,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: crossIcon,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  otpTextField(
                      authCntrl.otpController1.value,
                      authCntrl.otpFocus1.value,
                      authCntrl.otpFocus1.value,
                      authCntrl.otpFocus2.value),
                  otpTextField(
                      authCntrl.otpController2.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus1.value,
                      authCntrl.otpFocus3.value),
                  otpTextField(
                      authCntrl.otpController3.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus4.value),
                  otpTextField(
                      authCntrl.otpController4.value,
                      authCntrl.otpFocus4.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus4.value),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Countdown(
                  seconds: 60, // change it according to requirement
                  controller: authCntrl.countController,
                  build: (BuildContext context, double time) => Text(
                    time.toInt().toString(),
                    style: CustomStyles.descriptionText6c6c6c,
                  ),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    authCntrl.isTimeComplete.value = true;
                  },
                ),
              ),
            ),
            Obx(
              () => tenantCntrl.addTenantOtpVerify.value == false
                  ? customButton(
                      onPressed: () {
                        if (authCntrl.otpController1.value.text.trim().isNotEmpty &&
                            authCntrl.otpController2.value.text
                                .trim()
                                .isNotEmpty &&
                            authCntrl.otpController3.value.text
                                .trim()
                                .isNotEmpty &&
                            authCntrl.otpController4.value.text
                                .trim()
                                .isNotEmpty) {
                          tenantCntrl.verifyTanantOtp();
                        } else {
                          customSnackBar(Get.context!, "Please enter the otp.");
                        }
                      },
                      text: 'Submit',
                      width: Get.width)
                  : const Center(child: CircularProgressIndicator()),
            ),
            AuthWidget.resendTenantOtp(onPressed: () {
              if (authCntrl.isTimeComplete.value == true) {
                tenantCntrl.addTenantByLandLordApi(istenantaddfromOtp: false);
                authCntrl.countController.restart();
                authCntrl.isTimeComplete.value = false;
              } else {
                customSnackBar(
                    Get.context!, "Please wait until the timer completes.");
              }
            })
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
