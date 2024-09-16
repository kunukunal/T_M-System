import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/utils.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/tenant_screens/dashboard/rental_controller.dart';
import 'package:tanent_management/tenant_screens/explore/explore_view.dart';

import '../../common/text_styles.dart';

class DashBoardTenantWidgets {
  //app bar
  appBar() {
    final dashCntrl = Get.find<DashBoardTenantController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 42.h, width: 94.35.w, child: splashImage),
          const Spacer(),
          GestureDetector(
              onTap: () {
                dashCntrl.onNotifTap();
              },
              child: notifIcon),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 5.w,
          //     ),
          //     GestureDetector(onTap: () {}, child: creditCardIcon),
          //     SizedBox(
          //       width: 5.w,
          //     ),
          //     GestureDetector(onTap: () {}, child: noteIcon)
          //   ],
          // ),
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
                    Get.to(() => ExploreScreen());
                  },
                  text: 'explore'.tr,
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

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // Alpha value (255 is fully opaque)
      random.nextInt(256), // Red value
      random.nextInt(256), // Green value
      random.nextInt(256), // Blue value
    );
  }

  Widget filterWidget(BuildContext context, {required String title}) {
    final rentalCntrl = Get.find<RentalController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomStyles.titleText
              .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        ),
        GestureDetector(
          onTap: () {
            rentalCntrl.monthFilter(context);
          },
          child: Row(
            children: [
              Obx(() {
                return Text(
                  rentalCntrl.rentFrom.value == null
                      ? 'month'.tr
                      : "${rentalCntrl.rentFrom.value!.month}/${rentalCntrl.rentFrom.value!.year}",
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
      ],
    );
  }

  paymentHistory(final paymentHistoryList) {
    final dashCntrl = Get.find<DashBoardTenantController>();

    return ListView.builder(
      itemCount: paymentHistoryList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(left: 0.h, right: 0.w, bottom: 5.h, top: 10.h),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    dashCntrl.isExpanded.value = !dashCntrl.isExpanded.value;
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 50.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: HexColor('#BCD1F3'),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                              child: Text(
                            convertDateString(
                                paymentHistoryList[index]['transaction_date']),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp - commonFontSize,
                                color: black),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  paymentHistoryList[index]['unit'] ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp - commonFontSize,
                                      color: black),
                                ),
                                Text(
                                  paymentHistoryList[index]['status'] == 2
                                      ? "Approved"
                                      : paymentHistoryList[index]['status'] == 1
                                          ? "Pending"
                                          : "Reject",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp - commonFontSize,
                                      color: paymentHistoryList[index]
                                                  ['status'] ==
                                              2
                                          ? green
                                          : paymentHistoryList[index]
                                                      ['status'] ==
                                                  1
                                              ? Colors.orange
                                              : red),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Text(
                              "₹${paymentHistoryList[index]['transaction_amount'] ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp - commonFontSize,
                                  color: red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: HexColor('#EBEBEB'),
                ),
                RichText(
                  text: TextSpan(
                    text: '${'transaction'.tr}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp - commonFontSize,
                      color: black,
                    ),
                    children: [
                      TextSpan(
                        text: paymentHistoryList[index]['transaction_id'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp - commonFontSize,
                          color: grey, // Set the color to red
                        ),
                      ),
                    ],
                  ),
                ),
                // dashCntrl.isExpanded.value
                //     ? Expanded(
                //         child: Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               RichText(
                //                 text: TextSpan(
                //                   text: 'Transaction: ',
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.w700,
                //                     fontSize: 16.sp - commonFontSize,
                //                     color: black,
                //                   ),
                //                   children: [
                //                     TextSpan(
                //                       text: 'INR00000ABCD',
                //                       style: TextStyle(
                //                         fontWeight: FontWeight.w400,
                //                         fontSize: 14.sp - commonFontSize,
                //                         color: grey, // Set the color to red
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               ListView.builder(
                //                 shrinkWrap: true,
                //                 itemCount: 3,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 itemBuilder: (context, index) {
                //                   return InkWell(
                //                     onTap: () {},
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(8.0),
                //                       child: Column(
                //                         children: [
                //                           Padding(
                //                             padding: EdgeInsets.symmetric(
                //                                 vertical: 5.h),
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment
                //                                       .spaceBetween,
                //                               children: [
                //                                 Text(
                //                                   "Room Rent ",
                //                                   style: TextStyle(
                //                                       fontSize: 14.sp -
                //                                           commonFontSize,
                //                                       fontWeight:
                //                                           FontWeight.w700,
                //                                       color: black),
                //                                 ),
                //                                 // const Spacer(),
                //                                 Text("3800.0  ",
                //                                     style: TextStyle(
                //                                         fontSize: 14.sp -
                //                                             commonFontSize,
                //                                         fontWeight:
                //                                             FontWeight.w600,
                //                                         color: lightBlue)),
                //                               ],
                //                             ),
                //                           ),
                //                           Divider(
                //                             color: HexColor('#EBEBEB'),
                //                             height: 1.h,
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
