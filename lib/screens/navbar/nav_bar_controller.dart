import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_view.dart';
import 'package:tanent_management/screens/navbar_management/navbar_management_view.dart';
import 'package:tanent_management/screens/profile/my_profile/my_profile_view.dart';

import '../dashboard/dashboard_view.dart';
import '../expense/expense_view.dart';
import '../reports/report_view.dart';

class NavBarController extends GetxController{
  //variables
  final initialPage = 0.obs;
  final selectedIndex = 0.obs;
  late final pageController = PageController().obs;

  //List Variables
  late final pages = [
    DashboardScreen(),
    const ReportScreen(),
    NavbarManagementScreen()    ,// TenantListScreen(),
    ExpenseScreen(),
    TenantListScreen(),
  ];

  //functions
  Future<void> onPageChanged(int index) async {
    selectedIndex.value = index;
  }

  //this function is called when the item is clicked in navbar
  void onItemTap(int selectedItem) {
     pageController.value.jumpToPage(selectedItem);
  }

}