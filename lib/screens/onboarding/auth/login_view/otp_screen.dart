import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_widgets.dart';

import '../../../../common/widgets.dart';

class OtpScreen extends StatelessWidget {
  final bool? isFromRegister;
  OtpScreen({required this.isFromRegister, super.key});

  final authCntrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              backArrowIcon(),
              AuthWidget.otpTextFields(isFromRegister: isFromRegister!),
              customButton(
                  onPressed: () {
                    if (authCntrl.otpController1.value.text.trim().isNotEmpty &&
                        authCntrl.otpController2.value.text.trim().isNotEmpty &&
                        authCntrl.otpController3.value.text.trim().isNotEmpty &&
                        authCntrl.otpController4.value.text.trim().isNotEmpty) {
                      authCntrl.verifyOtpApi(isFromRegister!);
                    } else {
                      customSnackBar(Get.context!, "Please enter the otp.");
                    }
                  },
                  text: 'Submit',
                  width: Get.width),
              AuthWidget.resendButtonWidget(onPressed: () {
                if (authCntrl.isTimeComplete.value == true) {
                  if (isFromRegister!) {
                    authCntrl.signUpApi(isFromRegister: isFromRegister!);
                  } else {
                    authCntrl.phoneOtpApi(isFromRegister: isFromRegister!);
                  }
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
      ),
    );
  }
}
