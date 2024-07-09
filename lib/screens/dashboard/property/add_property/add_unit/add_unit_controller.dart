import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_amenities_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_widget.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class AddUnitController extends GetxController {
  final unitNameCntrl = TextEditingController().obs;
  final unitRentCntrl = TextEditingController().obs;
  final areaSizeCntrl = TextEditingController().obs;
  final noteCntrl = TextEditingController().obs;
  final numberOfUnits = TextEditingController().obs;

  final selectedUnitType = '2 BHK'.obs;
  final selectedUnitFeature = 'For Rent'.obs;

  final tempAmenitiestList = [].obs;
  final unitPickedImage = [].obs;

  final ametiesList = [].obs;
  final isNegosiateSelected = true.obs;
  final isActiveSelected = true.obs;
  final isOccupiedSelected = true.obs;

  final isAddUnitdataUploaded = false.obs;

  final floorId = 0.obs;
  @override
  void onInit() {
    floorId.value = Get.arguments[0];
    numberOfUnits.value.text = "1";
    super.onInit();
  }

  final unitType = [
    '1 BHK',
    '2 BHK',
    '3 BHK',
    '4 BHK',
    '5 BHK',
    '6 BHK',
  ].obs;
  final unitFeature = [
    'For Rent',
    'For Sale',
  ].obs;

  onAddAmeties() {
    tempAmenitiestList.value = ametiesList
        .map((e) => {
              "amenity_name":
                  TextEditingController(text: e['amenity_name'].text),
              "ammount": TextEditingController(text: e['ammount'].text),
            })
        .toList();
    Get.to(() => AddUnitAmentiesView());
  }

  onSaveTap() {
    if (unitNameCntrl.value.text.trim().isNotEmpty) {
      if (unitRentCntrl.value.text.trim().isNotEmpty) {
        if (areaSizeCntrl.value.text.trim().isNotEmpty) {
          AddUnitWidget().addMultipleUnits(
            title: "How Many Unit are With Same Configuration",
            button1: "Cancel",
            button2: "Submit",
            onButton1Tap: () {
              Get.back();
            },
            onButton2Tap: () {
              String count = numberOfUnits.value.text.trim();
              if (int.parse(count) != 0) {
                if (int.parse(count) <= 10) {
                  Get.back();
                  addUnitApi();
                } else {
                  customSnackBar(
                      Get.context!, "You can create max 10 units at a time");
                }
              } else {
                customSnackBar(Get.context!, "Unit count can not be zero");
              }
            },
          );
        } else {
          customSnackBar(Get.context!, "Please fill the Area Size");
        }
      } else {
        customSnackBar(Get.context!, "Please fill the Rent");
      }
    } else {
      customSnackBar(Get.context!, "Please fill the unit name");
    }
  }

  getBhkId() {
    return unitType.indexOf(selectedUnitType.value) + 1;
  }

  getFeature() {
    return unitFeature.indexOf(selectedUnitFeature.value) + 1;
  }

  addUnitApi() async {
    isAddUnitdataUploaded.value = true;
    final transformedData = ametiesList.map((amenity) {
      return {
        "name": (amenity["amenity_name"] as TextEditingController).text,
        "price": (amenity["ammount"] as TextEditingController).text,
      };
    }).toList();
    var unitImage = [];
    for (int i = 0; i < unitPickedImage.length; i++) {
      unitImage.add(await DioClientServices.instance
          .multipartFile(file: unitPickedImage[i]));
    }
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
      isLoading: true,
      body: {
        "floor": floorId.value,
        "name": unitNameCntrl.value.text.trim(),
        "unit_type": getBhkId(),
        "unit_feature": getFeature(),
        "unit_rent": unitRentCntrl.value.text.trim(),
        "area_size": areaSizeCntrl.value.text.trim(),
        "note": noteCntrl.value.text.trim(),
        "is_rent_negotiable": isNegosiateSelected.value,
        "unit_images": unitImage,
        "amenities": jsonEncode(transformedData),
        "units_with_same_config": numberOfUnits.value.text,
        "is_occupied": !isOccupiedSelected.value,
        "is_active": isActiveSelected.value
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: addUnit,
    );

    if (response != null) {
      if (response.statusCode == 201) {
        isAddUnitdataUploaded.value = false;
        customSnackBar(Get.context!,
            "${unitNameCntrl.value.text.trim()} created Successfully");
        Get.back(result: true);
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
