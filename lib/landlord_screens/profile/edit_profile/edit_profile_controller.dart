import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class EditProfileController extends GetxController {
  final nameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final permanentAddCntrl = TextEditingController().obs;
  final pinNoCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  // final stateCntrl = TextEditingController().obs;
  final selectedState = "Select".obs;

  final nameFocus = FocusNode().obs;
  final emailFocus = FocusNode().obs;
  final phoneFocus = FocusNode().obs;
  final permanentFocus = FocusNode().obs;
  final pinNoFocus = FocusNode().obs;
  final cityFocus = FocusNode().obs;
  final stateFocus = FocusNode().obs;

  final networkImage = "".obs;
  final isProfileLoadingGet = false.obs;
  final selectedImage = Rxn<dynamic>();
  @override
  onInit() {
    getPersonalDetails();
    super.onInit();
  }

  getPersonalDetails() async {
    isProfileLoadingGet.value = true;
    final authCntrl = Get.put(AuthController());

        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
      'Authorization': "Bearer $accessToken",
    }, url: userProfile);
    if (response != null) {
      if (response.statusCode == 200) {
        isProfileLoadingGet.value = false;
        final data = response.data;
        authCntrl.onButtonTapTenant.value = data['user_type'] ?? 2;
        phoneCntrl.value.text = data['phone'] ?? "";
        authCntrl.selectedItem.value = "  ${data['phone_code']}";
        nameCntrl.value.text = data['name'] ?? "";
        emailCntrl.value.text = data['email'] ?? "";
        permanentAddCntrl.value.text = data['address'] ?? "";
        pinNoCntrl.value.text = data['zip_code'] ?? "";
        cityCntrl.value.text = data['city'] ?? "";
        checkIsState(data['state'] ?? "");
        // stateCntrl.value.text = data['state'] ?? "";
        networkImage.value = data['profile_image'] ?? "";
      } else if (response.statusCode == 400) {
        isProfileLoadingGet.value = false;
      }
    }
  }

  checkIsState(String value) {
    bool data = state.contains(value);
    if (data) {
      selectedState.value = value;
    } else {
      selectedState.value = "Select";
    }
  }

  onSubmit() {
    if (nameCntrl.value.text.trim().isNotEmpty) {
      // if (emailCntrl.value.text.trim().isNotEmpty) {
      if (permanentAddCntrl.value.text.trim().isNotEmpty) {
        if (selectedState.value != "Select") {
          if (pinNoCntrl.value.text.trim().isNotEmpty) {
            if (cityCntrl.value.text.trim().isNotEmpty) {
              userProfileUpdate();
            } else {
              customSnackBar(Get.context!, "please_enter_city".tr);
            }
          } else {
            customSnackBar(Get.context!, "please_enter_pincode".tr);
          }
        } else {
          customSnackBar(Get.context!, "please_enter_state".tr);
        }
      } else {
        customSnackBar(Get.context!, "please_enter_permanent_address".tr);
      }
      // } else {
      //   customSnackBar(Get.context!, "Please enter your email");
      // }
    } else {
      customSnackBar(Get.context!, "please_enter_name".tr);
    }
  }

  final isProfileUpdating = false.obs;
  userProfileUpdate() async {
    isProfileUpdating.value = true;

        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    final response = await DioClientServices.instance.dioPostCall(
        body: selectedImage.value != null
            ? {
                "profile_image": await DioClientServices.instance
                    .multipartFile(file: selectedImage.value!),
                "name": nameCntrl.value.text.trim(),
                if (emailCntrl.value.text.isNotEmpty)
                  "email": emailCntrl.value.text.trim(),
                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                "state": selectedState.value,
                // "country": "Country",
                // "longitude": 98.5656665,
                // "latitude": 78.5656665,
              }
            : {
                "name": nameCntrl.value.text.trim(),
                if (emailCntrl.value.text.isNotEmpty)
                  "email": emailCntrl.value.text.trim(),
                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                "state": selectedState.value,
                // "country": "Country",
                // "longitude": 98.5656665,
                // "latitude": 78.5656665,
              },
        headers: {
          "Accept-Language": languaeCode,
          'Authorization': "Bearer $accessToken",
        },
        url: userProfile);
    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, "profile_update_successfully".tr);
        isProfileUpdating.value = false;
        log("Profile update Successfully.");
      } else if (response.statusCode == 400) {
        if (response.data.toString().contains("email")) {
          isProfileUpdating.value = false;
          customSnackBar(Get.context!, response.data['email'][0].toString());
        }
      }
    } else {
      isProfileUpdating.value = false;
    }
  }
}
