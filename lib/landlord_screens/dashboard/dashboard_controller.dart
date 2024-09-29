import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/utils.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_list/property_list_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_list_view.dart';
import 'package:tanent_management/landlord_screens/expense/add_expense/add_expense_view.dart';
import 'package:tanent_management/landlord_screens/notification/notification_view.dart';
import 'package:tanent_management/landlord_screens/profile/my_profile/my_profile_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class DashBoardController extends GetxController {
  //variables
  final isAddTap = false.obs;
  final rentFrom = Rxn<DateTime>();

  //functions
  onFloatingButtonAddTap() {
    isAddTap.value = true;
  }

  onFloatingButtonCrossTap() {
    isAddTap.value = false;
  }

  onAddPropertyTap() {
    isAddTap.value = false;
    Get.to(() => PropertyListView());
  }

  onAddTenantTap() {
    isAddTap.value = false;
    Get.to(() => TenantListScreen(), arguments: [true]);
    // Get.to(() => AddTenantScreen());
  }

  onAddExpenseTap() {
    isAddTap.value = false;
    Get.to(() => AddExpenseScreen(), arguments: [false, {}]);
  }

  onSearchTap() {
    Get.to(() => SearchView());
  }

  onNotifTap() {
    Get.to(() => NotificationView());
  }

  onProfileTap() {
    Get.to(() => MyProfileView());
  }

  final proprtyList = [].obs;
  final isDashboardDataLaoding = false.obs;
  Map propertyStats = {"total_units": 0, "occupied_units": 0, "tenants": 0};
  Map rentBox = {"total_rent": 0, "rent_paid": 0, "rent_due": 0};
  final filterrentBox = <String, dynamic>{
    "rent_received": 0.0,
    "total_rent": 0.0,
    "remaining_due": 0.0
  }.obs;
  final filterrentBoxDate = Rxn<DateTime>();

  final expenseBox = 0.0.obs;
  final xIncomeExpenseLabels = [].obs;
  final income = [].obs;
  final expense = [].obs;
  final xOccupancyTrendLabels = [].obs;
  final rentPaid = [].obs;
  final rentDue = [].obs;

  final incomingStartFrom = Rxn<DateTime>();
  final incomingEndFrom = Rxn<DateTime>();
  final occupancyStartFrom = Rxn<DateTime>();
  final occupancyEndFrom = Rxn<DateTime>();

  @override
  onInit() {
    final now = DateTime.now();
    rentFrom.value = DateTime(now.year, now.month);
    // setMonthStartAndEndDates();

    getDashboardData();
    super.onInit();
  }

  searchIncomeExpenseByDates() {
    if (incomingStartFrom.value != null && incomingEndFrom.value != null) {
      if (incomingStartFrom.value!.isBefore(incomingEndFrom.value!) &&
          !incomingStartFrom.value!.isAtSameMomentAs(incomingEndFrom.value!)) {
        incomeFilter();
      } else {
        customSnackBar(Get.context!, "Please select the correct date range");
      }
    } else {
      customSnackBar(Get.context!, "Date range can not be null");
    }
  }

  searchOccupyTreadByDates() {
    if (occupancyStartFrom.value != null && occupancyEndFrom.value != null) {
      if (occupancyStartFrom.value!.isBefore(occupancyEndFrom.value!) &&
          !occupancyStartFrom.value!
              .isAtSameMomentAs(occupancyEndFrom.value!)) {
        occupancyTread();
      } else {
        customSnackBar(Get.context!, "Please select the correct date range");
      }
    } else {
      customSnackBar(Get.context!, "Date range can not be null");
    }
  }

  occupancyTread() async {
    String startDate =
        "${occupancyStartFrom.value?.year}-${occupancyStartFrom.value?.month.toString().padLeft(2, '0')}-${occupancyStartFrom.value?.day.toString().padLeft(2, '0')}";
    String endDate =
        "${occupancyEndFrom.value?.year}-${occupancyEndFrom.value?.month.toString().padLeft(2, '0')}-${occupancyEndFrom.value?.day.toString().padLeft(2, '0')}";

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
      url: "$occupancyFilter?start_date=$startDate&end_date=$endDate",
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> occupancyTrend = response.data;

      // Ensure that the keys (labels) and values (data) have the same length
      List<String> labels =
          occupancyTrend.keys.map((key) => capitalize(key)).toList();
      List<int> paidData =
          occupancyTrend.values.map((values) => values[0] as int).toList();
      List<int> dueData =
          occupancyTrend.values.map((values) => values[1] as int).toList();

      if (labels.length == paidData.length && labels.length == dueData.length) {
        xOccupancyTrendLabels.value = labels;
        rentPaid.value = paidData;
        rentDue.value = dueData;
      } else {
        print("Data length mismatch between labels and data.");
      }
    }
  }

  incomeFilter() async {
    String startDate =
        "${incomingStartFrom.value?.year}-${incomingStartFrom.value?.month.toString().padLeft(2, '0')}-${incomingStartFrom.value?.day.toString().padLeft(2, '0')}";
    String endDate =
        "${incomingEndFrom.value?.year}-${incomingEndFrom.value?.month.toString().padLeft(2, '0')}-${incomingEndFrom.value?.day.toString().padLeft(2, '0')}";

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
      url: "$incomeExpenseFilter?start_date=$startDate&end_date=$endDate",
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> incomeData = response.data;
      xIncomeExpenseLabels.value =
          incomeData.keys.map((key) => capitalize(key)).toList();
      income.value = incomeData.values.map((values) {
        num value = values[0];
        return value.toInt();
      }).toList();
      expense.value = incomeData.values.map((values) {
        num value = values[1];
        return value.toInt();
      }).toList();
    }
  }

  Future<DateTime?> selectDate(DateTime? date) async {
    final today = DateTime.now();
    return await showDatePicker(
      context: Get.context!,
      initialDate: date ?? today,
      firstDate: DateTime(2023, 1), // You can adjust the start date
      lastDate: DateTime(
          today.year, today.month, today.day), // Prevents future date selection
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
  }

  getDashboardData() async {
    isDashboardDataLaoding.value = true;
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
      url: landlordDashboard,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      proprtyList.clear();
      userData = data['user_data'];
      propertyStats = data['property_stats'];
      rentBox = data['rent'];
      filterrentBox.value = data['month_rent'];
      final now = DateTime.now();
      rentFrom.value = DateTime(now.year, now.month);
      expenseBox.value = data['expense'].toDouble() ?? 0.0;
      Map<String, dynamic> incomeData = data['income_data'];
      xIncomeExpenseLabels.value =
          incomeData.keys.map((key) => capitalize(key)).toList();
      income.value = incomeData.values.map((values) {
        num value = values[0];
        return value.toInt();
      }).toList();
      expense.value = incomeData.values.map((values) {
        num value = values[1];
        return value.toInt();
      }).toList();
      Map<String, dynamic> occupancyTrend = data['occupancy_trend'];
      xOccupancyTrendLabels.value =
          occupancyTrend.keys.map((key) => capitalize(key)).toList();
      rentPaid.value =
          occupancyTrend.values.map((values) => values[0] as int).toList();
      rentDue.value =
          occupancyTrend.values.map((values) => values[1] as int).toList();
      proprtyList.addAll(data['properties']);
      incomingStartFrom.value = null;
      incomingEndFrom.value = null;
      occupancyStartFrom.value = null;
      occupancyEndFrom.value = null;
      filterrentBoxDate.value = null;
      isDashboardDataLaoding.value = false;
    } else {
      isDashboardDataLaoding.value = false;
    }
  }

  String capitalize(String key) {
    return "${key[0].toUpperCase()}${key.substring(1)}";
  }

  getExpenseFilter() async {
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
          "$expnseFilter?month=${rentFrom.value?.month}&year=${rentFrom.value?.year}",
    );
    if (response != null) {
      if (response.statusCode == 200) {
        expenseBox.value = response.data['expense'].toDouble() ?? 0.0;
      }
    }
  }

  getRentBoxFilter() async {
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
          "$rentMonthFilter?month=${filterrentBoxDate.value?.month}&year=${filterrentBoxDate.value?.year}",
    );
    if (response != null) {
      if (response.statusCode == 200) {
        filterrentBox.value = response.data;
      }
    }
  }

  Future<void> monthFilter(BuildContext context,
      {bool isFromExpense = true}) async {
    final DateTime? picked = await selectMonthYear(context);
    if (picked != null) {
      if (isFromExpense) {
        rentFrom.value = DateTime(picked.year, picked.month);
        getExpenseFilter();
      } else if (isFromExpense == false) {
        filterrentBoxDate.value = DateTime(picked.year, picked.month);
        getRentBoxFilter();
      }
    }
  }
}
