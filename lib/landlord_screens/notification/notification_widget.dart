import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/notification/notification_controller.dart';

import '../../common/constants.dart';
import 'ad_as_tenant/tenant_details_view.dart';

class NotificationWidget {
  notifReceiveList({
    int? tranId,
    int? notificationId,
    String? transactionId,
    String? title,
    String? desc,
    String? price,
    String? name,
    String? date,
    bool? isRead,
  }) {
    final notifCntrl = Get.find<NotificationController>();
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h, top: 10.h),
      child: GestureDetector(
        onTap: () {
          if (isRead == false) {
            notifCntrl.updateNotificationRead(notificationId!);
          }
        },
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
              color: isRead == true ? null : Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: lightBorderGrey)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'transaction_id'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp - commonFontSize,
                      color: black),
                ),
                Text(
                  transactionId!,
                  style: TextStyle(
                      fontSize: 12.sp - commonFontSize,
                      fontWeight: FontWeight.w400,
                      color: grey),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Divider(
                  color: HexColor('#EBEBEB'),
                  height: 1.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  child: Row(
                    children: [
                      recieveNotif,
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp - commonFontSize,
                                        color: black),
                                  ),
                                ),
                                Text(
                                  "₹ $price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp - commonFontSize,
                                      color: red),
                                ),
                              ],
                            ),
                            Text(
                              desc!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp - commonFontSize,
                                  color: grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: HexColor('#EBEBEB'),
                  height: 1.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${'name'.tr}: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp - commonFontSize,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              name ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp - commonFontSize,
                                  color: grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${'date'.tr}: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp - commonFontSize,
                          ),
                        ),
                        Text(
                          date!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp - commonFontSize,
                              color: grey),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customBorderButton('decline'.tr, () {
                      // notifCntrl.onDeclineTap();
                      declinePopup(tranId!);
                    },
                        verticalPadding: 12.h,
                        horizontalPadding: 2.w,
                        btnHeight: 30.h,
                        width: 90.w,
                        borderColor: HexColor('#679BF1'),
                        textColor: HexColor('#679BF1')),
                    Obx(() {
                      return notifCntrl.isStatusUpdateLoading.value
                          ? const CircularProgressIndicator()
                          : customBorderButton('Receive', () {
                              notifCntrl.updateTransationStatusNotification(
                                  tranId!, 2, 1);
                            },
                              verticalPadding: 12.h,
                              horizontalPadding: 2.w,
                              btnHeight: 30.h,
                              width: 215.w,
                              color: HexColor('#679BF1'),
                              textColor: HexColor('#FFFFFF'),
                              borderColor: Colors.transparent);
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  notifRequestList(
      {String? title,
      String? desc,
      String? name,
      int? unitId,
      int? notificationId,
      int? notifiCationTypeId,
      int? notifiCationId = 0,
      int? processRequestId,
      int? tenantId = 0,
      String? date,
      bool? isRead,
      bool? isTenantAlreadyAdded = false}) {
    final notifCntrl = Get.find<NotificationController>();
    return Padding(
        padding:
            EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h, top: 10.h),
        child: GestureDetector(
          onTap: () {
            if (isRead == false) {
              notifCntrl.updateNotificationRead(notificationId!);
            }
          },
          child: Container(
            // height: 160.h,
            decoration: BoxDecoration(
                color: isRead == true ? null : Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightBorderGrey)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      child: Row(
                        children: [
                          requestNotif,
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp - commonFontSize,
                                      color: black),
                                ),
                                Text(
                                  name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp - commonFontSize,
                                      color: black),
                                ),
                                Text(
                                  desc!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp - commonFontSize,
                                      color: grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${'date'.tr}: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp - commonFontSize,
                          ),
                        ),
                        Text(
                          date ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp - commonFontSize,
                              color: grey),
                        ),
                      ],
                    ),
                    Divider(
                      color: HexColor('#EBEBEB'),
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    customBorderButton('view'.tr, () {
                      if (unitId != null) {
                        Get.to(() => AdasTenatDetailsScreen(), arguments: [
                          unitId,
                          notifiCationTypeId,
                          processRequestId,
                          isTenantAlreadyAdded,
                          tenantId,
                          notifiCationId
                        ])?.then((value) {
                          if (value == true) {
                            notifCntrl.getLandlordNotification();
                          }
                        });
                      } else {
                        customSnackBar(Get.context!, "something_went_wrong".tr);
                      }
                    },
                        verticalPadding: 12.h,
                        horizontalPadding: 2.w,
                        btnHeight: 30.h,
                        width: Get.width,
                        borderColor: HexColor('#679BF1'),
                        textColor: HexColor('#679BF1')),
                  ]),
            ),
          ),
        ));
  }

  notifRegularList({
    String? title,
    String? desc,
    int? notificationId,
    String? date,
    bool? isRead,
  }) {
    final notifCntrl = Get.find<NotificationController>();

    return Padding(
        padding:
            EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h, top: 10.h),
        child: GestureDetector(
          onTap: () {
            if (isRead == false) {
              notifCntrl.updateNotificationRead(notificationId!);
            }
          },
          child: Container(
            // height: 85.h,
            decoration: BoxDecoration(
                color: isRead == true ? null : Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightBorderGrey)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      child: Row(
                        children: [
                          regularNotif,
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp - commonFontSize,
                                      color: black),
                                ),
                                Text(
                                  desc ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp - commonFontSize,
                                      color: grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${'date'.tr}: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp - commonFontSize,
                          ),
                        ),
                        Text(
                          date ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp - commonFontSize,
                              color: grey),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }

  notifPaidList({
    String? title,
    String? desc,
    String? price,
    int? notificationId,
    bool? isOccupied,
    bool? isRead,
  }) {
    final notifCntrl = Get.find<NotificationController>();

    return Padding(
        padding:
            EdgeInsets.only(left: 10.h, right: 10.w, bottom: 5.h, top: 10.h),
        child: GestureDetector(
          onTap: () {
            if (isRead == false) {
              notifCntrl.updateNotificationRead(notificationId!);
            }
          },
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: isRead == true ? null : Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: lightBorderGrey)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          regularNotif,
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp - commonFontSize,
                                      color: black),
                                ),
                                Row(
                                  children: [
                                    homeIcon,
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        isOccupied! ? 'occupied'.tr : 'available'.tr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp - commonFontSize,
                                            color: green),
                                      ),
                                    ),
                                    Text(
                                      price!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.sp - commonFontSize,
                                          color: black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: HexColor('#EBEBEB'),
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customBorderButton('cancel'.tr, () {},
                            verticalPadding: 12.h,
                            horizontalPadding: 2.w,
                            btnHeight: 30.h,
                            width: Get.width / 2.4,
                            borderColor: HexColor('#679BF1'),
                            textColor: HexColor('#679BF1')),
                        customBorderButton('paid'.tr, () {},
                            verticalPadding: 12.h,
                            horizontalPadding: 2.w,
                            btnHeight: 30.h,
                            width: Get.width / 2.4,
                            color: HexColor('#679BF1'),
                            textColor: HexColor('#FFFFFF'),
                            borderColor: Colors.transparent)
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }

  declinePopup(int? tranId) {
    final notifCntrl = Get.find<NotificationController>();

    return commonDeclinePopup(
      title: '',
      subtitle: 'decline_request_confirmation'.tr,
      button1: 'cancel'.tr,
      button2: 'decline'.tr,
      onButton1Tap: () {
        Get.back();
      },
      onButton2Tap: () {
        Get.back();
        notifCntrl.updateTransationStatusNotification(tranId!, 3, 2);
      },
    );
  }
}
