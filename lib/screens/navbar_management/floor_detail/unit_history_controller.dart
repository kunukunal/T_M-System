import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class UnitHistoryController extends GetxController {
  final items = [].obs;
  final unitHistoryLoading = false.obs;

  final unitId = 0.obs;
  final totalRent = "".obs;
  final unitName = "".obs;
  final buildinName = "".obs;
  final propertyName = "".obs;
  final floorName = "".obs;
  @override
  onInit() {
    unitId.value = Get.arguments[0];
    getUnitsStats();
    super.onInit();
  }

  getUnitsStats() async {
    unitHistoryLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: "$unitHistory?unit_id=${unitId.value}",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        unitHistoryLoading.value = false;
        items.clear();
        if (response.data.isNotEmpty) {
          final data = response.data[0];
          unitName.value = data['unit'];

          buildinName.value = data['building'];
          propertyName.value = data['property'];

          floorName.value = data['floor'];
          totalRent.value = data['total_rent'].toString();
          items.addAll(data['tenants']);
        }

      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
