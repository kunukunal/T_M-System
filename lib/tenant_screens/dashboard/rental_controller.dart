import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class RentalController extends GetxController {
  @override
  onInit() {
    final now = DateTime.now();
    rentFrom.value = DateTime(now.year, now.month);
    getRentalData();

    super.onInit();
  }

  final paymentHistoryList = [].obs;
  final rentData = {}.obs;
  final isRentalDataLaoding = false.obs;
  final rentFrom = Rxn<DateTime>();

  final month = 8.obs;
  final year = 2024.obs;

  getRentalData() async {
    isRentalDataLaoding.value = true;
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
          "${paymentHistory}month=${rentFrom.value!.month}&year=${rentFrom.value!.year}",
    );
    if (response.statusCode == 200) {
      final data = response.data;
      paymentHistoryList.clear();
      paymentHistoryList.addAll(data);
      isRentalDataLaoding.value = false;
    } else {
      isRentalDataLaoding.value = false;
    }
  }

  Future<void> selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: rentFrom.value ?? DateTime.now(),
      firstDate: DateTime(2023, 1), // You can adjust the start date
      lastDate: DateTime(2101),
      helpText: 'Select month and year', // Custom help text
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header color

            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      rentFrom.value = DateTime(picked.year, picked.month);
      getRentalData();
    }
  }
}
