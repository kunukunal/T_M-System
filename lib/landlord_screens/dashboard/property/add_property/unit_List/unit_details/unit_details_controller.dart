import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class UnitDetailsController extends GetxController {
  final amenitiesList = [].obs;

  final reviewCategory = [
    {'name': 'Accuracy', "rating": 0.0},
    {'name': 'Communication', "rating": 0.0},
    {'name': 'Cleanliness', "rating": 0.0},
    {'name': 'Check-in', "rating": 0.0},
    {'name': 'Maturity', "rating": 0.0},
  ].obs;

  final rateUnit = [
    {'name': 'Accuracy', "rating": 0.0},
    {'name': 'Communication', "rating": 0.0},
    {'name': 'Cleanliness', "rating": 0.0},
    {'name': 'Check-in', "rating": 0.0},
    {'name': 'Maturity', "rating": 0.0},
  ].obs;

  final pageController = PageController().obs;
  final initialPage = 0.obs;
  final unitId = 0.obs;

  final reviewController = TextEditingController().obs;

  final isFromDashboard = false.obs;
  final dasboardData = {}.obs;

  final isPalceRequest = false.obs;
  final isExitRequest = false.obs;
  final isRatingDone = false.obs;

  @override
  void onInit() {
    pageController.value.addListener(() {
      initialPage.value = pageController.value.page!.round();
    });
    unitId.value = Get.arguments[0];

    getUnitDetails();
    super.onInit();
  }

  final unitDetailsLoading = false.obs;
  final unitImageList = [].obs;
  final unitData = {
    "unit_name": "",
    "unit_rent": "",
    "unit_info": "",
    "unit_address": "",
    "available_from": "",
    "lanlord_name": "",
    "lanlord_image": "",
    "lat_long": [],
  }.obs;

  final unitRating = {
    "total_reviews": 0,
    "overall_average": 0.0,
  }.obs;
  final reviewList = [].obs;
  getUnitDetails() async {
    unitDetailsLoading.value = true;

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
      url: "$getUnitDetailsData${unitId.value}/",
    );
    if (response.statusCode == 200) {
      log("dasklksal ${response.data}");
      unitDetailsLoading.value = false;

      final data = response.data;
      unitData.value = {
        "unit_name": data['name'] ?? "",
        "unit_rent": data['unit_rent'] ?? "",
        "unit_info": data['unit_info'] ?? "",
        "unit_address": data['address'] ?? "",
        "available_from": data['available_from'] ?? "",
        "lanlord_name": data['landlord'] ?? "",
        "lanlord_image": data['landlord_image'] ?? "",
        "lat_long": data['coordinates'],
      };
      unitRating.value = {
        "total_reviews": data['ratings']['total_reviews'],
        "overall_average": data['ratings']['overall_average'],
      };
      reviewCategory[0]['rating'] = data['ratings']['accuracy'];
      reviewCategory[1]['rating'] = data['ratings']['communication'];
      reviewCategory[2]['rating'] = data['ratings']['cleanliness'];
      reviewCategory[3]['rating'] = data['ratings']['check_in'];
      reviewCategory[4]['rating'] = data['ratings']['maturity'];
      isPalceRequest.value = data['unit_request'];
      isExitRequest.value = data['exit_request'];
      isRatingDone.value = data['ratings_added'];
      reviewList.addAll(data['reviews']);
      unitImageList.addAll(data['images']);
      amenitiesList.addAll(data['amenities']);
      // final data = response.data;
      // unitRating.value = {
      //   "total_reviews": data['ratings']['total_reviews'],
      //   "overall_average": data['ratings']['overall_average'],
      // };
      // reviewCategory[0]['rating'] = data['ratings']['accuracy'];
      // reviewCategory[1]['rating'] = data['ratings']['communication'];
      // reviewCategory[2]['rating'] = data['ratings']['cleanliness'];
      // reviewCategory[3]['rating'] = data['ratings']['check_in'];
      // reviewCategory[4]['rating'] = data['ratings']['maturity'];

      // reviewList.addAll(data['reviews']);
    } else {
      unitDetailsLoading.value = false;
    }
  }
}
