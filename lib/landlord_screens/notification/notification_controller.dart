import 'dart:developer';

import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class NotificationController extends GetxController {
  final items = [].obs;
  final isRefreshScreen = false.obs;
  onReceiveTap() {
    Get.to(() => NotificationReceiveView());
  }

  @override
  void onInit() {
    getLandlordNotification();
    super.onInit();
  }

  final lanlordNotificationLoading = false.obs;

  getLandlordNotification() async {
    lanlordNotificationLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: landlordNotification,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        log("sadklkdla ${response.data}");
        lanlordNotificationLoading.value = false;
        items.clear();
        items.addAll(response.data);
      } else if (response.statusCode == 400) {
        lanlordNotificationLoading.value = false;
      }
    }
  }

  final isStatusUpdateLoading = false.obs;
  final isStatusUpdateLoadingRejected = false.obs;

  updateTransationStatusNotification(
      int transactionId, int status, int from) async {
    if (from == 1) {
      isStatusUpdateLoading.value = true;
    } else {
      isStatusUpdateLoadingRejected.value = true;
    }

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPatchCall(
      body: {
        "status": status // (1=Pending, 2=Accepted, 3=Rejected)
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$updateTransactionStatus$transactionId/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        if (from == 1) {
          isStatusUpdateLoading.value = false;
        } else {
          isStatusUpdateLoadingRejected.value = false;
        }
        getLandlordNotification();
      } else if (response.statusCode == 400) {
        if (from == 1) {
          isStatusUpdateLoading.value = false;
        } else {
          isStatusUpdateLoadingRejected.value = false;
        }

        // Handle error
      }
    }
  }

  updateNotificationRead(int notificationId) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPatchCall(
      body: {"is_read": true},
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$notificationRead$notificationId/",
    );

    if (response != null) {
      print("dsjakjdas ${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        getLandlordNotification();
        isRefreshScreen.value = true;

        print("fdsklakdsa dfd ${isRefreshScreen.value}");
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
