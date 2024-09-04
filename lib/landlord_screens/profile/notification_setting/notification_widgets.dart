import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_widgets.dart';
import 'package:tanent_management/landlord_screens/profile/notification_setting/notification_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../common/constants.dart';

class NotifWidget {
  final notifCntrl = Get.find<NotificationController>();

  static commonListTile(
      {String? title,
      void Function()? onTap,
      String? image,
      bool? switchValueForNotification = false,
      void Function(bool)? onChanged}) {
    return ListTile(
        visualDensity: VisualDensity(vertical: 3),
        tileColor: whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: borderGrey)),
        trailing: Switch(
            activeColor: HexColor('#ffffff'),
            inactiveTrackColor: switchGrey,
            activeTrackColor: lightBlue,
            value: switchValueForNotification!,
            onChanged: onChanged),
        title: Text(
          title!,
          style: TextStyle(
              fontSize: 16.sp - commonFontSize,
              fontWeight: FontWeight.w500,
              color: HexColor('#050505')),
        ),
        onTap: onTap);
  }

  showEmailDialoge({
    required String title,
    required String button1,
    required String button2,
  }) {
    final notifCntrl = Get.find<NotificationController>();

    TextEditingController emailController =
        TextEditingController(text: userData['email'] ?? "");
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
          title,
          style: TextStyle(
              color: black,
              fontSize: 18.sp - commonFontSize,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "stay_informed_with_email_updates".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp - commonFontSize,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            customTextField(
              controller: emailController,
              textInputAction: TextInputAction.done,
              hintText: '${'enter_email'.tr}...',
              readOnly: emailController.text.trim().isEmpty ? false : true,
              isBorder: true,
              isFilled: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customBorderButton(
                  button1,
                  () {
                    Get.back();
                  },
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: 35.h,
                  width: 100.w,
                  borderColor: HexColor('#679BF1'),
                  textColor: HexColor('#679BF1'),
                ),
                customBorderButton(
                  button2,
                  () {
                    if (emailController.text.isNotEmpty) {
                      notifCntrl.sendOtp(emailController.text);
                    } else {
                      customSnackBar(Get.context!, "please_enter_email".tr);
                    }
                  },
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: 35.h,
                  color: HexColor('#679BF1'),
                  textColor: Colors.white,
                  width: 140.w,
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  otpPop(String email) async {
    final authCntrl = Get.put(AuthController());
    final notifCntrl = Get.find<NotificationController>();

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
                  SizedBox(
                    width: 5.w,
                  ),
                  otpTextField(
                      authCntrl.otpController2.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus1.value,
                      authCntrl.otpFocus3.value),
                  SizedBox(
                    width: 5.w,
                  ),
                  otpTextField(
                      authCntrl.otpController3.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus2.value,
                      authCntrl.otpFocus4.value),
                  SizedBox(
                    width: 5.w,
                  ),
                  otpTextField(
                      authCntrl.otpController4.value,
                      authCntrl.otpFocus4.value,
                      authCntrl.otpFocus3.value,
                      authCntrl.otpFocus4.value, onChanged: (value) {
                    // if (authCntrl.otpController1.value.text.trim().isNotEmpty &&
                    //     authCntrl.otpController2.value.text.trim().isNotEmpty &&
                    //     authCntrl.otpController3.value.text.trim().isNotEmpty &&
                    //     authCntrl.otpController4.value.text.trim().isNotEmpty) {
                    //   // manageCntrl.verifyOtpTenantApi();
                    // } else {
                    //   customSnackBar(Get.context!, "Please enter the otp.");
                    // }
                  }),
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
              () => notifCntrl.sendOtpVerifyLoading.value == false
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
                          notifCntrl.emailOtpVerifyApi(email);
                        } else {
                          customSnackBar(Get.context!, "enter_otp".tr);
                        }
                      },
                      text: 'submit'.tr,
                      width: Get.width)
                  : const Center(child: CircularProgressIndicator()),
            ),
            AuthWidget.resendTenantOtp(onPressed: () {
              if (authCntrl.isTimeComplete.value == true) {
                // manageCntrl.addTenant(isFromTenant: false);
                notifCntrl.sendOtp(email);
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
