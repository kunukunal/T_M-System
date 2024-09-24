import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_unit/add_unit_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class UnitCntroller extends GetxController {
  final unitList = [].obs;
  final isUnitLoaded = false.obs;
  final floorId = 0.obs;
  final floorName = "".obs;
  final buildingName = "".obs;

  final isBackNeeded = false.obs;

  final buildingAmenties = {}.obs;

  @override
  void onInit() {
    floorId.value = Get.arguments[0];
    floorName.value = Get.arguments[1];
    buildingAmenties.value = Get.arguments[2];
    buildingName.value = Get.arguments[3];
    isBackNeeded.value = false;
    getAllUnit();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddUnitView(),
            arguments: [floorId.value, false, buildingAmenties])!
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
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: '$deleteFloor${floorId.value}/');
    if (response != null) {
      if (response.statusCode == 200) {
        unitList.clear();
        unitList.addAll(response.data['units']);
        if (unitList.isEmpty) {
          Get.to(() => AddUnitView(),
                  arguments: [floorId.value, false, buildingAmenties])
              ?.then((value) {
            if (value) {
              Get.back(result: true);
              isBackNeeded.value = true;
            }
          });
        }
        isUnitLoaded.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteUnitData({required int unitId}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
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
