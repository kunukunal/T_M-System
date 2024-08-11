import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class UnitDetailViewController extends GetxController {
  final amenitiesList = [].obs;

  final reviewCategory = [
    {'name': 'Accuracy', "rating": 0.0},
    {'name': 'Communication', "rating": 0.0},
    {'name': 'Cleanliness', "rating": 0.0},
    {'name': 'Check-in', "rating": 0.0},
    {'name': 'Maturity', "rating": 0.0},
  ].obs;

  final pageController = PageController().obs;
  final initialPage = 0.obs;
  final unitIdDetails = 0.obs;

  @override
  void onInit() {
    pageController.value.addListener(() {
      initialPage.value = pageController.value.page!.round();
    });
    unitIdDetails.value = Get.arguments[0];
    getUnitDetails();
    super.onInit();
  }

  final unitDetailsLoading = false.obs;
  final unitImageList = [].obs;
  final unitData = {
    "unit_name": "",
    "unit_rent": "",
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
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$getUnitDetailsData${unitIdDetails.value}/",
    );
    if (response.statusCode == 200) {
      log("dasklksal ${response.data}");
      unitDetailsLoading.value = false;
      final data = response.data;
      unitData.value = {
        "unit_name": data['name'] ?? "",
        "unit_rent": data['unit_rent'] ?? "",
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

      reviewList.addAll(data['reviews']);
      unitImageList.addAll(data['images']);
      amenitiesList.addAll(data['amenities']);
    } else {
      unitDetailsLoading.value = false;
    }
  }
}
