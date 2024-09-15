import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
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

  //functions
  onFloatingButtonAddTap() {
    isAddTap.value = true;
  }

  onFloatingButtonCrossTap() {
    isAddTap.value = false;
  }

  @override
  onInit() {
    getDashboardData();
    super.onInit();
  }

  onAddPropertyTap() {
    print("sdadasdas");
    isAddTap.value = false;
    //  Get.to(()=>AddPropertyView());
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
  final expenseBox = 0.0.obs;
  List<String> xIncomeExpenseLabels = [];
  List<int> income = [];
  List<int> expense = [];
  List<String> xOccupancyTrendLabels = [];
  List<int> rentPaid = [];
  List<int> rentDue = [];

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
      expenseBox.value = data['expense'].toDouble() ?? 0.0;
      Map<String, dynamic> incomeData = data['income_data'];
      xIncomeExpenseLabels =
          incomeData.keys.map((key) => capitalize(key)).toList();
      income = incomeData.values.map((values) {
        num value = values[0];
        return value.toInt();
      }).toList();
      expense = incomeData.values.map((values) {
        num value = values[1];
        return value.toInt();
      }).toList();
      Map<String, dynamic> occupancyTrend = data['occupancy_trend'];
      xOccupancyTrendLabels =
          occupancyTrend.keys.map((key) => capitalize(key)).toList();
      rentPaid =
          occupancyTrend.values.map((values) => values[0] as int).toList();
      rentDue =
          occupancyTrend.values.map((values) => values[1] as int).toList();
      proprtyList.addAll(data['properties']);
      isDashboardDataLaoding.value = false;
    } else {
      isDashboardDataLaoding.value = false;
    }
  }

  String capitalize(String key) {
    return "${key[0].toUpperCase()}${key.substring(1)}";
  }
}
