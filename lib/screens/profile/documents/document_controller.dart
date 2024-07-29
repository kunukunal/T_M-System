import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class DocumentController extends GetxController {
  final documentList = [
    // {'name': 'Aadhar card.png', 'image': aadharImage},
    // {'name': 'Police Verification.pdf', 'image': policeVerificationImage},
    // {'name': 'Police Verification.pdf', 'image': policeVerification2Image},
  ].obs;

  final userId = 0.obs;

  final isFromTenant = false.obs;

  @override
  void onInit() {
    isFromTenant.value = Get.arguments[0];
    if (isFromTenant.value) {
      userId.value = Get.arguments[1];
      print("sadlasklasd ${userId.value}");
      getDocumentById();
    }

    super.onInit();
  }

  final kiryederDocumentLoading = false.obs;

  getDocumentById() async {
    kiryederDocumentLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Accept-Language": languaeCode,
        "Content-Type": "application/json"
      },
      url: "$userDocument${userId.value}/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        documentList.clear();
        documentList.addAll(response.data);
        print("dkdjsakldas ${response.data}");
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
