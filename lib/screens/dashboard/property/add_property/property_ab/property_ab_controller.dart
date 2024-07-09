import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_building/add_%20building_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/floor/floor_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class PropertyAbCntroller extends GetxController {
  final buildingList = [
    // {'buildingTitle': 'Building 1', 'floor': '10', 'isFeatured': true},
    // {'buildingTitle': 'Building 2', 'floor': '10', 'isFeatured': true},
    // {'buildingTitle': 'Building 3', 'floor': '10', 'isFeatured': true},
  ].obs;

  final isBuildingDataListLoading = true.obs;

  final propertyId = 0.obs;
  final propertyName="".obs;

  //asda

  @override
  void onInit() {
    propertyId.value = Get.arguments[0];
    propertyName.value = Get.arguments[1];
    getBuildingData();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddBuildingView(), arguments: [propertyId.value])
        ?.then((value) {
      if (value == true) {
        getBuildingData();
      }
    });
  }

  onListTap({
    required int buildingId,
    required String buildingName,
  }) {
    Get.to(() => FloorView(), arguments: [buildingId, buildingName]);
  }

  getBuildingData() async {
    isBuildingDataListLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
    }, url: "$getOrAddPropertyList${propertyId.value}/");
    if (response != null) {
      if (response.statusCode == 200) {
        buildingList.clear();
        buildingList.addAll(response.data['buildings']);

        isBuildingDataListLoading.value = false;
      } else if (response.statusCode == 400) {}
    }
  }
}
