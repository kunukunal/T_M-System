import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/expense/add_expense/add_expense_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class ExpenseController extends GetxController {
  //variables
  final expenseList = [].obs;

  //Functions
  onAddTap() {
    Get.to(() => AddExpenseScreen(), arguments: [false, {}])!.then((value) {
      if (value == true) {
        getExpenseData();
      }
    });
  }

  onEditTap(Map item) {
    Get.to(() => AddExpenseScreen(), arguments: [true, item])!.then((value) {
      if (value == true) {
        getExpenseData();
      }
    });
  }

  onDeleteTap(int expenseId) {
    deleteExpense(expenseId);
  }

  final isExpenseDataget = false.obs;
  final istotalExpense = 0.0.obs;

  final expnseStartFrom = Rxn<DateTime>();
  final expnseEndFrom = Rxn<DateTime>();

  @override
  onInit() {
    super.onInit();
    setMonthStartAndEndDates();
  }

  void setMonthStartAndEndDates() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    expnseStartFrom.value = firstDayOfMonth;
    expnseEndFrom.value = lastDayOfMonth;
    getExpenseData();
  }

  getExpenseData() async {
    isExpenseDataget.value = true;
    String startDate =
        "${expnseStartFrom.value?.year}-${expnseStartFrom.value?.month.toString().padLeft(2, '0')}-${expnseStartFrom.value?.day.toString().padLeft(2, '0')}";
    String endDate =
        "${expnseEndFrom.value?.year}-${expnseEndFrom.value?.month.toString().padLeft(2, '0')}-${expnseEndFrom.value?.day.toString().padLeft(2, '0')}";

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: "$expenseFilter?date_from=$startDate&date_to=$endDate"
        // getAllExpense

        );
    if (response != null) {
      if (response.statusCode == 200) {
        expenseList.clear();
        expenseList.addAll(response.data['history']);
        istotalExpense.value =
            response.data['total_month_expense'].toDouble() ?? 0.0;
        isExpenseDataget.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteExpense(int expenseId) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: "$getAllExpense$expenseId/");
    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, response.data['message']);

        getExpenseData();
        isExpenseDataget.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  searchByDates() {
    if (expnseStartFrom.value != null && expnseEndFrom.value != null) {
      if (expnseStartFrom.value!.isBefore(expnseEndFrom.value!) &&
          !expnseStartFrom.value!.isAtSameMomentAs(expnseEndFrom.value!)) {
        getExpenseData();
      } else {
        customSnackBar(Get.context!, "select_date_range".tr);
      }
    } else {
      customSnackBar(Get.context!, "date_range_null".tr);
    }
  }

  Future<void> selectMonthYear(BuildContext context, bool isRent) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isRent == true
          ? expnseStartFrom.value ?? DateTime.now()
          : expnseEndFrom.value ?? DateTime.now(),
      firstDate: DateTime(2023, 1), // You can adjust the start date
      lastDate: DateTime(2101),
      helpText: 'select_month_year'.tr, // Custom help text
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
      if (isRent) {
        expnseStartFrom.value = picked;
      } else {
        expnseEndFrom.value = picked;
      }
    }
  }
}
