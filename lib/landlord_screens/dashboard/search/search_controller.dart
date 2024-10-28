import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class SearchCntroller extends GetxController {
  final searchCntrl = TextEditingController().obs;
final focusNode = FocusNode().obs;
  final items = [

  ].obs;



  final totatUnits = 0.obs;
  final availableUnits = 0.obs;
  final occupiedUnits = 0.obs;

  final unitDataLoading = false.obs;



  final isOcupiedUnitShow=true.obs;
  final isUnOcupiedUnitShow=true.obs;

  getUnitBySearch() async {
    unitDataLoading.value = true;
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
      url: "$unitSearch${searchCntrl.value.text.trim()}",
    );

    if (response.statusCode == 200) {
      unitDataLoading.value = false;

      items.clear();
      final data = response.data;
      totatUnits.value = data['total'];
      availableUnits.value = data['available'];
      occupiedUnits.value = data['occupied'];

      items.addAll(data['units']);
      unitDataLoading.value = false;
    } else {
      unitDataLoading.value = false;
      print('Error: ${response.statusCode}');
    }
  }
}
