import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/navbar/navbar_view.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/otp_screen.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/personal_info/personal_info.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/navbar/navbar_view.dart';
import 'package:timer_count_down/timer_controller.dart';

class AuthController extends GetxController {
  //variables
  final selectedItem = ''.obs;
  var items = ["  +91", "  +64"].obs;

  final isTimeComplete = false.obs;
  // final isFromRegister = false.obs;
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
    selectedItem.value = items[0];
    // startTimer();

    super.onInit();
  }

  onSubmitTapfromRegister(bool isFromRegister) async {
    await SharedPreferencesServices.setBoolData(
        key: SharedPreferencesKeysEnum.ispersonalinfocompleted.value,
        value: false);
    await SharedPreferencesServices.setBoolData(
        key: SharedPreferencesKeysEnum.islandlord.value,
        value: onButtonTapTenant.value == 1 ? true : false);
    isLandlord = onButtonTapTenant.value == 1 ? true : false;
    Get.offAll(() => PersonalInfo(
        isFromRegister: isFromRegister,
        mobileContrl: mobileNumberController.value.text,
        phoneCode: selectedItem.value));
  }

  onOtpSubmitPressed(
      {required bool isProfileUpdated, required int userType}) async {
    if (userType == 1) {
      await SharedPreferencesServices.setBoolData(
          key: SharedPreferencesKeysEnum.islandlord.value, value: true);
      isLandlord = true;
      Get.offAll(() => const NavBar(initialPage: 0));
    } else {
      await SharedPreferencesServices.setBoolData(
          key: SharedPreferencesKeysEnum.islandlord.value, value: false);
      isLandlord = false;

      Get.offAll(() => const NavBarTenant(
            initialPage: 0,
          ));
    }

    // prefs.setBool('is_landlord', false);

    // if (isProfileUpdated) {
    //   Get.offAll(() => const NavBar(initialPage: 0));
    // } else {
    //   final prefs = await SharedPreferences.getInstance();
    //   prefs.setBool('is_personal_info_completed', false);
    //   Get.offAll(() => PersonalInfo(
    //       isFromRegister: true,
    //       isprofileDetailsRequired: true,
    //       mobileContrl: mobileNumberController.value.text,
    //       phoneCode: selectedItem.value));
    // }
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

  openOtpScreen({required bool isFromRegister}) {
    otpController1.value.clear();
    otpController2.value.clear();
    otpController3.value.clear();
    otpController4.value.clear();
    countController.start();
    isTimeComplete.value = false;
    Get.to(() => OtpScreen(
          isFromRegister: isFromRegister,
        ));
  }

  phoneOtpApi({required bool isFromRegister}) async {
    if (mobileNumberController.value.text.trim().isNotEmpty) {
      if (mobileNumberController.value.text.trim().length == 10) {
        String languaeCode = await SharedPreferencesServices.getStringData(
                key: SharedPreferencesKeysEnum.languaecode.value) ??
            "en";
        final response = await DioClientServices.instance.dioPostCall(body: {
          'phone_code': selectedItem.value.toString().trim(),
          'phone': mobileNumberController.value.text
        }, headers: {
          "Accept-Language": languaeCode,
        }, url: phoneOtp);

        if (response != null) {
          if (response.statusCode == 200) {
            customSnackBar(
                Get.context!, response.data['message'][0].toString());
            openOtpScreen(isFromRegister: isFromRegister);
          } else if (response.statusCode == 400) {
            if (response.data.toString().contains("error")) {
              customSnackBar(Get.context!, response.data['error'][0]);
            } else {
              customSnackBar(
                  Get.context!, response.data['phone'][0].toString());
            }
          }
        }
      } else {
        customSnackBar(Get.context!, "please_enter_correct_phone_number".tr);
      }
    } else {
      customSnackBar(Get.context!, "please_enter_phone_number".tr);
    }
  }

  signUpApi({required bool isFromRegister}) async {
    if (mobileNumberController.value.text.trim().isNotEmpty) {
      if (mobileNumberController.value.text.trim().length == 10) {
        String languaeCode = await SharedPreferencesServices.getStringData(
                key: SharedPreferencesKeysEnum.languaecode.value) ??
            "en";
        print("fsdlkfsd ${onButtonTapTenant.value}");
        final response = await DioClientServices.instance.dioPostCall(body: {
          'user_type': onButtonTapTenant.value,
          'phone_code': selectedItem.value.toString().trim(),
          'phone': mobileNumberController.value.text
        }, headers: {
          "Accept-Language": languaeCode,
        }, url: signUp);

        if (response != null) {
          if (response.statusCode == 200) {
            customSnackBar(
                Get.context!, response.data['message'][0].toString());
            openOtpScreen(isFromRegister: isFromRegister);
            log("OTP send Successfully. ${response.data}");
          } else if (response.statusCode == 400) {
            customSnackBar(Get.context!, response.data['phone'][0].toString());
          }
        }
      } else {
        customSnackBar(Get.context!, "please_enter_correct_phone_number".tr);
      }
    } else {
      customSnackBar(Get.context!, "please_enter_phone_number".tr);
    }
  }

  verifyOtpApi(bool isFromRegister) async {
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioPostCall(body: {
      'phone_code': selectedItem.value.toString().trim(),
      'phone': mobileNumberController.value.text,
      'otp':
          "${otpController1.value.text}${otpController2.value.text}${otpController3.value.text}${otpController4.value.text}"
    }, headers: {
      "Accept-Language": languaeCode,
    }, url: isFromRegister ? signUpOtpVerify : phoneOtpVerify);
    if (response != null) {
      // here api send 202 on success
      if (response.statusCode == 202) {
        await SharedPreferencesServices.setStringData(
            key: SharedPreferencesKeysEnum.accessToken.value,
            value: response.data['token']['access']);
        await SharedPreferencesServices.setStringData(
            key: SharedPreferencesKeysEnum.refreshToken.value,
            value: response.data['token']['refresh']);

        print("dasdlas ${response.data}");

        isFromRegister
            ? onSubmitTapfromRegister(isFromRegister)
            : onOtpSubmitPressed(
                isProfileUpdated: response.data['documents_uploaded'],
                userType: response.data['user_type']);
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
