import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/api_service_strings/base_url.dart';

class PhonePayController extends GetxController {
  String body = "";
  String checksum = "";
  bool enableLogs = true;
  Object? result;
  String environmentValue = 'SANDBOX';
  String appId = "";
  String merchantId = "PGTESTPAYUAT86";
  String packageName = "com.daq.orbit";
  String apiEndPoint = "/pg/v1/pay";
  String saltKey = "96434309-7796-489d-8924-ab56988a6076";
  String saltIndex = "1";
  String callBackUrl = "$commonBaseUrl$phonePayCallbackUrl";
  // String callBackUrl =
  //     "https://webhook.site/f4d38d52-09ae-4570-be1e-7de0f3d5e9ed";

  final merchantTransactionId = "".obs;

  @override
  void onInit() {
    initPhonePeSdk();
    super.onInit();
  }

  void initPhonePeSdk() async {
    try {
      bool isInitialized = await PhonePePaymentSdk.init(
          environmentValue, appId, merchantId, enableLogs);
      result = 'PhonePe SDK Initialized - $isInitialized';
    } catch (error) {
      handleError(error);
    }
  }

  void getChecksum({required double amount}) {
    merchantTransactionId.value = "TM${DateTime.now().millisecondsSinceEpoch}";
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": merchantTransactionId.value,
      "merchantUserId": "90223250",
      "amount": (amount * 100).toInt(), // Ensuring that amount is an integer
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    body = base64Body;
  }

  void handleError(dynamic error) {
    if (error is Exception) {
      result = error.toString();
    } else {
      result = {"error": error};
    }
  }

  Future startTransaction() async {
    try {
      final response = await PhonePePaymentSdk.startTransaction(
          body, callBackUrl, checksum, packageName);
      return response;
    } catch (error) {
      handleError(error);
    }
  }
}
