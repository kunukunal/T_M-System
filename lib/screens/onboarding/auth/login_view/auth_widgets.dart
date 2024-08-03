import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/sign_in.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../common/widgets.dart';

class AuthWidget {
  static loginForm(bool isFromRegister) {
    final authCntrl = Get.find<AuthController>();
    return Padding(
      padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mobile Number',
            style: CustomStyles.titleText,
          ),
          SizedBox(
            height: 10.h,
          ),
          customTextField(
              maxLength: 10,
              controller: authCntrl.mobileNumberController.value,
              isForCountryCode: true,
              hintStyle: CustomStyles.hintText,
              hintText: 'Enter Mobile Number',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              isBorder: true,
              isFilled: false),
          SizedBox(
            height: 20.h,
          ),
          customButton(
              onPressed: () {
                if (isFromRegister) {
                  authCntrl.signUpApi(isFromRegister: isFromRegister);
                } else {
                  authCntrl.phoneOtpApi(isFromRegister: isFromRegister);
                }
              },
              text: isFromRegister ? 'Proceed' : 'Login',
              width: Get.width)
        ],
      ),
    );
  }

  static registrationBox() {
    final authCntrl = Get.find<AuthController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: IntrinsicHeight(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: HexColor('#F8F8F8'),
              borderRadius: BorderRadius.circular(7.r),
              border: Border.all(color: HexColor('#8AB9F1'), width: 2.w)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration',
                  style: CustomStyles.titleText.copyWith(
                      fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                    'Join us today and experience the daily benefits of freshness firsthand!',
                    style: CustomStyles.descriptionText6c6c6c),
                SizedBox(
                  height: 5.h,
                ),
                customButton(
                    onPressed: () {
                      resgisterPopup(
                        title: 'Registration as',
                        subtitle:
                            'Join us today and experience the daily benefits of freshness firsthand!',
                        button1: 'Landlord',
                        button2: 'Tenant',
                        onButton1Tap: () {
                          // isFromRegister = true;
                          authCntrl.onButtonTapTenant.value = 1;
                          Get.back();
                          Get.to(() => SignInScreen(isFromRegister: true));
                        },
                        onButton2Tap: () {
                          // isFromRegister = true;
                          authCntrl.onButtonTapTenant.value = 2;
                          Get.back();
                          Get.to(() => SignInScreen(isFromRegister: true));
                        },
                      );
                    },
                    text: 'Register Now',
                    height: 45.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  static otpTextFields({required bool? isFromRegister}) {
    final authCntrl = Get.find<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: isFromRegister! ? 0.h : 20.h,
        ),
        isFromRegister
            ? const SizedBox()
            : Text('Welcome back',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: HexColor('#111111'),
                )),
        SizedBox(
          height: 5.h,
        ),
        Text('Please enter the OTP sent to your registered mobile number.',
            style: CustomStyles.descriptionText6c6c6c),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'Mobile Number',
          style: CustomStyles.titleText,
        ),
        SizedBox(
          height: 5.h,
        ),
        customTextField(
            // controller: authCntrl.mobileNumberController.value,
            readOnly: true,
            color: HexColor('#F7F7F7'),
            hintStyle: CustomStyles.hintText,
            hintText:
                '${authCntrl.selectedItem.value} ${authCntrl.mobileNumberController.value.text}',
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            isBorder: true,
            isFilled: false),
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
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
                  authCntrl.otpFocus4.value,
                  onChanged: (p0) {
                   
                        if (authCntrl.otpController1.value.text.trim().isNotEmpty &&
                        authCntrl.otpController2.value.text.trim().isNotEmpty &&
                        authCntrl.otpController3.value.text.trim().isNotEmpty &&
                        authCntrl.otpController4.value.text.trim().isNotEmpty) {
                      authCntrl.verifyOtpApi(isFromRegister);
                   
                    }
                  },
                  ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
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
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  static resendButtonWidget({
    VoidCallback? onPressed,
  }) {
    final authCntrl = Get.find<AuthController>();
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Didn’t receive the code? ', style: CustomStyles.lightHint16),
          Obx(() {
            return TextButton(
              onPressed: onPressed,
              child: Text(
                'Resend',
                style: CustomStyles.titleText.copyWith(
                    fontWeight: FontWeight.w700,
                    color: authCntrl.isTimeComplete.value == false
                        ? Colors.grey
                        : Colors.black),
              ),
            );
          })
        ],
      ),
    );
  }

  static resendTenantOtp({
    VoidCallback? onPressed,
  }) {
    final authCntrl = Get.find<AuthController>();
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: Text('Didn’t receive the code? ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: CustomStyles.lightHint16)),
            Obx(() {
              return Flexible(
                flex: 2,
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Resend',
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w700,
                        color: authCntrl.isTimeComplete.value == false
                            ? Colors.grey
                            : Colors.black),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

Widget otpTextField(TextEditingController controller, FocusNode focus,
    FocusNode previousFocus, FocusNode nextFocus,{Function(String)? onChanged}) {
  return Container(
    width: 49.w,
    height: 49.h,
    decoration: BoxDecoration(
        color: HexColor('#F8F8F8'), borderRadius: BorderRadius.circular(8.r)),
    child: TextFormField(
      focusNode: focus,
      controller: controller,
      textAlign: TextAlign.center,
      style: CustomStyles.otpStyle050505,
      keyboardType: TextInputType.number,
      maxLength: 1,
      onChanged:onChanged?? (value) {
        if (value == '') {
          previousFocus.requestFocus();
        } else {
          nextFocus.requestFocus();
        }
        

        // setState(() {
        //   mergedOtp = (_otpController1.text.trim() +
        //       _otpController2.text.trim() +
        //       _otpController3.text.trim() +
        //       _otpController4.text.trim())
        //       .toString();
        // });
      },
      decoration: InputDecoration(
        counterText: '',
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent)),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(8.r),
        //     borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: HexColor('#111111'))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}
