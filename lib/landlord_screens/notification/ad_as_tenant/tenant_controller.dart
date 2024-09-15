import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class AdasTenatDetailsScreenController extends GetxController {
  final tenantUnitList = [].obs;
  final unitId = 0.obs;

  final name = "".obs;
  final email = "".obs;
  final phoneCode = "".obs;
  final phoneNumber = "".obs;
  final address = "".obs;
  final profileImage = "".obs;
  final occupiedUnit = 0.obs;

  final city = "".obs;
  final state = "".obs;
  final pincode = "".obs;

  final tenantDoc = [].obs;

  final kiryederDocumentLoading = false.obs;
  final isRefreshMentRequired = false.obs;

  final notificationTypeId = 3.obs;
  final processRequestId = 0.obs;
  final tenantId = 0.obs;
  final notificationId = 0.obs;
  final isTenantAlreadyAdded = false.obs;

  @override
  onInit() {
    super.onInit();
    unitId.value = Get.arguments[0];
    notificationTypeId.value = Get.arguments[1];
    processRequestId.value = Get.arguments[2];
    isTenantAlreadyAdded.value = Get.arguments[3];
    tenantId.value = Get.arguments[4];
    notificationId.value = Get.arguments[5];
    getKireyderDetails();
  }

  final kireyderDetailsLoading = false.obs;
  getKireyderDetails() async {
    kireyderDetailsLoading.value = true;

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
      url: "$getKriyaderDetailsUsingNotifications${unitId.value}",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        final data = response.data;
        kireyderDetailsLoading.value = false;
        tenantUnitList.clear();
        name.value = data['name'] ?? "";
        email.value = data['email'] ?? "";
        phoneCode.value = data['phone_code'] ?? "";
        phoneNumber.value = data['phone'] ?? "";
        address.value = data['address'] ?? "";
        city.value = data['city'] ?? "";
        state.value = data['state'] ?? "";
        pincode.value = data['zip_code'] ?? "";
        profileImage.value = data['profile_image'] ?? "";
        occupiedUnit.value = data['occupied_units'] ?? 0;
        tenantDoc.value = data['documents'];
        tenantUnitList.addAll(data['units']);
      } else if (response.statusCode == 400) {
        kireyderDetailsLoading.value = false;
        // Handle error
      } else {
        kireyderDetailsLoading.value = false;
      }
    }
  }

  final isRefreshmentRequired = false.obs;

  final isRequestLoading = false.obs;

  removeTenant(int? unitId, int notificationId) async {
    isRequestLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    // String dateToString =
    //     '${rentTo.value!.year}-${rentTo.value!.month}-${rentTo.value!.day}';
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "unit": unitId,
        "notification_id": notificationId
        // "rent_to": ""
      },
      isRawData: true,
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: removeTenantFromUnit,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isRefreshmentRequired.value = true;
        isRequestLoading.value = false;

        Get.back(result: isRefreshmentRequired.value);
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        isRequestLoading.value = false;

        customSnackBar(Get.context!, response.data['message'][0]);
        // Handle error
      } else if (response.statusCode == 404) {
        isRequestLoading.value = false;
        customSnackBar(Get.context!, response.data['message']);
        // Handle error
      }
    }
  }

  addRejectTenant({
    bool isFromAccept = true,
    int? tenantId,
    int? requestId,
    int? notificationId,
  }) async {
    isRequestLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioPostCall(
      body: isFromAccept
          ? {
              "action": 1, // (1=Accept, 2=Reject)
              "tenant_id": tenantId
            }
          : {
              "action": 2, // (1=Accept, 2=Reject)
              "request_id": requestId,
              "notification_id": notificationId
            },
      isRawData: true,
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: acceptRejectTenant,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isRefreshmentRequired.value = true;
        isRequestLoading.value = false;
        Get.back(result: true);
      } else if (response.statusCode == 400) {
        isRequestLoading.value = false;
        // Handle error
      } else if (response.statusCode == 404) {
        isRequestLoading.value = false;
        // Handle error
      }
    }
  }
}
