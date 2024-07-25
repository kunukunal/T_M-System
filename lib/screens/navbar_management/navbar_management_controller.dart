import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/screens/dashboard/search/search_view.dart';
import 'package:tanent_management/screens/navbar_management/property_detail/property_detail_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class NavBarManagementCntroller extends GetxController {
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
  onSearchTap() {
    Get.to(() => SearchView());
  }

  onItemTap(int propertyId, String propertyTitle) {
    Get.to(() => PropertyDetailView(),arguments: [propertyId,propertyTitle]);
  }

  final isPropertyStatsLoading = false.obs;
  final totalOccupiedUnits = 0.obs;
  final totalUnOccupiedUnits = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("dlasklskaasd");
    getPropertyManagementStats();
  }

  getPropertyManagementStats() async {
    isPropertyStatsLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
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
        items.value = response.data['properties'];
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
