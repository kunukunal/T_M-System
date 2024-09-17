import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/payment_request/phone_pay_controller.dart';

class PaymentController extends GetxController {
  final ammountController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final isPaymentRequest = 0.obs;

  final payentModeChoose = 2.obs;

  final paymentUnitData = {}.obs;
  final paymentUnitId = 0.obs;

  final totalduetillnow = 0.0.obs;
  final pendingthismonth = 0.0.obs;
  final pendingprocessamount = 0.0.obs;
  final needReload = false.obs;

  final rentBillUrl = "".obs;

  @override
  void onInit() {
    paymentUnitData.value = Get.arguments[0];

    if (paymentUnitData.isNotEmpty) {
      paymentUnitId.value = paymentUnitData['id'];
      getPaymentRequest(paymentUnitId.value);
    }
    super.onInit();
  }

  ontapSendRequest() {
    if (ammountController.value.text.trim().isNotEmpty) {
      isPaymentRequest.value = 1;
    } else {
      customSnackBar(Get.context!, "please_enter_amount".tr);
    }
  }

  ontappaymentVia() {
    isPaymentRequest.value = 2;
  }

  phonePayCallBack() async {
    final phonepayCntrl = Get.put(PhonePayController());
    phonepayCntrl.getChecksum(
        amount: double.parse(ammountController.value.text));
    var result = "";
    await phonepayCntrl.startTransaction().then((response) {
      if (response != null) {
        String status = response['status'].toString();
        String error = response['error'].toString();
        if (status == 'SUCCESS') {
          print("fdskladklasd ${response}");
          print("fdskladklasd ${response}");
          print("fdskladklasd ${phonepayCntrl.merchantTransactionId.value}");
          submitPaymentRequest(
              tansactionId: phonepayCntrl.merchantTransactionId.value);
        } else if (status == "FAILURE") {
          print("fdskladklasd ${response}");
          print("fdskladklasd ${phonepayCntrl.merchantTransactionId.value}");
          isPaymentRequest.value = 4;
        } else {
          result = "Flow Completed - Status: $status and Error: $error";
        }
      } else {
        result = "Flow Incomplete";
      }

      print("dalskdlkasd $result");
    }).catchError((error) {
      // handleError(error);
      print("Errorssss: $error");
    });
  }

  ontapRequest() {
    if (ammountController.value.text.trim().isNotEmpty) {
      if (payentModeChoose.value == 1) {
        phonePayCallBack();
      } else {
        isPaymentRequest.value = 3;
        submitPaymentRequest();
      }
    } else {
      customSnackBar(Get.context!, "please_enter_amount".tr);
    }
  }

  ontapbackHomeRequest() {
    isPaymentRequest.value = 0;
    Get.back(result: needReload.value);
  }

  final isPaymentRequestSucess = false.obs;
  submitPaymentRequest({String? tansactionId}) async {
    isPaymentRequestSucess.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "unit_id": paymentUnitId.value,
        "amount": ammountController.value.text.trim(),
        "payment_mode":
            payentModeChoose.value, // (1 = Online Transafer, 2 = Cash, 3 = UPI)
        "description": descriptionController.value.text.trim(),
        if (payentModeChoose.value == 1) "phonepe_txn_id": tansactionId,
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
      isPaymentRequest.value = 3;
      needReload.value = true;
    } else {
      isPaymentRequestSucess.value = false;
    }
  }

  final isPaymentRequestDataLoading = false.obs;

  getPaymentRequest(int unitId) async {
    isPaymentRequestDataLoading.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$paymentRequestHistory$unitId",
    );
    if (response.statusCode == 200) {
      final data = response.data;

      print("dsakdja ${data}");
      totalduetillnow.value = data['due_till_last_month'].toDouble();
      pendingthismonth.value = data['current_month_due'].toDouble();

      pendingprocessamount.value =
          double.parse(data['pending_approval_payment'].toString());
      rentBillUrl.value = data['rent_bill'] ?? "";

      final amnt = ((totalduetillnow.value + pendingthismonth.value) -
          pendingprocessamount.value);
      ammountController.value.text = amnt > 0 ? amnt.toString() : "0";
      isPaymentRequestDataLoading.value = false;
    } else {
      isPaymentRequestDataLoading.value = false;
    }
  }
}
