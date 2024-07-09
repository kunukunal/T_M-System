import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_amenities/add_amenities_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class AddBuildingCntroller extends GetxController {
  final selectedProperty = 'Property AB'.obs;
  final propertyList = [
    'Property AB',
    'Property AB1',
    'Property AB2',
  ].obs;

  final addMultipleBuilding = [
    {
      "building_name": TextEditingController(),
      "floor": TextEditingController(),
      "units": TextEditingController(),
      "amenities": [],
    },
  ].obs;
  final tempAmenitiestList = [].obs;

  final isBuildingDataUploaded = false.obs;

  onAmenitiesTap({required int index}) {
    tempAmenitiestList.value = (addMultipleBuilding[index]['amenities'] as List)
        .map((e) => {
              "amenity_name":
                  TextEditingController(text: e['amenity_name'].text),
              "ammount": TextEditingController(text: e['ammount'].text),
            })
        .toList();
    Get.to(() => AddAmentiesView(
          ind: index,
        ));
  }

  addBuildingData() async {
    isBuildingDataUploaded.value = true;
    final transformedData = addMultipleBuilding.map((building) {
      return {
        "property_obj": Get.arguments[0], // Example static value
        "name": (building["building_name"] as TextEditingController).text,
        "number_of_floors":
            int.parse((building["floor"] as TextEditingController).text),
        "number_of_units":
            int.parse((building["units"] as TextEditingController).text),
        "amenities": (building["amenities"] as List).map((amenity) {
          return {
            "name": (amenity["amenity_name"] as TextEditingController).text,
            "price": (amenity["ammount"] as TextEditingController).text,
          };
        }).toList(),
      };
    }).toList();
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";

    final response = await DioClientServices.instance.dioPostCall(
      isLoading: true,
      body: transformedData, // Ensure this is correctly handled as a List
      isRawData: true,
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: addbuildingData,
    );

    if (response != null) {
      if (response.statusCode == 201) {
        isBuildingDataUploaded.value = false;
        customSnackBar(Get.context!, response.data['message'].toString());
        Get.back(result: true);
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
