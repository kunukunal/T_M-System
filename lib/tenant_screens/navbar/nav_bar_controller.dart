import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/profile/my_profile/my_profile_view.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_view.dart';
import 'package:tanent_management/tenant_screens/explore/explore_view.dart';
import 'package:tanent_management/tenant_screens/reports/report_view.dart';

class NavBarTenantController extends GetxController {
  //variables
  final initialPage = 0.obs;
  final selectedIndex = 0.obs;
  late final pageController = PageController().obs;

  //List Variables
  late final pages = [
    DashboardTenantScreen(),
     ExploreScreen(),
    const ReportTenantScreen(),
    MyProfileView()
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
