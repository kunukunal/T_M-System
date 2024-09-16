import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_complete.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  final bool isFromMain;
  DashboardScreen({super.key, this.isFromMain = true});
  final dashCntrl = Get.put(DashBoardController());
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: DashBoardWidgets().expandedFloatButton(_key),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashBoardWidgets().appBar(),
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Obx(() {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  dashCntrl.getDashboardData();
                },
                child: dashCntrl.isDashboardDataLaoding.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Text(
                                '${'welcome'.tr}, ${userData['name'] ?? "User"}',
                                textAlign: TextAlign.start,
                                style: CustomStyles.blue679BF1w700s20,
                              ),
                            ),
                            dashCntrl.proprtyList.isEmpty
                                ? emptyView()
                                : CompleteDashboard()
                          ],
                        ),
                      ),
              ),
            );
          })
        ],
      ),
    ));
  }

  emptyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashBoardWidgets().emptyContainer(
            image: totalPropertyImage,
            height: 159.h,
            isTackVisible: false,
            subTitle: 'total_properties_tenants'.tr),
        SizedBox(
          height: 16.h,
        ),
        DashBoardWidgets().emptyContainer(
            image: incomeExpenseImage,
            height: 300.86.h,
            isTackVisible: true,
            title: 'income_expense'.tr),
        SizedBox(
          height: 16.h,
        ),
        DashBoardWidgets().emptyContainer(
            image: occupancyTrendImage,
            height: 300.47.h,
            isTackVisible: false,
            subTitle: 'occupancy_trend'.tr),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            'property_history'.tr,
            style: CustomStyles.otpStyle050505W700S16,
          ),
        ),
        DashBoardWidgets().emptyContainer(
            image: availableOccupiedImage,
            height: 179.h,
            isTackVisible: false,
            subTitle: 'available_occupied_unit_list'.tr),
      ],
    );
  }
}
