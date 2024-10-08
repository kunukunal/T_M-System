import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/landlord_screens/profile/edit_profile/edit_profile_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class MyProfileController extends GetxController {
  //functions
  onEditProfileTap(isFromProfile) {
    Get.to(() => EditProfileVew(
          isFromProfile: isFromProfile,
        ));
  }

  final isAccountDelete = false.obs;

  deleteAccountApi(BuildContext context) async {
    isAccountDelete.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "delete": true,
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      url: deleteAccount,
    );

    if (response != null) {
      print("kdjas ${response.statusCode}");
      if (response.statusCode == 200) {
        isAccountDelete.value = false;
        await SharedPreferencesServices.clearSharedPrefData();
        Get.deleteAll();
        clearAll();
         SharedPreferencesServices.setBoolData(
                              key: 'first_run', value: false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(isFromRegister: false),
            ),
            (route) => false);
      } else if (response.statusCode == 400) {
        isAccountDelete.value = false;

        customSnackBar(Get.context!, "Account deleted successfully.");
      }
    }
  }
}
