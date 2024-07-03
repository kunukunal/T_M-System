import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar/navbar_view.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/otp_screen.dart';
import 'package:tanent_management/screens/onboarding/auth/personal_info/personal_info.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  //variables
  final selectedItem = ''.obs;
  var items = ["  +91", "  +64"].obs;

  final isTimeComplete = false.obs;
  final isFromRegister = false.obs;
  final countdownTimer = Rxn<Timer>().obs;
  final myDuration = const Duration(seconds: 60).obs;

  final mobileNumberController = TextEditingController().obs;
  final onButtonTapTenant = 2.obs;

  final otpController1 = TextEditingController().obs;
  final otpController2 = TextEditingController().obs;
  final otpController3 = TextEditingController().obs;
  final otpController4 = TextEditingController().obs;
  final otpFocus1 = FocusNode().obs;
  final otpFocus2 = FocusNode().obs;
  final otpFocus3 = FocusNode().obs;
  final otpFocus4 = FocusNode().obs;
  final CountdownController countController =
      CountdownController(autoStart: true);

  @override
  void onInit() {
    selectedItem.value = items.value[0];
    // startTimer();

    super.onInit();
  }

  onSubmitTapfromRegister(bool isFromRegister) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_personal_info_completed', false);
    Get.offAll(() => PersonalInfo(
          isFromRegister: isFromRegister,
          mobileContrl: mobileNumberController.value.text,
          phoneCode:selectedItem.value
        ));
  }

  onOtpSubmitPressed() {
    Get.offAll(() => const NavBar(initialPage: 0));
  }

  // void startTimer() {
  //   countdownTimer.value.value =
  //       Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  // }

  // void stopTimer() {
  //   countdownTimer.value.value!.cancel();
  // }

  // void setCountDown() {
  //   const reduceSecondsBy = 1;
  //   final seconds = myDuration.value.inSeconds - reduceSecondsBy;
  //   if (seconds < 0) {
  //     countdownTimer.value.value!.cancel();

  //     isTimeComplete.value = true;
  //   } else {
  //     myDuration.value = Duration(seconds: seconds);
  //   }
  // }

  openOtpScreen() {
    otpController1.value.clear();
    otpController2.value.clear();
    otpController3.value.clear();
    otpController4.value.clear();
    countController.start();
    isTimeComplete.value = false;
    Get.to(() => OtpScreen(
          isFromRegister: isFromRegister.value,
        ));
  }

  phoneOtpApi() async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioPostCall(
        isLoading: true,
        body: {
          'phone_code': selectedItem.value.toString().trim(),
          'phone': mobileNumberController.value.text
        },
        headers: {
          "Accept-Language": languaeCode,
        },
        url: phoneOtp);

    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, response.data['message'][0].toString());
        openOtpScreen();
        log("OTP send Successfully.");
      } else if (response.statusCode == 400) {
        customSnackBar(Get.context!, response.data['phone'][0].toString());
      }
    }
  }

  signUpApi() async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioPostCall(
        isLoading: true,
        body: {
          'user_type': onButtonTapTenant.value,
          'phone_code': selectedItem.value.toString().trim(),
          'phone': mobileNumberController.value.text
        },
        headers: {
          "Accept-Language": languaeCode,
        },
        url: signUp);

    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, response.data['message'][0].toString());
        openOtpScreen();
        log("OTP send Successfully. ${response.data}");
      } else if (response.statusCode == 400) {
        customSnackBar(Get.context!, response.data['phone'][0].toString());
      }
    }
  }

  verifyOtpApi(bool isFromRegister) async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioPostCall(
        isLoading: true,
        body: {
          'phone_code': selectedItem.value.toString().trim(),
          'phone': mobileNumberController.value.text,
          'otp':
              "${otpController1.value.text}${otpController2.value.text}${otpController3.value.text}${otpController4.value.text}" 
        },
        headers: {
          "Accept-Language": languaeCode,
        },
        url: phoneOtpVerify);
    if (response != null) {
      // here api send 202 on success
      if (response.statusCode == 202) {
        prefs.setString('access_token', response.data['token']['access']);
        prefs.setString('refresh_token', response.data['token']['refresh']);

        isFromRegister
            ? onSubmitTapfromRegister(isFromRegister)
            : onOtpSubmitPressed();
        log("Login send Successfully.");
      } else if (response.statusCode == 400) {
        if (response.data.toString().contains('otp') == true) {
          customSnackBar(Get.context!, response.data['otp'][0].toString());
        } else if (response.data.toString().contains('phone') == true) {
          customSnackBar(Get.context!, response.data['phone'][0].toString());
        }
      }
    }
  }
}
