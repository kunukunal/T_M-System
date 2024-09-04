import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_complete.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_widgets.dart';

class DashboardTenantScreen extends StatelessWidget {
  final bool isFromMain;
  DashboardTenantScreen({super.key, this.isFromMain = true});
  final dashCntrl = Get.put(DashBoardTenantController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashBoardTenantWidgets().appBar(),
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
                            dashCntrl.unitList.isEmpty
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
        DashBoardTenantWidgets().emptyContainer(
            image: rentTotalImage,
            height: 159.h,
            isTackVisible: false,
            subTitle: 'total_rent'.tr),
        SizedBox(
          height: 16.h,
        ),
        DashBoardTenantWidgets().emptyContainer(
            image: incomeExpenseImage,
            height: 300.86.h,
            isTackVisible: true,
            title: 'rent'.tr),
      ],
    );
  }
}
