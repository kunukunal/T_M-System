import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/landlord_screens/profile/notification_setting/notification_widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class NotificationController extends GetxController {
  final switchForGenNotif = false.obs;
  final switchForSound = false.obs;
  final switchForPayment = false.obs;
  final switchForAnyUpdate = false.obs;
  final switchForEmailNotif = false.obs;
  final switchForNewService = false.obs;
  final switchForNewTip = false.obs;

  final notificationSettingLoading = false.obs;

  @override
  void onInit() {
    getNotificationSetting();
    super.onInit();
  }

  getNotificationSetting() async {
    notificationSettingLoading.value = true;
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
      url: notificationSetting,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        notificationSettingLoading.value = false;
        final notificationData = response.data;
        switchForGenNotif.value = notificationData['general_notification'];
        switchForSound.value = notificationData['sounds'];
        switchForPayment.value = notificationData['payments'];
        switchForAnyUpdate.value = notificationData['any_updates'];
        switchForEmailNotif.value = notificationData['email_notification'];
        switchForNewService.value = notificationData['new_service_available'];
        switchForNewTip.value = notificationData['new_tips_available'];
      } else if (response.statusCode == 400) {
        // Handle error
      } else if (response.statusCode == 404) {
        // Handle error
      }
    }
  }

  updateNotificationSetting() async {
    notificationSettingLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "general_notification": switchForGenNotif.value,
        "sounds": switchForSound.value,
        "payments": switchForPayment.value,
        "any_updates": switchForAnyUpdate.value,
        "email_notification": switchForEmailNotif.value,
        "new_service_available": switchForNewService.value,
        "new_tips_available": switchForNewTip.value
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: notificationSetting,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        notificationSettingLoading.value = false;
      } else if (response.statusCode == 400) {
        // Handle error
      } else if (response.statusCode == 404) {
        // Handle error
      }
    }
  }

  final sendOtpLoading = false.obs;

  clearOtp() {
    final authCntrl = Get.find<AuthController>();

    authCntrl.otpController1.value.clear();
    authCntrl.otpController2.value.clear();
    authCntrl.otpController3.value.clear();
    authCntrl.otpController4.value.clear();
    sendOtpVerifyLoading.value = false;
    //  authCntrl. countController.res();
    authCntrl.isTimeComplete.value = false;
  }

  sendOtp(String email) async {
    sendOtpLoading.value = true;
    clearOtp();
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {"email": email},
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: emailOtp,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        sendOtpLoading.value = false;
        Get.back();
        customSnackBar(Get.context!, response.data['message'][0]);

        NotifWidget().otpPop(email);
      } else if (response.statusCode == 400) {
        // Handle error
      } else if (response.statusCode == 404) {
        // Handle error
      }
    }
  }

  final sendOtpVerifyLoading = false.obs;

  emailOtpVerifyApi(String email) async {
    final authCntrl = Get.find<AuthController>();

    sendOtpVerifyLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "email": email,
        "otp": authCntrl.otpController1.value.text.trim() +
            authCntrl.otpController2.value.text.trim() +
            authCntrl.otpController3.value.text.trim() +
            authCntrl.otpController4.value.text.trim(),
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: emailOtpVerify,
    );

    if (response != null) {
      if (response.statusCode == 202) {
        sendOtpVerifyLoading.value = false;
        userData['email_verified'] = true;
        Get.back();
        customSnackBar(Get.context!, response.data['message'][0]);
      } else if (response.statusCode == 400) {
        sendOtpVerifyLoading.value = false;
        customSnackBar(Get.context!, response.data['otp'][0]);
        // Handle error
      } else if (response.statusCode == 404) {
        // Handle error
      }
    }
  }
}
