import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/floor/floor_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class PropertyAbCntroller extends GetxController {
  final buildingList = [
    // {'buildingTitle': 'Building 1', 'floor': '10', 'isFeatured': true},
    // {'buildingTitle': 'Building 2', 'floor': '10', 'isFeatured': true},
    // {'buildingTitle': 'Building 3', 'floor': '10', 'isFeatured': true},
  ].obs;

  final isBuildingDataListLoading = true.obs;

  final propertyId = 0.obs;
  final propertyName = "".obs;
  final isApiNeeded = false.obs;

  //asda

  @override
  void onInit() {
    propertyId.value = Get.arguments[0];
    propertyName.value = Get.arguments[1];
    isApiNeeded.value = false;
    getBuildingData();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddBuildingView(), arguments: [propertyId.value, false, {}])
        ?.then((value) {
      if (value == true) {
        isApiNeeded.value = true;
        getBuildingData();
      }
    });
  }

  onEditAddTap(Map item) {
    Get.to(() => AddBuildingView(), arguments: [propertyId.value, true, item])
        ?.then((value) {
      if (value == true) {
        getBuildingData();
      }
    });
  }

  onListTap(
      {required int buildingId,
      required String buildingName,
      required Map item}) {
    Get.to(() => FloorView(), arguments: [buildingId, buildingName, item])
        ?.then((value) {
      if (value == true) {
        isApiNeeded.value = true;
        getBuildingData();
      }
    });
  }

  getBuildingData() async {
    isBuildingDataListLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: "$getOrAddPropertyList${propertyId.value}/");
    if (response != null) {
      if (response.statusCode == 200) {
        buildingList.clear();
        buildingList.addAll(response.data['buildings']);
        if (buildingList.isEmpty) {
          Get.off(() => AddBuildingView(),
              arguments: [propertyId.value, false, {}]);
        }
        isBuildingDataListLoading.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteBuildingData({required int buildingId}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: "$addbuildingData$buildingId/");
    if (response != null) {
      if (response.statusCode == 200) {
        isApiNeeded.value = true;
        getBuildingData();
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        print("daslksdasd");
        if (response.data.toString().contains("occupied_units")) {
          customSnackBar(Get.context!, response.data['occupied_units']);
        }
      }
    }
  }
}
