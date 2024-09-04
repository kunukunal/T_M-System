import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class TenantDetailsController extends GetxController {
  final tenantUnitList = [].obs;

  final paymentList = [].obs;

  final rentData = {"total_rent": 0, "rent_paid": 0, "rent_due": 0}.obs;

  final kireyderId = 0.obs;

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


  final tenantDoc=[].obs;


  final isRefreshMentRequired=false.obs;

  @override
  onInit() {
    super.onInit();
    kireyderId.value = Get.arguments[0];
    getKireyderDetails();
  }

  final kireyderDetailsLoading = false.obs;
  getKireyderDetails() async {
    kireyderDetailsLoading.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";            String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
              "Accept-Language": languaeCode,

      },
      url: "$tenantDetails${kireyderId.value}/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        final data = response.data;
        kireyderDetailsLoading.value = false;
        tenantUnitList.clear();
        paymentList.clear();
        rentData.value = {
          "total_rent": data['rent']['total_rent'],
          "rent_paid": data['rent']['rent_paid'],
          "rent_due": data['rent']['rent_due']
        };
        name.value = data['name'] ?? "";
        email.value = data['email'] ?? "";
        phoneCode.value = data['phone_code'] ?? "";
        phoneNumber.value = data['phone'] ?? "";
        address.value = data['address'] ?? "";
        city.value = data['city'] ?? "";
        state.value = data['state'] ?? "";
        pincode.value=data['zip_code']??"";
        profileImage.value = data['profile_image'] ?? "";
        occupiedUnit.value = data['occupied_units'] ?? 0;
        tenantDoc.value=data['documents'];
        tenantUnitList.addAll(data['units']);
        paymentList.addAll(data['payment_history']);
      } else if (response.statusCode == 400) {
        kireyderDetailsLoading.value = false;
        // Handle error
      } else {
        kireyderDetailsLoading.value = false;
      }
    }
  }
}
