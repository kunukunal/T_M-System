




import 'dart:developer';

import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class PrivacyPolicyController extends GetxController {
  final siteFeatureData = {}.obs;

  @override
  void onInit() {
    getPrivacyPolicy();
    super.onInit();
  }

final isPrivacyLoading=false.obs;
  getPrivacyPolicy() async {
    isPrivacyLoading.value=true;

        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
    }, url: siteFeatures);
    if (response != null) {
      if (response.statusCode == 200) {
         isPrivacyLoading.value=false;
        siteFeatureData.value = response.data['privacy_policies'];
        log("siteFeatures data get Successfully.");
      }
      else{
                 isPrivacyLoading.value=false;

      }
    }
  }
}
