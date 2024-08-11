import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/services/dio_client_service.dart';

import '../language/language.dart';

class WalkThroughController extends GetxController {
  //variables
  final pageController = PageController().obs;
  final initialPage = 0.obs;

  final walkThrougImageList = [].obs; //functions
  final isBannerDataLoading = true.obs;

  @override
  void onInit() {
    pageController.value.addListener(() {
      initialPage.value = pageController.value.page!.round();
    });

    getWalkThroughData();
    super.onInit();
  }

  onGetStartedTap() {
    Get.to(() => LanguageScreen(
          isFromProfile: false,
        ));
  }

  getWalkThroughData() async {
    final response = await DioClientServices.instance.dioGetCall(
        headers: {"Accept-Language": "en"},
        url: "$banner?limit=100&banner_type=1");
    if (response != null) {
      if (response.statusCode == 200) {
        final data = response.data;
        for (int i = 0; i < data['results'].length; i++) {
          walkThrougImageList.add(data['results'][i]);
          isBannerDataLoading.value = false;
        }
        log("Banner data get Successfully.");
      }
    }
  }
}
