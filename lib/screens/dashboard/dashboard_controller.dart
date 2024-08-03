import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/property_list/property_list_view.dart';
import 'package:tanent_management/screens/dashboard/search/search_view.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_view.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_view.dart';
import 'package:tanent_management/screens/notification/notification_view.dart';
import 'package:tanent_management/screens/profile/my_profile/my_profile_view.dart';

class DashBoardController extends GetxController {
  //variables
  final isAddTap = false.obs;

  //functions
  onFloatingButtonAddTap() {
    isAddTap.value = true;
  }

  onFloatingButtonCrossTap() {
    isAddTap.value = false;
  }

  onAddPropertyTap() {
    print("sdadasdas");
    isAddTap.value = false;
    //  Get.to(()=>AddPropertyView());
    Get.to(() => PropertyListView());
  }

  onAddTenantTap() {
    isAddTap.value = false;
    Get.to(() => TenantListScreen());
    // Get.to(() => AddTenantScreen());
  }

  onAddExpenseTap() {
    isAddTap.value = false;
    Get.to(() => AddExpenseScreen(), arguments: [false, {}]);
  }

  onSearchTap() {
    Get.to(() => SearchView());
  }

  onNotifTap() {
    Get.to(() => NotificationView());
  }

  onProfileTap() {
    Get.to(() => MyProfileView());
  }
}
