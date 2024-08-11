import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class PaymentController extends GetxController {
  final ammountController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final isPaymentRequest = 0.obs;

  final payentModeChoose = 1.obs;

  final paymentUnitData = {}.obs;
  final paymentUnitId = 0.obs;

  @override
  void onInit() {
    paymentUnitData.value = Get.arguments[0];

    if (paymentUnitData.isNotEmpty) {
      paymentUnitId.value = paymentUnitData['id'];
      ammountController.value.text = paymentUnitData['rent'].toString();
    }
    super.onInit();
  }

  ontapSendRequest() {
    if (ammountController.value.text.trim().isNotEmpty) {
      isPaymentRequest.value = 1;
    } else {
      customSnackBar(Get.context!, "Please enter the amount");
    }
  }

  ontappaymentVia() {
    isPaymentRequest.value = 2;
  }

  ontapRequest() {
    if (ammountController.value.text.trim().isNotEmpty) {
      submitPaymentRequest();
    } else {
      customSnackBar(Get.context!, "Please enter the amount");
    }
  }

  ontapbackHomeRequest() {
    isPaymentRequest.value = 0;
    Get.back();
  }

  final isPaymentRequestSucess = false.obs;
  submitPaymentRequest() async {
    isPaymentRequestSucess.value = true;
    print("dsalklasd ${{
      "unit_id": paymentUnitId.value,
      "amount": ammountController.value.text.trim(),
      "payment_mode":
          payentModeChoose.value // (1 = Online Transafer, 2 = Cash, 3 = UPI)
    }}");
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "unit_id": paymentUnitId.value,
        "amount": ammountController.value.text.trim(),
        "payment_mode":
            payentModeChoose.value // (1 = Online Transafer, 2 = Cash, 3 = UPI)
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: sendTenantPaymentRequest,
    );
    if (response.statusCode == 200) {
      isPaymentRequestSucess.value = false;
      print("dakldkalskdlas ${response.data}");
      isPaymentRequest.value = 3;
    } else {
      isPaymentRequestSucess.value = false;
    }
  }
}
