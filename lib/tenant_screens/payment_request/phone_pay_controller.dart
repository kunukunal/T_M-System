import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/payment_request/payment_controller.dart';

class RazorPayController extends GetxController {
  Razorpay? _razorpay;
  @override
  void onInit() {
    initRazorpaySdk();
    super.onInit();
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  void initRazorpaySdk() async {
    try {
      _razorpay = Razorpay();
      _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      _razorpay?.on(
          Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      _razorpay?.on(
          Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    } catch (error) {
      // handleError(error);
    }
  }

  Future startTransaction({required double amount}) async {
    // var options = {
    //   'key': razor_key,
    //   'amount': (amount * 100).toInt(),
    //   "currency": "INR",
    //   'name': userData['name'] ?? "",
    //   'description': 'Rent Pay',
    //   'retry': {'enabled': false, 'max_count': 1},
    //   'send_sms_hash': true,
    //   'prefill': {
    //     'contact': userData['phone'] ?? "",
    //     'email': userData['email'] ?? ""
    //   },
    //   // 'external': {
    //   //   'wallets': ['paytm']
    //   // }
    // };
    final paymentCntrl = Get.find<PaymentController>();
    paymentCntrl.isPaymentRequestSucess.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "amount": amount,
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: getPaymentObject,
      isRawData: true
    );


    if (response.statusCode == 200) {
      // paymentCntrl.isPaymentRequestDataLoading.value = false;
      final data = response.data;
      try {
        _razorpay?.open(data);
      } catch (error) {
        paymentCntrl.isPaymentRequestSucess.value = false;
        customSnackBar(Get.context!, "Something went wrong");
      }
    } else {
      paymentCntrl.isPaymentRequestSucess.value = false;
      customSnackBar(Get.context!, "Something went wrong");
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    final paymentCntrl = Get.find<PaymentController>();
    paymentCntrl.isPaymentRequest.value = 4;
    print("Error: ${response}  ${response.message} ${response.error}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    final paymentCntrl = Get.find<PaymentController>();
    paymentCntrl.submitPaymentRequest(tansactionId: response.paymentId);
    print(
        "Success: ${response} ${response.data} ${response.orderId} ${response.paymentId} ${response.signature}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    print("wallet: ${response}");
  }
}
