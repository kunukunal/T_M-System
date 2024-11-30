import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/utils.dart';
import 'package:tanent_management/landlord_screens/reports/pdf_view.dart';
import 'package:tanent_management/landlord_screens/reports/report_controller.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final reportCntrl = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            'reports'.tr,
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  reportCntrl.monthFilter(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      return Text(
                        reportCntrl.rentFrom.value == null
                            ? 'month'.tr
                            : "${reportCntrl.rentFrom.value!.month}/${reportCntrl.rentFrom.value!.year}",
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
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            labelColor: HexColor('#679BF1'),
            indicatorColor: HexColor('#679BF1'),
            splashFactory: NoSplash.splashFactory,
            onTap: (value) {
              if (value == 0) {
                reportCntrl.getReportData();
              } else if (value == 1) {
                reportCntrl.getInvoiceData();
              }
            },
            tabs:  [
              Tab(text: 'receipt'.tr),
              Tab(text: 'invoice'.tr),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [buildReciept(), buildInvoice()],
        ),
      ),
    );
  }

  buildReciept() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          await reportCntrl.getReportData();
        },
        child: reportCntrl.isReportDataloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : reportCntrl.reportList.isEmpty
                ?  Center(
                    child: Text("no_receipt_data_found".tr),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: ListView.builder(
                      itemCount: reportCntrl.reportList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ReportPdfView(
                                  name: reportCntrl.reportList[index]
                                          ['transaction']['unit_name'] ??
                                      "",
                                  pdfUrl: reportCntrl.reportList[index]
                                      ['receipt'],
                                ));
                          },
                          child: Card(
                            surfaceTintColor: Colors.transparent,
                            elevation: 5,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: reportCntrl.reportList[index]
                                              ['transaction']['status'] ==
                                          2
                                      ? green
                                      : reportCntrl.reportList[index]
                                                  ['transaction']['status'] ==
                                              1
                                          ? Colors.orange
                                          : red,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (isLandlord)
                                              Text(
                                                reportCntrl.reportList[index]
                                                        ['user']['name'] ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomStyles.titleText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Inter'),
                                              ),
                                            Text(
                                              reportCntrl.reportList[index]
                                                          ['transaction']
                                                      ['unit_name'] ??
                                                  "",
                                              style: CustomStyles.titleText
                                                  .copyWith(
                                                      fontWeight: isLandlord
                                                          ? FontWeight.w500
                                                          : FontWeight.bold,
                                                      fontSize: commonFontSize +
                                                          (isLandlord
                                                              ? 14
                                                              : 15),
                                                      fontFamily: 'Inter'),
                                            ),
                                            Text(
                                              reportCntrl.reportList[index]
                                                          ['transaction']
                                                      ['unit_info'] ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: CustomStyles
                                                  .blue679BF1w700s20
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter'),
                                            ),
                                            Text(
                                              "₹${reportCntrl.reportList[index]['transaction']['transaction_amount']}",
                                              style: CustomStyles.titleText
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          commonFontSize + 14,
                                                      // color: whiteColor,
                                                      fontFamily: 'Inter'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (reportCntrl.reportList[index]
                                              ['receipt'] !=
                                          null)
                                        IconButton(
                                            onPressed: () {
                                              saveNetworkPdf(
                                                  reportCntrl.reportList[index]
                                                      ['receipt']);
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                            ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        reportCntrl.reportList[index]
                                            ['transaction']['transaction_date'],
                                        style: CustomStyles.titleText.copyWith(
                                            fontWeight: FontWeight.w500,
                                            // color: whiteColor,
                                            fontSize: commonFontSize + 14,
                                            fontFamily: 'Inter'),
                                      ),
                                      Text(
                                        reportCntrl.reportList[index]
                                                ['transaction']
                                            ['payment_status_value'],
                                        style: CustomStyles.titleText.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: commonFontSize + 14,
                                            color: reportCntrl.reportList[index]
                                                            ['transaction']
                                                        ['status'] ==
                                                    2
                                                ? green
                                                : reportCntrl.reportList[index]
                                                                ['transaction']
                                                            ['status'] ==
                                                        1
                                                    ? Colors.orange
                                                    : red,
                                            fontFamily: 'Inter'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      );
    });
  }

  buildInvoice() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          await reportCntrl.getInvoiceData();
        },
        child: reportCntrl.isInvoiceDataloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : reportCntrl.invoiceList.isEmpty
                ?  Center(
                    child: Text("no_invoice_data_found".tr),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: ListView.builder(
                      itemCount: reportCntrl.invoiceList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ReportPdfView(
                                  name: reportCntrl.invoiceList[index]['unit']
                                          ['name'] ??
                                      "",
                                  pdfUrl: reportCntrl.invoiceList[index]
                                      ['bill'],
                                ));
                          },
                          child: Card(
                            surfaceTintColor: Colors.transparent,
                            elevation: 5,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: lightBlue)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (isLandlord)
                                              Text(
                                                reportCntrl.invoiceList[index]
                                                        ['user']['name'] ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomStyles.titleText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Inter'),
                                              ),
                                            Text(
                                              reportCntrl.invoiceList[index]
                                                      ['unit']['name'] ??
                                                  "",
                                              style: CustomStyles.titleText
                                                  .copyWith(
                                                      fontWeight: isLandlord
                                                          ? FontWeight.w500
                                                          : FontWeight.bold,
                                                      fontSize: commonFontSize +
                                                          (isLandlord
                                                              ? 14
                                                              : 15),
                                                      fontFamily: 'Inter'),
                                            ),
                                            Text(
                                              reportCntrl.invoiceList[index]
                                                      ['unit']['unit_info'] ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,

                                              maxLines: 2,
                                              style: CustomStyles
                                                  .blue679BF1w700s20
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter'),
                                            ),
                                            // Text(
                                            //   "₹${reportCntrl.reportList[index]['transaction']['transaction_amount']}",
                                            //   style: CustomStyles.titleText
                                            //       .copyWith(
                                            //           fontWeight: FontWeight.w500,
                                            //           fontSize:
                                            //               commonFontSize + 14,
                                            //           // color: whiteColor,
                                            //           fontFamily: 'Inter'),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      if (reportCntrl.invoiceList[index]
                                              ['bill'] !=
                                          null)
                                        IconButton(
                                            onPressed: () {
                                              saveNetworkPdf(reportCntrl
                                                  .invoiceList[index]['bill']);
                                            },
                                            icon: Icon(
                                              Icons.download,
                                              color: lightBlue,
                                            ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        reportCntrl.invoiceList[index]['unit']
                                            ['rent_from'],
                                        style: CustomStyles.titleText.copyWith(
                                            fontWeight: FontWeight.w500,
                                            // color: whiteColor,
                                            fontSize: commonFontSize + 14,
                                            fontFamily: 'Inter'),
                                      ),
                                      Text(
                                        "${"invoice_data".tr} - [${reportCntrl.invoiceList[index]['unit']
                                            ['rent_type_value']}]",
                                        style: CustomStyles.titleText.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: commonFontSize + 14,
                                            color: black,

                                            // reportCntrl.invoiceList[index]
                                            //             ['unit']['rent_type'] ==
                                            //         2
                                            //     ? green
                                            //     : reportCntrl.invoiceList[index]
                                            //                     ['unit']
                                            //                 ['rent_type'] ==
                                            //             1
                                            //         ? Colors.orange
                                            //         : red,
                                            fontFamily: 'Inter'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      );
    });
  }
}
