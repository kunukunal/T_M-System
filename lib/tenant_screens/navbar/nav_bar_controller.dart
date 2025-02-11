import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/profile/my_profile/my_profile_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/fcm_notification.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_view.dart';
import 'package:tanent_management/tenant_screens/explore/explore_view.dart';
import 'package:tanent_management/landlord_screens/reports/report_view.dart';

class NavBarTenantController extends GetxController {
  //variables
  final initialPage = 0.obs;
  final selectedIndex = 0.obs;
  late final pageController = PageController().obs;

  //List Variables
  late final pages = [
    DashboardTenantScreen(),
    ExploreScreen(),
    ReportScreen(),
    MyProfileView()
  ];

  @override
  onInit() {
    uploadUserTokenToFcm();
    super.onInit();
  }

  uploadUserTokenToFcm() async {
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String fcmToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.fcmToken.value) ??
        await NotificationService().getFcmToken();
    ;
    final response = await DioClientServices.instance.dioPostCall(body: {
      "fcm_token": fcmToken,
      "device_type": Platform.isAndroid ? 1 : 2
    }, headers: {
      "Accept-Language": languaeCode,
      'Authorization': "Bearer $accessToken",
    }, url: userProfile);
    print("FCM TOKEN UPDATE ${response}   ${fcmToken}");
    if (response != null) {
      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {}
    }
  }

  //functions
  Future<void> onPageChanged(int index) async {
    selectedIndex.value = index;
  }

  //this function is called when the item is clicked in navbar
  void onItemTap(int selectedItem) {
    pageController.value.jumpToPage(selectedItem);
  }
}
