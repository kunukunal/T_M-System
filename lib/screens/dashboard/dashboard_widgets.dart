import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/screens/dashboard/dashboard_view.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/add_property_view.dart';

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
          const Spacer(),
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
                  SizedBox(
                width: 20.w,
              ),
              GestureDetector(
                  onTap: () {
                    dashCntrl.onProfileTap();
                  },
                  child: Image.asset(profileIcon,height: 24.h,width: 24.w,color: Colors.black87,)),
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
  expandedFloatButton(final key) {
    final dashCntrl = Get.find<DashBoardController>();
    return ExpandableFab(
      key: key,
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.none,
      duration: Durations.long4,
      distance: 70,
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: crossIcon,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
      ),
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: addIcon,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      children: [
        GestureDetector(
          onTap: () {
            dashCntrl.onAddExpenseTap();
          },
          child: Row(
            children: [
              Text(
                'Add Expense',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp - commonFontSize),
              ),
              const SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddExpenseTap();
                },
                heroTag: null,
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addExpenseIcon,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            dashCntrl.onAddTenantTap();
          },
          child: Row(
            children: [
              Text(
                'Add Tenant',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp - commonFontSize),
              ),
              const SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddTenantTap();
                },
                heroTag: null,
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addTanantIcon,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            dashCntrl.onAddPropertyTap();
          },
          child: Row(
            children: [
              Text(
                'Add Properties',
                style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp - commonFontSize),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  dashCntrl.onAddPropertyTap();
                },
                heroTag: null,
                backgroundColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(
                    color: HexColor('#EBEBEB'), // Border color
                    width: 1.w, // Border width
                  ),
                ),
                child: addPropertyIcon,
              ),
            ],
          ),
        ),
      ],
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
                    onPressed: () {
                      Get.to(() => AddPropertyView(), arguments: [false, {}]);
                    },
                    text: 'Add Property',
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
            style: CustomStyles.desc606060.copyWith(fontSize: 12.sp - commonFontSize),
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
