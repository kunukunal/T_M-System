import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/unit_List/unit_list_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

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
    Get.to(() => UnitView(),
            arguments: [floorId, floorName, buildingitemAmenties])!
        .then((value) {
      if (value == true) {
        isApiNeeded.value = true;
        getFloorData();
      }
    });
  }

  getFloorData() async {
    isFloorDataLoaded.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

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
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: '$deleteFloor$floorId/');
    if (response != null) {
      if (response.statusCode == 200) {
        isApiNeeded.value = true;
        getFloorData();
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {}
    }
  }

  updateFloorData({required int noOfUnits, required int floorId}) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

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
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";

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
