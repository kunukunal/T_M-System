import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_view.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_detail_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';

import '../../../../common/widgets.dart';

class TenantListController extends GetxController {
  //variables
  final tenantList = [].obs;

  //functions
  Future<bool> onTenantDelete() {
    return resgisterPopup(
      title: 'Delete',
      subtitle: 'Are you sure you want to delete',
      button1: 'Cancel',
      button2: 'Yes, Delete',
      onButton1Tap: () {
        Get.back();

        return false;
      },
      onButton2Tap: () {
        Get.back();
        return true;
      },
    );
  }

  @override
  onInit() {
    super.onInit();
    getKireyderList();
  }

  final goesForAddConatct = false.obs;
  onTenantTap(int kireyderId) {
    Get.to(() => TenantDetailScreen(), arguments: [kireyderId])!.then((value) {
      if (value) {
        getKireyderList();
      }
    });
  }

  final kireyderListLoading = false.obs;
  getKireyderList() async {
    kireyderListLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: kirayedarList,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        kireyderListLoading.value = false;
        tenantList.clear();
        tenantList.addAll(response.data);
        if (tenantList.isEmpty) {
          Get.off(() => AddTenantScreen(), arguments: [
            false,
            {},
            {'isEdit': false}
          ]);
        }
      } else if (response.statusCode == 400) {
        kireyderListLoading.value = false;
        // Handle error
      } else {
        kireyderListLoading.value = false;
      }
    }
  }
}
