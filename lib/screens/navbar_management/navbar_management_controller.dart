import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/screens/dashboard/search/search_view.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class NavBarManagementCntroller extends GetxController {
  final items = [].obs;
  onSearchTap() {
    Get.to(() => SearchView());
  }

  final isRefreshmentRequired = false.obs;

  onItemTap(int propertyId, String propertyTitle) {
    Get.to(() => PropertyDetailView(), arguments: [propertyId, propertyTitle])!
        .then((value) {
          print("sdldkaslkdsla ${value}");
      if (value==true) {
        isRefreshmentRequired.value = true;
        getPropertyManagementStats();
      }
    });
  }

  final isPropertyStatsLoading = false.obs;
  final totalOccupiedUnits = 0.obs;
  final totalUnOccupiedUnits = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getPropertyManagementStats();
  }

  getPropertyManagementStats() async {
    print("hhkhkhkhk");
    isPropertyStatsLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
        String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
              "Accept-Language": languaeCode,

      },
      url: propertyStatistics,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isPropertyStatsLoading.value = false;
        items.clear();

        print("dslkdlasdkd ${response.data}");
        totalOccupiedUnits.value = response.data['occupied_units'];
        totalUnOccupiedUnits.value = response.data['available_units'];
        items.addAll(response.data['properties']);  
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
