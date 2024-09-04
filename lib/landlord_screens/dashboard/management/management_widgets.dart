import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_widgets.dart';
import 'package:tanent_management/landlord_screens/profile/edit_profile/edit_profile_widget.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import 'management_controller.dart';

class ManagementWidgets {
  //Date picker
  datePickerContainer(String date, {double? width, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.h,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: HexColor('#EBEBEB'), width: 2)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: CustomStyles.hintText,
              ),
              dateIcon
            ],
          ),
        ),
      ),
    );
  }

  //Amenities list
  amenitiesList() {
    final manageCntrl = Get.find<ManagementController>();

    return manageCntrl.amenitiesList.isEmpty
        ?  Center(
            child:  Text("no_amenities".tr),
          )
        : Wrap(children: [
            ...List.generate(
                manageCntrl.amenitiesList.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          manageCntrl.onPaymentTypeTap(index);
                        },
                        child: Row(
                          children: [
                            manageCntrl.amenitiesList[index]['isSelected']
                                ? selectedCheckboxIcon
                                : checkboxIcon,
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${manageCntrl.amenitiesList[index]['name']} - ',
                              style: manageCntrl.amenitiesList[index]
                                      ['isSelected']
                                  ? CustomStyles.otpStyle050505W400S14
                                      .copyWith(fontSize: 14.sp - commonFontSize)
                                  : CustomStyles.desc606060.copyWith(
                                      fontFamily: 'DM Sans', fontSize: 14.sp - commonFontSize),
                            ),
                            InkWell(
                                onTap: () {
                                  priceEditingPopup(index);
                                },
                                child: Text(
                                  '${manageCntrl.amenitiesList[index]['amount'].text}',
                                  style: manageCntrl.amenitiesList[index]
                                          ['isSelected']
                                      ? CustomStyles.otpStyle050505W400S14
                                          .copyWith(
                                              fontSize: 14.sp - commonFontSize,
                                              decoration:
                                                  TextDecoration.underline)
                                      : CustomStyles.desc606060.copyWith(
                                          fontFamily: 'DM Sans',
                                          fontSize: 14.sp - commonFontSize,
                                          decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                      ),
                    ))
          ]);
  }

  priceEditingPopup(int index) {
    final manageCntrl = Get.find<ManagementController>();
    TextEditingController priceController = TextEditingController(
        text: manageCntrl.amenitiesList[index]['amount'].text);
    return Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        titlePadding: EdgeInsets.only(top: 5.h, left: 14.w, right: 14.w),
        contentPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
        title: Text(
          "update_amount".tr,
          style: TextStyle(
              color: black,
              fontSize: 18.sp - commonFontSize,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            EditProfileWidget.commomText(
              'name'.tr,
            ),
            Text(manageCntrl.amenitiesList[index]['name'],
                style: CustomStyles.titleText.copyWith(
                    fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            SizedBox(
              height: 10.h,
            ),
            EditProfileWidget.commomText('rent_rs'.tr, isMandatory: true),
            customTextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                // width: Get.width / 2.3,
                hintText: '${'type_here'.tr}...',
                isBorder: true,
                isFilled: false),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: customBorderButton(
                    "cancel".tr,
                    () {
                      Get.back();
                    },
                    verticalPadding: 5.h,
                    horizontalPadding: 2.w,
                    btnHeight: 35.h,
                    width: 140.w,
                    borderColor: HexColor('#679BF1'),
                    textColor: HexColor('#679BF1'),
                  ),
                ),
                customBorderButton(
                  "update".tr,
                  () {
                    Get.back();
                    manageCntrl.amenitiesList[index]['amount'].text =
                        priceController.text.trim();
                    manageCntrl.amenitiesList.refresh();
                  },
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: 35.h,
                  width: 140.w,
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  otpPop() async {
    final authCntrl = Get.find<AuthController>();
    final manageCntrl = Get.find<ManagementController>();

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
              "enter_otp".tr,
              style: TextStyle(
                  color: black,
                  fontSize: 18.sp - commonFontSize,
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
                      SizedBox(width: 5.w,),
                  otpTextField(
                      authCntrl.otpController2.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus1.value,
                      authCntrl.otpFocus3.value),
                      SizedBox(width: 5.w,),
                  otpTextField(
                      authCntrl.otpController3.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus4.value),
                      SizedBox(width: 5.w,),
                  otpTextField(
                      authCntrl.otpController4.value,
                      authCntrl.otpFocus4.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus4.value,
                      onChanged: (value){
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
                          manageCntrl.verifyOtpTenantApi();
                        } else {
                          customSnackBar(Get.context!, "please_enter_otp".tr);
                        }
                      }
                      ),
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
              () => manageCntrl.addTenantOtpVerify.value == false
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
                          manageCntrl.verifyOtpTenantApi();
                        } else {
                          customSnackBar(Get.context!, "please_enter_otp".tr);
                        }
                      },
                      text: 'submit'.tr,
                      width: Get.width)
                  : const Center(child: CircularProgressIndicator()),
            ),
            AuthWidget.resendTenantOtp(onPressed: () {
              if (authCntrl.isTimeComplete.value == true) {
                manageCntrl.addTenant(isFromTenant: false);
                authCntrl.countController.restart();
                authCntrl.isTimeComplete.value = false;
              } else {
                customSnackBar(
                    Get.context!, "please_wait_until_timer_completes".tr);
              }
            })
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
