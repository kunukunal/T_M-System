import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/notification/notification_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
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
    Get.to(() => NotificationView())?.then((value) {
      print("fdsklakdsa ${value}");
      if (value == true) {
        getDashboardData();
      }
    });
  }

  onTapPayRent(Map unitData) {
    print("jjjkkjk ${unitData}");
    Get.to(() => PaymentRequestScreen(), arguments: [unitData])!.then((value) {
      if (value) {
        getDashboardData();
      }
    });
  }

  final unitList = [].obs;
  final paymentHistoryList = [].obs;
  final rentData = {}.obs;
  final isDashboardDataLaoding = false.obs;
  final notificationCount = 0.obs;

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
      url: tenantDashboard,
    );
    if (response.statusCode == 200) {
      final data = response.data;
      userData = data['user_data'];
      notificationCount.value = data['unread_notifications'];
      unitList.clear();
      paymentHistoryList.clear();
      unitList.addAll(data['units']);
      print("dasklk ${unitList}");
      paymentHistoryList.addAll(data['payment_history']);
      rentData.value = data['rent'];
      isDashboardDataLaoding.value = false;
    } else {
      isDashboardDataLaoding.value = false;
    }
  }
}
