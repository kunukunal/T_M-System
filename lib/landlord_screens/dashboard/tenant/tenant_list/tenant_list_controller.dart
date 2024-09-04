import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/tenant_list/tenant_detail_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

import '../../../../common/widgets.dart';

class TenantListController extends GetxController {
  //variables
  final tenantList = [].obs;

  //functions
  Future<bool> onTenantDelete() {
    return resgisterPopup(
      title: 'delete'.tr,
      subtitle: 'are_you_sure_delete'.tr,
      button1: 'cancel'.tr,
      button2: 'yes_delete'.tr,
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

final kiryedarSearchController=TextEditingController().obs;

  final isFromDashbordFloating = false.obs;
  @override
  onInit() {
    super.onInit();
    // isFromDashbordFloating.value =
    //     Get.arguments != null ? Get.arguments[0] : false;
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

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

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
        // if (isFromDashbordFloating.value) {
        // if (tenantList.isEmpty) {
        //   Get.off(() => AddTenantScreen(), arguments: [
        //     false,
        //     {},
        //     {'isEdit': false}
        //   ]);
        // }
        // }
      } else if (response.statusCode == 400) {
        kireyderListLoading.value = false;
        // Handle error
      } else {
        kireyderListLoading.value = false;
      }
    }
  }
}
