import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class UnitCntroller extends GetxController {
  final unitList = [].obs;
  final isUnitLoaded = false.obs;
  final floorId = 0.obs;
  final floorName = "".obs;

  @override
  void onInit() {
    floorId.value = Get.arguments[0];
    floorName.value = Get.arguments[1];
    getAllFloor();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddUnitView(), arguments: [floorId.value])!.then((value) {
      if (value == true) {
        getAllFloor();
      }
    });
  }

  onItemTap() {
    // Get.to(() => AddUnitView());
  }

  getAllFloor() async {
    isUnitLoaded.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
    }, url: '$deleteFloor${floorId.value}/');
    if (response != null) {
      if (response.statusCode == 200) {
        unitList.clear();
        unitList.addAll(response.data['units']);
        isUnitLoaded.value = false;
      } else if (response.statusCode == 400) {}
    }
  }
}
