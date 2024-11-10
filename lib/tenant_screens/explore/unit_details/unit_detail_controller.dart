import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class UnitDetailViewController extends GetxController {
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
  final unitIdDetails = 0.obs;

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
    unitIdDetails.value = Get.arguments[0];
    isFromDashboard.value = Get.arguments[1];

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
    "landlord_mobile": "",
    "landlord_email": "",
    "landlord_address": "",
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
      url: "$getUnitDetailsData${unitIdDetails.value}/",
    );
    if (response.statusCode == 200) {
      log("dasklksal ${response.data}");
      unitDetailsLoading.value = false;
      final data = response.data;
      unitData.value = {
        "unit_name": data['name'] ?? "",
        "unit_info": data['unit_info'] ?? "",
        "unit_rent": data['unit_rent'] ?? "",
        "unit_address": data['address'] ?? "",
        "available_from": data['available_from'] ?? "",
        "lanlord_name": data['landlord'] ?? "",
        "lanlord_image": data['landlord_image'] ?? "",
        "landlord_mobile": data['landlord_mobile'] ?? "",
        "landlord_email": data['landlord_email'] ?? "",
        "landlord_address": data['landlord_address'] ?? "",
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
    } else {
      unitDetailsLoading.value = false;
    }
  }

  final isRequestUnitPlaceOrExit = false.obs;

  sendUnitRequest() async {
    isRequestUnitPlaceOrExit.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {"unit": unitIdDetails.value},
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: teantUnitRequest,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      customSnackBar(Get.context!, data['message']);
      isPalceRequest.value = true;
      isRequestUnitPlaceOrExit.value = false;
    } else {
      isRequestUnitPlaceOrExit.value = false;
    }
  }

  sendUnitExitRequest() async {
    isRequestUnitPlaceOrExit.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {"unit": unitIdDetails.value},
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: tenantUnitExit,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      customSnackBar(Get.context!, data['message']);
      isExitRequest.value = true;
      isRequestUnitPlaceOrExit.value = false;
    } else {
      isRequestUnitPlaceOrExit.value = false;
    }
  }

  final isReviewSubmitted = false.obs;
  sendReview() async {
    isReviewSubmitted.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "unit": unitIdDetails.value,
        "accuracy": rateUnit[0]['rating'],
        "communication": rateUnit[1]['rating'],
        "cleanliness": rateUnit[2]['rating'],
        "check_in": rateUnit[3]['rating'],
        "maturity": rateUnit[4]['rating'],
        "review": reviewController.value.text.trim()
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: submitRating,
    );
    if (response.statusCode == 201) {
      final data = response.data;
      Get.back();
      getUnitDetails();
      print("sdklsajdjasld ${data}");
      // customSnackBar(Get.context!, data['message']);
      isRatingDone.value = true;
      isReviewSubmitted.value = false;
    } else {
      isReviewSubmitted.value = false;
    }
  }
}
