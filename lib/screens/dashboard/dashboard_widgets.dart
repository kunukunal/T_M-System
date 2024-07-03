import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/screens/dashboard/dashboard_view.dart';

import '../../common/text_styles.dart';

class DashBoardWidgets {
  //app bar
  appBar() {
    final dashCntrl = Get.find<DashBoardController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 42.h, width: 94.35.w, child: splashImage),
          Spacer(),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    dashCntrl.onSearchTap();
                  },
                  child: searchIcon),
              SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                  onTap: () {
                    dashCntrl.onNotifTap();
                  },
                  child: notifIcon),
            ],
          )
        ],
      ),
    );
  }

  //floating action button
  floatingActionButton() {
    final dashCntrl = Get.find<DashBoardController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                dashCntrl.onFloatingButtonAddTap();
              },
              backgroundColor: Colors.white,
              shape: CircleBorder(
                side: BorderSide(
                  color: HexColor('#EBEBEB'), // Border color
                  width: 1.w, // Border width
                ),
              ),
              child: addIcon,
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  //expanded floating action button
  expandedFloatButton() {
    final dashCntrl = Get.find<DashBoardController>();
    return Container(
      height: 239.h,
      width: 200.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: HexColor('#EBEBEB'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add Properties',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                width: 5.w,
              ),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddPropertyTap();
                },
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addPropertyIcon,
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add Tenant',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                width: 5.w,
              ),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddTenantTap();
                },
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addTanantIcon,
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add Expense',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                width: 5.w,
              ),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddExpenseTap();
                },
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addExpenseIcon,
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onFloatingButtonCrossTap();
                },
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: crossIcon,
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  //empty dashboard container
  emptyContainer({
    required Widget image,
    String? title,
    String? subTitle,
    required bool isTackVisible,
    required double height,
    double? width,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DashboardScreen(
              isFromMain: false,
            ));
      },
      child: Container(
        // height: height,
        width: width ?? Get.width,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          border: Border.all(color: HexColor('#EBEBEB')),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            isTackVisible ? dividerWidget() : const SizedBox.shrink(),
            isTackVisible
                ? Text(
                    title!,
                    style: CustomStyles.black16
                        .copyWith(fontWeight: FontWeight.w700),
                  )
                : const SizedBox.shrink(),
            isTackVisible
                ? SizedBox(
                    height: 20.h,
                  )
                : const SizedBox.shrink(),
            image,
            SizedBox(
              height: 20.h,
            ),
            isTackVisible
                ? customButton(
                    onPressed: () {},
                    text: 'Start Tracking',
                    width: 136.w,
                    height: 45.h)
                : Text(
                    subTitle!,
                    style: CustomStyles.otpStyle050505W700S16,
                  ),
          ],
        ),
      ),
    );
  }

  dividerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First Divider
        SizedBox(
          width: 40.w,
          child: Divider(
            color: HexColor('#606060'),
            thickness: 1,
          ),
        ),
        // Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Track Your',
            style: CustomStyles.desc606060.copyWith(fontSize: 12.sp),
          ),
        ),
        // Second Divider
        SizedBox(
          width: 40.w,
          child: Divider(
            color: HexColor('#606060'),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
