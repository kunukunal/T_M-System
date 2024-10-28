import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_list_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class FloorCntroller extends GetxController {
  final floorList = [].obs;
  final updateFloorName = TextEditingController().obs;
  final activeFloor = false.obs;

  final buildingId = 0.obs;
  final buildingName = "".obs;
  final isApiNeeded = false.obs;
  final buildingitemAmenties = {}.obs;

  @override
  void onInit() {
    isApiNeeded.value = false;
    buildingId.value = Get.arguments[0];
    buildingName.value = Get.arguments[1];
    buildingitemAmenties.value = Get.arguments[2];
    getFloorData();
    super.onInit();
  }

  final isFloorDataLoaded = false.obs;
  onAddTap() {}

  onFloorTap({required int floorId, required String floorName}) {
    Get.to(() => UnitView(), arguments: [
      floorId,
      floorName,
      buildingitemAmenties,
      buildingName.value
    ])!
        .then((value) {
      print("aslkdla ${value}");
      if (value == true) {
        isApiNeeded.value = true;
        getFloorData();
      }
    });
  }

  getFloorData() async {
    isFloorDataLoaded.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: '$addbuildingData${buildingId.value}/');
    if (response != null) {
      if (response.statusCode == 200) {
        floorList.clear();
        floorList.addAll(response.data['floors']);
        isFloorDataLoaded.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteFloorData({required int floorId}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: '$deleteFloor$floorId/');
    if (response != null) {
      if (response.statusCode == 200) {
        isApiNeeded.value = true;
        getFloorData();

        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        if (response.data.toString().contains("occupied_units")) {
          customSnackBar(Get.context!, response.data['occupied_units']);
        }
      }
    }
  }

  updateFloorData({required int noOfUnits, required int floorId}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPatchCall(body: {
      "name": updateFloorName.value.text,
      "number_of_units": noOfUnits,
      "is_active": activeFloor.value
    }, headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: '$deleteFloor$floorId/');
    if (response != null) {
      if (response.statusCode == 200) {
        getFloorData();
      } else if (response.statusCode == 400) {}
    }
  }

  addFloorData({required String floorName, required int units}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";

    final response = await DioClientServices.instance.dioPostCall(
        body: {
          "building": buildingId.value,
          "name": floorName,
          "number_of_units": units
        },
        isRawData: true,
        headers: {
          'Authorization': "Bearer $accessToken",
        },
        url: deleteFloor);
    if (response != null) {
      if (response.statusCode == 201) {
        isApiNeeded.value = true;
        getFloorData();
      } else if (response.statusCode == 400) {}
    }
  }
}
