import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/add_property_widgets.dart';
import 'package:tanent_management/landlord_screens/notification/notification_receive/notification_receive_widget.dart';

import 'notification_receive_controller.dart';

class NotificationReceiveView extends StatelessWidget {
  NotificationReceiveView({super.key});
  final notifReceiveCntrl = Get.put(NotifReceiveController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('payments'.tr, style: CustomStyles.otpStyle050505W700S16),
          centerTitle: true,
          bottom: TabBar(
            labelColor: HexColor('#679BF1'),
            indicatorColor: HexColor('#679BF1'),
            splashFactory: NoSplash.splashFactory,
            onTap: (value) {
              if (value == 0) {
                // if (notifReceiveCntrl.recieveditems.isEmpty) {
                notifReceiveCntrl.getTransactionByStatusApi(2);
                // }
              } else if (value == 1) {
                // if (notifReceiveCntrl.cancelitems.isEmpty) {
                notifReceiveCntrl.getDueTransacionApi();
                // }
              } else if (value == 2) {
                notifReceiveCntrl.getTransactionByStatusApi(3);
              }
            },
            tabs: [
              Tab(text: 'received'.tr),
              Tab(text: 'due'.tr),
              Tab(text: 'cancelled'.tr),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Received Tab
            Obx(() {
              return _buildTabContent(notifReceiveCntrl.recieveditems, 2);
            }),
            Obx(() {
              return dueList();
            }),
            // Cancelled Tab
            Obx(() {
              return _buildTabContent(notifReceiveCntrl.cancelitems, 3);
            }),

            // Due Tab
          ],
        ),
      ),
    );
  }

  Widget dueList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: notifReceiveCntrl.dueItemLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notifReceiveCntrl.dueItemsList.isEmpty
              ? Center(
                  child: Text("no_due_pending".tr),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: notifReceiveCntrl.dueItemsList.length,
                  itemBuilder: (context, ind) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        expansionTileTheme: const ExpansionTileThemeData(),
                        highlightColor: Colors.transparent,
                      ),
                      child: Card(
                        surfaceTintColor: Colors.transparent,
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                            leading: recieveNotif,
                            collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Text(
                              notifReceiveCntrl.dueItemsList[ind]
                                      ['tenant_name'] ??
                                  "",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp - commonFontSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                                "₹${notifReceiveCntrl.dueItemsList[ind]['total_due'] ?? ""}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp - commonFontSize,
                                    color: red)),
                            children: [
                              Card(
                                  elevation: 5,
                                  surfaceTintColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          notifReceiveCntrl
                                              .dueItemsList[ind]['units']
                                              .length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 5),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            side:
                                                                BorderSide(
                                                                    color: grey,
                                                                    width: .5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          notifReceiveCntrl
                                                                      .dueItemsList[
                                                                  ind]['units'][
                                                              index]['unit_name'],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.sp -
                                                                commonFontSize,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          notifReceiveCntrl
                                                              .dueItemsList[ind]
                                                                  ['units']
                                                                  [index]
                                                                  ['unit_info']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: CustomStyles
                                                              .blue679BF1w700s20
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontFamily:
                                                                      'Inter'),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          notifReceiveCntrl
                                                                      .dueItemsList[
                                                                  ind]['units'][
                                                              index]['address'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 15.sp -
                                                                  commonFontSize,
                                                              color: grey),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              // "${'this_month_due'.tr}:",
                                                              "${'total_due'.tr}:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14
                                                                          .sp -
                                                                      commonFontSize,
                                                                  color: grey),
                                                            ),
                                                            Text(
                                                                "₹${notifReceiveCntrl.dueItemsList[ind]['units'][index]['current_month_due']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: 14
                                                                            .sp -
                                                                        commonFontSize,
                                                                    color:
                                                                        red)),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment
                                                        //           .spaceBetween,
                                                        //   children: [
                                                        //     Text("${'last_due'.tr}:",
                                                        //         style: TextStyle(
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .w600,
                                                        //             fontSize: 14
                                                        //                     .sp -
                                                        //                 commonFontSize,
                                                        //             color:
                                                        //                 grey)),
                                                        //     Text(
                                                        //         "₹${notifReceiveCntrl.dueItemsList[ind]['units'][index]['due_till_last_month']}",
                                                        //         style: TextStyle(
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .w600,
                                                        //             fontSize: 14
                                                        //                     .sp -
                                                        //                 commonFontSize,
                                                        //             color:
                                                        //                 red)),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                    isThreeLine: true,
                                                    trailing:
                                                        customBorderButton(
                                                      'paid'.tr,
                                                      () {
                                                        double toatalAmnt = (notifReceiveCntrl
                                                                        .dueItemsList[ind]
                                                                    [
                                                                    'units'][index]
                                                                [
                                                                'current_month_due'] +
                                                            notifReceiveCntrl
                                                                        .dueItemsList[ind]
                                                                    [
                                                                    'units'][index]
                                                                [
                                                                'due_till_last_month']);
                                                        paymentPayDialoge(
                                                            title:
                                                                "${'pay_your'.tr} ${notifReceiveCntrl.dueItemsList[ind]['units'][index]['unit_name']} ${'rent'.tr}",
                                                            amount: toatalAmnt,
                                                            tenantId:
                                                                notifReceiveCntrl
                                                                        .dueItemsList[ind]
                                                                    [
                                                                    'tenant_id'],
                                                            unitId: notifReceiveCntrl
                                                                        .dueItemsList[
                                                                    ind]['units']
                                                                [
                                                                index]['unit_id']);
                                                      },
                                                      verticalPadding: 12.h,
                                                      horizontalPadding: 2.w,
                                                      btnHeight: 30.h,
                                                      width: 50.w,
                                                      color:
                                                          HexColor('#679BF1'),
                                                      borderColor:
                                                          HexColor('#679BF1'),
                                                      textColor:
                                                          HexColor('#FFFFFF'),
                                                    )),
                                                // if (index != 5 - 1) const Divider()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildTabContent(final list, int status) {
    return status == 2 && notifReceiveCntrl.recivedTransactionLoading.value ||
            status == 3 && notifReceiveCntrl.cancelTransactionLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : list.isEmpty
            ? Center(
                child: Text("no_transaction_found".tr),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return NotifReceiveWidget().notifReceiveList(
                      transactionId: list[index]['transaction_id'],
                      desc: list[index]['unit_address'],
                      title: list[index]['unit_name'],
                      unit_info: list[index]['unit_info'],
                      price: list[index]['transaction_amount'],
                      trnsactionMode: list[index]['transaction_mode'],
                      transactionModeValue: list[index]
                          ['transaction_mode_value'],
                      name: list[index]['tenant'],
                      date: list[index]['transaction_date'],
                      status: status,
                      transId: list[index]['id']);
                },
              );
  }

  paymentPayDialoge({
    required String title,
    required double amount,
    required int unitId,
    required int tenantId,
  }) async {
    TextEditingController amountcntrl =
        TextEditingController(text: amount.toString());
    TextEditingController descriptionCntrl = TextEditingController();
    return await Get.dialog(
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
                      Text(title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp - commonFontSize,
                              fontWeight: FontWeight.w700)),
                      AddPropertyWidget()
                          .commomText('amount'.tr, isMandatory: true),
                      customTextField(
                        textInputAction: TextInputAction.done,
                        controller: amountcntrl,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow('.')
                        // ],
                        hintText: 'enter_amount'.tr,
                        isBorder: true,
                        isFilled: false,
                      ),
                      AddPropertyWidget()
                          .commomText("description".tr, isMandatory: false),
                      customTextField(
                        textInputAction: TextInputAction.done,
                        controller: descriptionCntrl,
                        hintText: 'enter_description'.tr,
                        isBorder: true,
                        maxLines: 2,
                        isFilled: false,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(() {
                        return notifReceiveCntrl.ispaymentPay.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customBorderButton("cancel".tr, () {
                                    Get.back();
                                  },
                                      verticalPadding: 5.h,
                                      horizontalPadding: 2.w,
                                      btnHeight: 35.h,
                                      width: 140.w,
                                      borderColor: HexColor('#679BF1'),
                                      textColor: HexColor('#679BF1')),
                                  customBorderButton(
                                    "paid".tr,
                                    () {
                                      if (amountcntrl.text
                                          .toString()
                                          .trim()
                                          .isNotEmpty) {
                                        String val = amountcntrl.text;
                                        double val1 = double.parse(val);

                                        if (val1 != 0) {
                                          if (val1 <= amount) {
                                            notifReceiveCntrl.payTenantRentApi(
                                                tenatId: tenantId,
                                                unitId: unitId,
                                                amount: val1,
                                                description:
                                                    descriptionCntrl.text);
                                          } else {
                                            customSnackBar(Get.context!,
                                                "${'please_enter_amount_less_than'.tr} $amount");
                                          }
                                        } else {
                                          customSnackBar(Get.context!,
                                              "${'please_enter_amount_greater_than_0'.tr}");
                                        }
                                      } else {
                                        customSnackBar(Get.context!,
                                            "please_enter_amount".tr);
                                      }
                                    },
                                    verticalPadding: 5.h,
                                    horizontalPadding: 2.w,
                                    btnHeight: 35.h,
                                    color: HexColor('#679BF1'),
                                    textColor: Colors.white,
                                    width: 140.w,
                                  )
                                ],
                              );
                      })
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
