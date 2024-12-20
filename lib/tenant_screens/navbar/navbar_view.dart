//MARK: - Packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/tenant_screens/navbar/nav_bar_controller.dart';
import 'package:tanent_management/tenant_screens/navbar/nav_bar_widgets.dart';

import '../../common/constants.dart';
import '../../common/widgets.dart';

//MARK: - Class
class NavBarTenant extends StatefulWidget {
  final int initialPage;
  const NavBarTenant({Key? key, required this.initialPage}) : super(key: key);
  @override
  State<NavBarTenant> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarTenant> {
  final dashboardCntrl = Get.put(NavBarTenantController());

//MARK: -View LifeCycle
  @override
  void initState() {
    super.initState();
    if (mounted) {
      dashboardCntrl.initialPage.value = widget.initialPage;
      dashboardCntrl.pageController.value =
          PageController(initialPage: widget.initialPage);
    }
    advancedStatusCheck();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await dashboardCntrl.onPageChanged(dashboardCntrl.initialPage.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            final shouldPop = await willPopScope();
            return shouldPop;
          },
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: dashboardCntrl.pageController.value,
            onPageChanged: dashboardCntrl.onPageChanged,
            children: dashboardCntrl.pages,
          )),
      bottomNavigationBar: Obx(() {
        return Container(
          height: 64.h,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r))),
          child: Column(
            children: [
              Divider(
                height: 1.h,
                color: HexColor('#EBEBEB'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarWidgets.buildNavItem(
                      0,
                      dashboardCntrl.selectedIndex.value == 0
                          ? dashboardActiveIcon
                          : dashboardIcon,
                      'dashboard'.tr),
                  NavBarWidgets.buildNavItem(
                      1,
                      dashboardCntrl.selectedIndex.value == 1
                          ? exploreActiveIcon
                          : exploreIcon,
                      'explore'.tr),
                  NavBarWidgets.buildNavItem(
                      2,
                      dashboardCntrl.selectedIndex.value == 2
                          ? reportActiveIcon
                          : reportIcon,
                      'reports'.tr),
                  // NavBarWidgets.buildNavItem(
                  //     2,
                  //     dashboardCntrl.selectedIndex.value == 2
                  //         ? managementActiveIcon
                  //         : managementIcon,
                  //     'Management'),
                  // NavBarWidgets.buildNavItem(
                  //     3,
                  //     dashboardCntrl.selectedIndex.value == 3
                  //         ? expenseActiveIcon
                  //         : expenseIcon,
                  //     'Expense'),
                  NavBarWidgets.buildNavItem(
                      3,
                      dashboardCntrl.selectedIndex.value == 3
                          ? profileActiveIcon
                          : profileIcon,
                      'profile'.toUpperCase()),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
