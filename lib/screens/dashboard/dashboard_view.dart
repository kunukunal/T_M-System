import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/screens/dashboard/dashboard_widgets.dart';
import 'package:tanent_management/screens/dashboard/dashboard_complete.dart';

class DashboardScreen extends StatelessWidget {
  bool isFromMain;
  DashboardScreen({super.key, this.isFromMain = true});
  final dashCntrl = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Obx(() {
        return dashCntrl.isAddTap.value
            ? DashBoardWidgets().expandedFloatButton()
            : DashBoardWidgets().floatingActionButton();
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashBoardWidgets().appBar(),
          Divider(
            color: HexColor('#EBEBEB'),
            height: 1.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'Welcome, Nayan',
                      textAlign: TextAlign.start,
                      style: CustomStyles.blue679BF1w700s20,
                    ),
                  ),
                  isFromMain ? emptyView() : CompleteDashboard()
                ],
              ),
            ),
          )
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
            subTitle: 'Total Properties/Tenants'),
        SizedBox(
          height: 16.h,
        ),
        DashBoardWidgets().emptyContainer(
            image: incomeExpenseImage,
            height: 300.86.h,
            isTackVisible: true,
            
            title: 'Income/Expense'),
        SizedBox(
          height: 16.h,
        ),
        DashBoardWidgets().emptyContainer(
            image: occupancyTrendImage,
            height: 300.47.h,
            isTackVisible: true,
            title: 'Occupancy Trend'),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            'Projects History',
            style: CustomStyles.otpStyle050505W700S16,
          ),
        ),
        DashBoardWidgets().emptyContainer(
            image: availableOccupiedImage,
            height: 179.h,
            isTackVisible: false,
            subTitle: 'Available/Occupied Unit List'),
      ],
    );
  }
}
