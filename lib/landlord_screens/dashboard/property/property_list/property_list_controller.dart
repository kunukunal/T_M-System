import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_property_view.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/property_ab/property_ab_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class PropertyListController extends GetxController {
  final propertyList = [
    // {
    //   'propertyTitle': 'Azure House',
    //   'location': '39 Rue Louis Guiotton 44300 Nantes',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
    // {
    //   'propertyTitle': 'Tranquil Hut',
    //   'location': '27 Rue Octave Feuillet 44000 Nantes',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
    // {
    //   'propertyTitle': 'Mountain Fabric',
    //   'location': '3 Montée du Château 69720 Saint-Bonnet-de-Mure',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
    // {
    //   'propertyTitle': 'Azure House',
    //   'location': '39 Rue Louis Guiotton 44300 Nantes',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
    // {
    //   'propertyTitle': 'Tranquil Hut',
    //   'location': '27 Rue Octave Feuillet 44000 Nantes',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
    // {
    //   'propertyTitle': 'Mountain Fabric',
    //   'location': '3 Montée du Château 69720 Saint-Bonnet-de-Mure',
    //   'icon': 'assets/icons/location.png',
    //   'buildingIcon': 'assets/icons/a.png',
    //   'isFeatured': true
    // },
  ].obs;
  final isPropertyDataListLoading = true.obs;

  @override
  void onInit() {
    getPropertyListData();
    super.onInit();
  }

  onAddTap() {
    Get.to(() => AddPropertyView(), arguments: [false, {}])!.then((value) {
      if (true) {
        getPropertyListData();
      }
    });
  }

  onEditTap(Map item) {
    Get.to(() => AddPropertyView(), arguments: [true, item])!.then((value) {
      if (true) {
        getPropertyListData();
      }
    });
  }

  onItemTap({required int id, required String propertyTitle}) {
    Get.to(() => PropertyAb(), arguments: [
      id,
      propertyTitle,
    ]);
  }

  getPropertyListData() async {
    isPropertyDataListLoading.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: getOrAddPropertyList);
    if (response != null) {
      if (response.statusCode == 200) {
        propertyList.clear();
        propertyList.addAll(response.data);
        print("sdaldksadasdsada");
        if (propertyList.isEmpty) {
          Get.off(() => AddPropertyView(), arguments: [false, {}])!
              .then((value) {
            if (value == true) {
              final dashCntrl = Get.find<DashBoardController>();
              dashCntrl.getDashboardData();
            }
            print("asdsadldksaldkasld ${value}");
          });
        }
        isPropertyDataListLoading.value = false;
      } else if (response.statusCode == 400) {
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }

  deletePropertyData({required int propertyId}) async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: "$getOrAddPropertyList$propertyId/");
    if (response != null) {
      if (response.statusCode == 200) {
        getPropertyListData();
        customSnackBar(Get.context!, response.data['message']);
      } else if (response.statusCode == 400) {
        if (response.data.toString().contains("occupied_units")) {
          customSnackBar(Get.context!, response.data['occupied_units']);
        }
      }
    }
  }
}
