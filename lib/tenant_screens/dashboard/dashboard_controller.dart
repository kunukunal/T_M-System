import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/landlord_screens/notification/notification_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_request_view.dart';

class DashBoardTenantController extends GetxController {
  //variables
  final isAddTap = false.obs;
  final isExpanded = true.obs;
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

  onNotifTap() {
    Get.to(() => NotificationView());
  }

 onTapPayRent(Map unitData) {
    Get.to(() => PaymentRequestScreen(),arguments: [unitData]);
  }


  final unitList = [].obs;
  final paymentHistoryList = [].obs;
  final rentData = {}.obs;
  final isDashboardDataLaoding = false.obs;

  getDashboardData() async {
    isDashboardDataLaoding.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: tenantDashboard,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      userData = data['user_data'];
      unitList.clear();
      paymentHistoryList.clear();
      unitList.addAll(data['units']);
      paymentHistoryList.addAll(data['payment_history']);
      rentData.value = data['rent'];
      isDashboardDataLaoding.value = false;
    } else {
      isDashboardDataLaoding.value = false;
    }
  }
}