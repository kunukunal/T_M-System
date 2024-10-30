import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class NotifReceiveController extends GetxController {
  final recieveditems = [].obs;
  final cancelitems = [].obs;
  final dueItemsList = [].obs;

  @override
  onInit() {
    getTransactionByStatusApi(2);

    super.onInit();
  }

  // onEditTap() {
  //   NotifReceiveWidget().declinePopup();
  // }

  final recivedTransactionLoading = false.obs;
  final cancelTransactionLoading = false.obs;

  getTransactionByStatusApi(int status) async {
    if (status == 2) {
      recivedTransactionLoading.value = true;
    } else {
      cancelTransactionLoading.value = true;
    }
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
      url: "$getTransactionByStatus$status",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        if (status == 2) {
          recivedTransactionLoading.value = false;
          recieveditems.clear();
          recieveditems.addAll(response.data);
          print("dsalkd ${recieveditems}");
        } else {
          cancelTransactionLoading.value = false;
          cancelitems.clear();
          cancelitems.addAll(response.data);
        }
      } else if (response.statusCode == 400) {
        if (status == 2) {
          recivedTransactionLoading.value = false;
        } else {
          cancelTransactionLoading.value = false;
        }

        // Handle error
      }
    }
  }

  final isStatusUpdateLoading = false.obs;

  updateTransationStatusNotification(
    int transactionId,
    int status,
  ) async {
    isStatusUpdateLoading.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPatchCall(
      body: {
        "status": status // (1=Pending, 2=Accepted, 3=Rejected)
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: "$updateTransactionStatus$transactionId/",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        isStatusUpdateLoading.value = false;
        getTransactionByStatusApi(status == 2 ? 3 : 2);
      } else if (response.statusCode == 400) {
        isStatusUpdateLoading.value = false;

        // Handle error
      }
    }
  }

  final dueItemLoading = false.obs;
  getDueTransacionApi() async {
    dueItemLoading.value = true;
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
      url: getDueTransactions,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        dueItemLoading.value = false;
        dueItemsList.clear();
        dueItemsList.addAll(response.data);
      } else if (response.statusCode == 400) {
        dueItemLoading.value = false;

        // Handle error
      }
    }
  }

  final ispaymentPay = false.obs;
  payTenantRentApi(
      {required int tenatId,
      required int unitId,
      required double amount,
      required String description}) async {
    ispaymentPay.value = true;
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "tenant": tenatId,
        "unit": unitId,
        "amount": amount,
        "description": description
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: paytenantRent,
    );
    if (response != null) {
      if (response.statusCode == 201) {
        ispaymentPay.value = false;

        Get.back();
        customSnackBar(Get.context!, response.data['message']);
        getDueTransacionApi();
      } else if (response.statusCode == 400) {
        ispaymentPay.value = false;

        // Handle error
      }
    }
  }
}
