import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'reports'.tr,
          style: CustomStyles.titleText
              .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            GestureDetector(
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
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  onRefresh: () async {
                    await reportCntrl.getReportData();
                  },
                  child: reportCntrl.isReportDataloading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : reportCntrl.reportList.isEmpty
                          ? const Center(
                              child: Text("No report data Found"),
                            )
                          : ListView.builder(
                              itemCount: reportCntrl.reportList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ReportPdfView(
                                          name: reportCntrl.reportList[index]
                                                      ['transaction']
                                                  ['unit_name'] ??
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
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        reportCntrl.reportList[
                                                                        index]
                                                                    ['user']
                                                                ['name'] ??
                                                            "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: CustomStyles
                                                            .titleText
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Inter'),
                                                      ),
                                                    Text(
                                                      reportCntrl.reportList[
                                                                      index][
                                                                  'transaction']
                                                              ['unit_name'] ??
                                                          "",
                                                      style: CustomStyles
                                                          .titleText
                                                          .copyWith(
                                                              fontWeight: isLandlord
                                                                  ? FontWeight
                                                                      .w500
                                                                  : FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  commonFontSize +
                                                                      (isLandlord
                                                                          ? 14
                                                                          : 15),
                                                              fontFamily:
                                                                  'Inter'),
                                                    ),
                                                    Text(
                                                      "₹${reportCntrl.reportList[index]['transaction']['transaction_amount']}",
                                                      style: CustomStyles
                                                          .titleText
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  commonFontSize +
                                                                      14,
                                                              // color: whiteColor,
                                                              fontFamily:
                                                                  'Inter'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (reportCntrl.reportList[index]
                                                      ['receipt'] !=
                                                  null)
                                                IconButton(
                                                    onPressed: () {
                                                      saveNetworkPdf(reportCntrl
                                                              .reportList[index]
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
                                                        ['transaction']
                                                    ['transaction_date'],
                                                style: CustomStyles.titleText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        // color: whiteColor,
                                                        fontSize:
                                                            commonFontSize + 14,
                                                        fontFamily: 'Inter'),
                                              ),
                                              Text(
                                                reportCntrl.reportList[index]
                                                        ['transaction']
                                                    ['payment_status_value'],
                                                style: CustomStyles.titleText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            commonFontSize + 14,
                                                        color: reportCntrl.reportList[
                                                                            index]
                                                                        ['transaction']
                                                                    [
                                                                    'status'] ==
                                                                2
                                                            ? green
                                                            : reportCntrl.reportList[
                                                                            index]['transaction']
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
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
