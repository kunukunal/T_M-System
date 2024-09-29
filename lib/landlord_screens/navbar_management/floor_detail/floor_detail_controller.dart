import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/management/management_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class FloorDetailController extends GetxController {
  final items = [].obs;

  final floorId = 0.obs;
  final propertyFloorName = "".obs;

  final unitPropertyNameData = {}.obs;
  final unitBuildingNameData = {}.obs;
  final unitFloorNameData = {}.obs;

  final isRefreshmentRequired = false.obs;

  final rentTo = Rxn<DateTime>();

  @override
  onInit() {
    floorId.value = Get.arguments[0];
    propertyFloorName.value = Get.arguments[1];

    getUnitsStats();
    super.onInit();
  }

  final isUnitsStatsLoading = false.obs;
  onBuildingTap(Map unitNameData, List amenities, Map rentData) {
    // if (userData['user_documents']) {

    print(
        "sajdkjsdsadas ${unitNameData} ${amenities} ${rentData}   ${unitPropertyNameData}  ${unitBuildingNameData} ${unitFloorNameData} ${unitNameData} ");

    Get.to(() => ManagementScreen(isFromDashboard: false), arguments: [
      false,
      [
        unitPropertyNameData,
        unitBuildingNameData,
        unitFloorNameData,
        unitNameData
      ],
      amenities,
      rentData
    ])!
        .then((value) {
      if (value == true) {
        isRefreshmentRequired.value = true;
        getUnitsStats();
      }
    });
// }
// else{
//   Get.to(()=>DocumentScreen(isFromTenant: false),arguments: [false, userData['id']]);
// }
  }

  getUnitsStats() async {
    isUnitsStatsLoading.value = true;

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
      url: "$floortatistics${floorId.value}/unit-statistics/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isUnitsStatsLoading.value = false;
        final data = response.data;
        unitPropertyNameData.value = data['property'];
        unitBuildingNameData.value = data['building'];
        unitFloorNameData.value = data['floor'];
        items.clear();
        items.addAll(data['units']);
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }

  Future<void> selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: rentTo.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != rentTo.value) {
      rentTo.value = picked;
    }
  }

  removeTenant(int unitId) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    String dateToString =
        '${rentTo.value!.year}-${rentTo.value!.month}-${rentTo.value!.day}';
    final response = await DioClientServices.instance.dioPostCall(
      body: {"unit": unitId, "rent_to": dateToString},
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
        print("dasdlskadasl ${isRefreshmentRequired.value}");
        customSnackBar(Get.context!, response.data['message']);
        getUnitsStats();
      } else if (response.statusCode == 400) {
        // Handle error
      } else if (response.statusCode == 404) {
        customSnackBar(Get.context!, response.data['message']);
        // Handle error
      }
    }
  }
}
