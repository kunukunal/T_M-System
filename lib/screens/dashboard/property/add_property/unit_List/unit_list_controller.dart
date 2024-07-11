import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_unit/add_unit_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class UnitCntroller extends GetxController {
  final unitList = [].obs;
  final isUnitLoaded = false.obs;
  final floorId = 0.obs;
  final floorName = "".obs;

  final isBackNeeded = false.obs;

  @override
  void onInit() {
    floorId.value = Get.arguments[0];
    floorName.value = Get.arguments[1];
    isBackNeeded.value = false;
    getAllUnit();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddUnitView(), arguments: [floorId.value, false, {}])!
        .then((value) {
      if (value == true) {
        isBackNeeded.value = true;
        getAllUnit();
      }
    });
  }

  onEditTap(Map item) {
    Get.to(() => AddUnitView(), arguments: [floorId.value, true, item])!
        .then((value) {
      if (value == true) {
        getAllUnit();
      }
    });
  }

  onItemTap() {
    // Get.to(() => AddUnitView());
  }

  getAllUnit() async {
    isUnitLoaded.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
    }, url: '$deleteFloor${floorId.value}/');
    if (response != null) {
      if (response.statusCode == 200) {
        print("fdsfds ${response.data}");

        unitList.clear();
        unitList.addAll(response.data['units']);
        isUnitLoaded.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteUnitData({required int unitId}) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
    }, url: "$addUnit$unitId/");
    if (response != null) {
      if (response.statusCode == 200) {
        isBackNeeded.value = true;
        getAllUnit();
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }
}
