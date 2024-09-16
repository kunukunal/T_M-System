import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/utils.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class ReportController extends GetxController {
  final reportList = [].obs;
  final isReportDataloading = false.obs;
  final rentFrom = Rxn<DateTime>();

  @override
  void onInit() {
    final now = DateTime.now();
    rentFrom.value = DateTime(now.year, now.month);
    getReportData();
    super.onInit();
  }

  getReportData() async {
    isReportDataloading.value = true;

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
      url:
          "$report?month=${rentFrom.value?.month}&year=${rentFrom.value?.year}",
    );
    if (response.statusCode == 200) {
      final data = response.data;
      log("|kasdkal $data");
      reportList.clear();
      reportList.addAll(data);
      isReportDataloading.value = false;
    } else {
      isReportDataloading.value = false;
    }
  }

  Future<void> monthFilter(BuildContext context) async {
    final DateTime? picked = await selectMonthYear(context);
    if (picked != null) {
      rentFrom.value = DateTime(picked.year, picked.month);
      getReportData();
    }
  }
}
