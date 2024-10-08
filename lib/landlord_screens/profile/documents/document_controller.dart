import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/tenant_documents.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class DocumentController extends GetxController {
  final documentList = [
    // {'name': 'Aadhar card.png', 'image': aadharImage},
    // {'name': 'Police Verification.pdf', 'image': policeVerificationImage},
    // {'name': 'Police Verification.pdf', 'image': policeVerification2Image},
  ].obs;

  final userId = 0.obs;

  final isFromTenant = false.obs;

  final islandLord = false.obs;
  @override
  void onInit() {
    isFromTenant.value = Get.arguments[0];
    userId.value = Get.arguments[1];
    islandLord.value = Get.arguments[2];
    getDocumentById();

    super.onInit();
  }

  final kiryederDocumentLoading = false.obs;

  getDocumentById() async {
    kiryederDocumentLoading.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Accept-Language": languaeCode,
        "Content-Type": "application/json"
      },
      url: isFromTenant.value ? "$userDocument${userId.value}/" : userDocument,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        documentList.clear();
        documentList.addAll(response.data);
        if (isFromTenant.value == false) {
          if (documentList.isEmpty) {
            Get.off(() => TenantDocScreen(), arguments: [
              userId.value,
              false,
              {'isEdit': false, 'isConsent': true},
              !islandLord.value
            ]);
          }
        }

        kiryederDocumentLoading.value = false;
      } else if (response.statusCode == 400) {
        kiryederDocumentLoading.value = false;
        // Handle error
      } else {
        kiryederDocumentLoading.value = false;
      }
    }
  }
}
