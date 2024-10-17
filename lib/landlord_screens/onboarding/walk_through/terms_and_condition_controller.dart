import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class TermsAndConditionController extends GetxController {
  final siteFeatureData = {}.obs;
  final checkboxValue = false.obs;
  final scrollController = ScrollController().obs;
  final isbuttonShow = true.obs;
  @override
  void onInit() {
    getSiteFeatures();
    scrollController.value.addListener(() {
      if (scrollController.value.offset ==
          scrollController.value.position.maxScrollExtent) {
        isbuttonShow.value = false;
      } else {
        isbuttonShow.value = true;
      }
    });
    super.onInit();
  }

  onCheckBoxClicked(value) {
    checkboxValue.value = value;
  }

  onNextClicked() {
    if (checkboxValue.value) {
      SharedPreferencesServices.setBoolData(key: 'first_run', value: false);
      Get.to(() => SignInScreen(
            isFromRegister: false,
          ));
    } else {
      customSnackBar(Get.context!, 'please_accept_terms_and_conditions'.tr);
    }
  }

  getSiteFeatures() async {
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
    }, url: siteFeatures);
    if (response != null) {
      if (response.statusCode == 200) {
        response.data.forEach((key, value) {
          if (value != null) {
            if (key == "privacy_policies" || key == "terms_condition") {
              siteFeatureData[key] = value;
            }
          }
        });

        log("siteFeatures data get Successfully.");
      }
    }
  }
}
