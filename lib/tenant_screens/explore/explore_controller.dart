import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/explore/search_modal.dart';

class ExploreController extends GetxController {
  final exploreSearch = <Property>[].obs;
  final exploreSearchItemSelected = Rx<Property?>(null);
 final serachPropertyController=TextEditingController().obs;
  final isDataSearch = false.obs;

  final getUnitResult = [].obs;

  getPropertyBySearchLocation(String searchValue) async {
    isDataSearch.value = true;

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
      url: "$getExplore$searchValue",
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      if (data.isNotEmpty) {
        exploreSearch.value = data
            .map((item) =>
                Property(id: item['id'], title: item['title'].toString()))
            .toList();
        getUnitResult.clear();

        // Reset the selected item since the search results have been updated
        exploreSearchItemSelected.value = null;
      } else {
        exploreSearch.value = [Property(id: -1, title: 'no_properties_found'.tr)];
        exploreSearchItemSelected.value = null;
        getUnitResult.clear();
      }

      isDataSearch.value = false;
    } else {
      exploreSearch.value = [Property(id: -1, title: 'no_properties_found'.tr)];
      exploreSearchItemSelected.value = null;
      getUnitResult.clear();

      isDataSearch.value = false;
    }
  }

  final getUnitByPropertySearchLoading = false.obs;

  onTapSearchProperty() {
    if (exploreSearchItemSelected.value != null) {
      if (exploreSearchItemSelected.value!.id != -1) {
        getUnitSearchByProperty();
      } else {
        customSnackBar(Get.context!, "property_not_selected".tr);
      }
    } else {
      customSnackBar(Get.context!, "property_not_selected".tr);
    }
  }

  getUnitSearchByProperty() async {
    getUnitByPropertySearchLoading.value = true;

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
      url: "$getUnitByPropertySearch${exploreSearchItemSelected.value?.id}",
    );
    if (response.statusCode == 200) {
      getUnitResult.clear();
      getUnitResult.addAll(response.data);
      getUnitByPropertySearchLoading.value = false;
    } else {
      getUnitByPropertySearchLoading.value = false;
    }
  }

  addFavouriteUnit(int unitId, int index) async {

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioPostCall(
      body: {"unit": unitId},
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: makeUnitFavourite,
    );
    if (response.statusCode == 200) {
      if (response.data['message'] == "Unit added as favorite") {
        getUnitResult[index]['favorite'] = true;
      }
      if (response.data['message'] == "Unit removed from favorites") {
        getUnitResult[index]['favorite'] = false;
      }

      getUnitResult.refresh();
    } else {}
  }
}
