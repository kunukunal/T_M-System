import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/management/management_widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_property_view.dart';
import 'package:tanent_management/landlord_screens/profile/edit_profile/edit_profile_widget.dart';

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
                  child: Image.asset(
                    profileIcon,
                    height: 24.h,
                    width: 24.w,
                    color: Colors.black87,
                  )),
            ],
          )
        ],
      ),
    );
  }

  totalExpenseContainer() {
    final cntrl = Get.find<DashBoardController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Container(
        // height: 134.h,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  cntrl.monthFilter(Get.context!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      return Text(
                        cntrl.rentFrom.value == null
                            ? 'month'.tr
                            : "${cntrl.rentFrom.value!.month}/${cntrl.rentFrom.value!.year}",
                        style: CustomStyles.titleText.copyWith(
                            fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                      );
                    }),
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/icons/filter.png",
                      height: 20.h,
                      width: 20.w,
                    )
                  ],
                ),
              ),
              Obx(() {
                return Text(
                  '₹${cntrl.expenseBox.value}',
                  style: CustomStyles.black16.copyWith(
                      fontSize: 28.sp - commonFontSize,
                      fontWeight: FontWeight.w700),
                );
              }),
              Text(
                'total_expense_this_month'.tr,
                style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),
              ),
            ],
          ),
        ),
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
                'add_expense'.tr,
                style: CustomStyles.otpStyle050505
                    .copyWith(fontSize: 16.sp - commonFontSize),
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
                'add_tenant'.tr,
                style: CustomStyles.otpStyle050505
                    .copyWith(fontSize: 16.sp - commonFontSize),
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
                'add_properties'.tr,
                style: CustomStyles.otpStyle050505
                    .copyWith(fontSize: 16.sp - commonFontSize),
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
    return Container(
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
                  text: 'add_property'.tr,
                  width: 136.w,
                  height: 45.h)
              : Text(
                  subTitle!,
                  style: CustomStyles.otpStyle050505W700S16,
                ),
        ],
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
            'track_your'.tr,
            style: CustomStyles.desc606060
                .copyWith(fontSize: 12.sp - commonFontSize),
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

//

  filterDashboardOnChart({
    required String title,
    required String button1,
    required String button2,
    required Function() onButton1Tap,
    required Function() onButton2Tap,
    bool isFromIncomeExpense = true,
  }) async {
    final dashCntrl = Get.find<DashBoardController>();

    Get.dialog(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.r,
        ),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(
              18.r,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.w, // Adjust the max width as needed
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18.r,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp - commonFontSize,
                                fontWeight: FontWeight.w700)),
                      ),
                      EditProfileWidget.commomText("From", isMandatory: true),
                      Obx(() {
                        return ManagementWidgets().datePickerContainer(
                            isFromIncomeExpense
                                ? (dashCntrl.incomingStartFrom.value == null
                                    ? 'Select'
                                    : '${dashCntrl.incomingStartFrom.value!.day}-${dashCntrl.incomingStartFrom.value!.month}-${dashCntrl.incomingStartFrom.value!.year}')
                                : (dashCntrl.occupancyStartFrom.value == null
                                    ? 'Select'
                                    : '${dashCntrl.occupancyStartFrom.value!.day}-${dashCntrl.occupancyStartFrom.value!.month}-${dashCntrl.occupancyStartFrom.value!.year}'),
                            onTap: () async {
                          if (isFromIncomeExpense) {
                            final picked = await dashCntrl
                                .selectDate(dashCntrl.incomingStartFrom.value);

                            if (picked != null) {
                              dashCntrl.incomingStartFrom.value = picked;
                            }
                          } else {
                            final picked = await dashCntrl
                                .selectDate(dashCntrl.occupancyStartFrom.value);

                            if (picked != null) {
                              dashCntrl.occupancyStartFrom.value = picked;
                            }
                          }
                        });
                      }),
                      EditProfileWidget.commomText("To", isMandatory: true),
                      Obx(() {
                        return ManagementWidgets().datePickerContainer(
                            isFromIncomeExpense
                                ? (dashCntrl.incomingEndFrom.value == null
                                    ? 'Select'
                                    : '${dashCntrl.incomingEndFrom.value!.day}-${dashCntrl.incomingEndFrom.value!.month}-${dashCntrl.incomingEndFrom.value!.year}')
                                : (dashCntrl.occupancyEndFrom.value == null
                                    ? 'Select'
                                    : '${dashCntrl.occupancyEndFrom.value!.day}-${dashCntrl.occupancyEndFrom.value!.month}-${dashCntrl.occupancyEndFrom.value!.year}'),
                            onTap: () async {
                          if (isFromIncomeExpense) {
                            final picked = await dashCntrl
                                .selectDate(dashCntrl.incomingEndFrom.value);

                            if (picked != null) {
                              dashCntrl.incomingEndFrom.value = picked;
                            }
                          } else {
                            final picked = await dashCntrl
                                .selectDate(dashCntrl.occupancyEndFrom.value);

                            if (picked != null) {
                              dashCntrl.occupancyEndFrom.value = picked;
                            }
                          }
                        });
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton(button1, onButton1Tap,
                              verticalPadding: 5.h,
                              horizontalPadding: 2.w,
                              btnHeight: 35.h,
                              width: 140.w,
                              borderColor: HexColor('#679BF1'),
                              textColor: HexColor('#679BF1')),
                          customBorderButton(
                            button2,
                            onButton2Tap,
                            verticalPadding: 5.h,
                            horizontalPadding: 2.w,
                            btnHeight: 35.h,
                            color: HexColor('#679BF1'),
                            textColor: Colors.white,
                            width: 140.w,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
