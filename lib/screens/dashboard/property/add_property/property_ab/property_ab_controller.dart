import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

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
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

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
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

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
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }
}
