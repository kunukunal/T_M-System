import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

import '../floor_detail/floor_detail_view.dart';

class PropertyDetailCntroller extends GetxController {
  final items = [
    // {
    //   'propTitle': ' A',
    //   'propDesc': '2118 Thornridge Cir. Syracuse, Connecticut',
    //   'availablityTitle': '20 Units(Available)',
    //   'occupiedTitle': '80 Units(Occupied)',
    //   'isOccupied': false
    // },
    // {
    //   'propTitle': ' B',
    //   'propDesc': '2464 Royal Ln. Mesa, New Jersey 45463',
    //   'availablityTitle': '20 Units(Available)',
    //   'occupiedTitle': '80 Units(Occupied)',
    //   'isOccupied': false
    // },
    // {
    //   'propTitle': ' C',
    //   'propDesc': '2972 Westheimer Rd. Santa Ana, Illinois 854',
    //   'availablityTitle': '20 Units(Available)',
    //   'occupiedTitle': '80 Units(Occupied)',
    //   'isOccupied': false
    // },
  ].obs;

  // final floorList = <Map>[
  //   {'floorTitle': ' A', 'floorrate': '5/10'},
  //   {'floorTitle': ' B', 'floorrate': '16/20'},
  //   {'floorTitle': ' C', 'floorrate': '13/15'},
  //   {'floorTitle': ' D', 'floorrate': '7/13'}
  // ].obs;

  final isExpand = false.obs;

  RxInt selectedIndex = 0.obs;

  final propertId = 0.obs;
  final propertTitle = "".obs;
  final isPropertyBuildingStatsLoading = false.obs;

  final isRefreshmentRequired = false.obs;
  @override
  void onInit() {
    super.onInit();
    propertId.value = Get.arguments[0];
    propertTitle.value = Get.arguments[1];
    getPropertyManagementStats();
  }

  onBuildingTap(int id, String floorName) {
    Get.to(() => FloorDetailView(), arguments: [id, floorName])!.then((value) {
      print("jhjhjh ${value}");
      if (value==true) {
        isRefreshmentRequired.value = value!;
        getPropertyManagementStats();
      }
    });
  }

  getPropertyManagementStats() async {
    isPropertyBuildingStatsLoading.value = true;


    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";            String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
              "Accept-Language": languaeCode,

      },
      url: "$propertyBuildingStatistics${propertId.value}/building-statistics/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isPropertyBuildingStatsLoading.value = false;
        print("${response.data}");
        items.clear();
        items.addAll(response.data);
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
