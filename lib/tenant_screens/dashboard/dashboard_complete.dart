import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/reports/pdf_view.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_widgets.dart';
import 'package:tanent_management/tenant_screens/dashboard/rental_information.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_view.dart';

import '../../landlord_screens/dashboard/search/search_widget.dart';

class CompleteDashboard extends StatelessWidget {
  CompleteDashboard({super.key});
  final dashCntrl = Get.find<DashBoardTenantController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchWidget().occUnoccContainer(
                      icon: occupiedIcon,
                      titleUnit: 'rent_due'.tr,
                      units: "₹${dashCntrl.rentData['rent_due']}"),
                  SizedBox(
                    width: 5.w,
                  ),
                  SearchWidget().occUnoccContainer(
                      icon: unOccupiedIcon,
                      titleUnit: 'next_due_date'.tr,
                      units: dashCntrl.rentData['next_due_date'].toString()),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "units".tr,
                style: CustomStyles.titleText
                    .copyWith(fontWeight: FontWeight.w700, fontFamily: 'Inter'),
              ),
              SizedBox(
                height: 10.h,
              ),
              unitList(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "payment_history".tr,
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w700, fontFamily: 'Inter'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RentalInformation());
                    },
                    child: Text(
                      "see_all".tr,
                      style: CustomStyles.titleText.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          color: grey),
                    ),
                  ),
                ],
              ),
              DashBoardTenantWidgets().paymentHistory(
                dashCntrl.paymentHistoryList,
              )
            ],
          );
        }),
      ),
    );
  }
}

unitList() {
  final dashCntrl = Get.find<DashBoardTenantController>();

  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: dashCntrl.unitList.length,
    itemBuilder: (context, index) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor('#EBEBEB')),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => UnitDetailView(), arguments: [
                    dashCntrl.unitList[index]['id'],
                    true,
                  ]);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRect(
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: dashCntrl.unitList[index]['image'] != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        dashCntrl.unitList[index]['image']),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: profileIconWithWidget.image)),
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
                            children: [
                              Expanded(
                                  child: Text(
                                dashCntrl.unitList[index]['name'] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomStyles.black14,
                              )),
                              Text(
                                "₹${dashCntrl.unitList[index]['rent'] ?? ""}",
                                style: CustomStyles.amountFA4343W700S12
                                    .copyWith(
                                        color: Colors.red,
                                        fontSize: 15.0 - commonFontSize),
                              )
                            ],
                          ),
                          Text(
                            dashCntrl.unitList[index]['unit_info'] ?? "",
                      maxLines: 2,
                                              style: CustomStyles
                                                  .blue679BF1w700s20
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 25.r,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        dashCntrl.unitList[index]['address'] ??
                                            "",
                                        style:
                                            CustomStyles.address050505w400s12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            if (dashCntrl.unitList[index]
                                                    ['bill'] !=
                                                null) {
                                              Get.to(() => ReportPdfView(
                                                    name: dashCntrl
                                                                .unitList[index]
                                                            ['name'] ??
                                                        "",
                                                    pdfUrl: dashCntrl
                                                            .unitList[index]
                                                        ['bill'],
                                                  ));
                                            } else {
                                              customSnackBar(
                                                  context, "no_bill_found".tr);
                                            }
                                          },
                                          child: eyeIcon),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (dashCntrl.unitList[index]['pay_rent'] == true)
                Divider(
                  color: lightBorderGrey,
                  // height: 1.h,
                ),
              dashCntrl.unitList[index]['pay_rent'] == true?
                customBorderWithIconButton(
                  "pay_your_rent".tr,
                  () {
                    dashCntrl.onTapPayRent(dashCntrl.unitList[index], 'online');
                  },
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: 35.h,
                  borderColor: HexColor('#679BF1'),
                  textColor: HexColor('#679BF1'),
                ):customBorderWithIconButton(
                  "no_payment_due".tr,
                  () {
                     Get.to(() => UnitDetailView(), arguments: [
                    dashCntrl.unitList[index]['id'],
                    true,
                  ]);
                  },
                  verticalPadding: 5.h,
                  horizontalPadding: 2.w,
                  btnHeight: 35.h,
                  borderColor:green,
                  textColor: green,
                ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 10.h,
      );
    },
  );
}
