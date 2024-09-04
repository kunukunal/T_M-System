import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/landlord_screens/expense/add_expense/add_expense_view.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class ExpenseController extends GetxController {
  //variables
  final expenseList = [].obs;

  //Functions
  onAddTap() {
    Get.to(() => AddExpenseScreen(),arguments: [false,{}])!.then((value) {
      if (value == true) {
        getExpenseData();
      }
    });
  }

  onEditTap(Map item) {
    Get.to(() => AddExpenseScreen(),arguments: [true,item])!.then((value) {
      if (value == true) {
        getExpenseData();
      }
    });
  }

  onDeleteTap(int expenseId) {
    deleteExpense(expenseId);
  }

  final isExpenseDataget = false.obs;

  @override
  onInit() {
    super.onInit();
    getExpenseData();
  }

  getExpenseData() async {
    final dashCntrl = Get.find<DashBoardController>();
    isExpenseDataget.value = true;

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";            String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(headers: {
      'Authorization': "Bearer $accessToken",
            "Accept-Language": languaeCode,

    }, url: getAllExpense);
    if (response != null) {
      if (response.statusCode == 200) {
        expenseList.clear();

        expenseList.addAll(response.data['history']);
        dashCntrl.expenseBox.value = response.data['total_month_expense']??0.0;
        isExpenseDataget.value = false;
      } else if (response.statusCode == 400) {}
    }
  }

  deleteExpense(int expenseId) async {

    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";            String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioDeleteCall(headers: {
      'Authorization': "Bearer $accessToken",
            "Accept-Language": languaeCode,

    }, url: "$getAllExpense$expenseId/");
    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, response.data['message']);

        getExpenseData();
        isExpenseDataget.value = false;
      } else if (response.statusCode == 400) {}
    }
  }
}
