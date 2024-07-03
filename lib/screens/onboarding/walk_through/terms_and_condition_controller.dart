import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class TermsAndConditionController extends GetxController {
  final siteFeatureData = {}.obs;
  final checkboxValue = false.obs;
  @override
  void onInit() {
    getSiteFeatures();
    super.onInit();
  }

  onCheckBoxClicked(value) {
    checkboxValue.value = value;
  }

  onNextClicked() {
    if (checkboxValue.value) {
      Get.to(() => SignInScreen(
            isFromRegister: false,
          ));
    } else {
      customSnackBar(Get.context!, 'Please accept terms and conditions');
    }
  }

  getSiteFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
    }, url: siteFeatures);
    if (response != null) {
      if (response.statusCode == 200) {
        siteFeatureData.value = response.data;
        log("siteFeatures data get Successfully.");
      }
    }
  }
}
