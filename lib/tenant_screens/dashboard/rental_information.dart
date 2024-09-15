import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_widgets.dart';
import 'package:tanent_management/tenant_screens/dashboard/rental_controller.dart';

class RentalInformation extends StatelessWidget {
  RentalInformation({
    super.key,
  });
  final rentalCntrl = Get.put(RentalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            'rental_information'.tr,
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SearchWidget().occUnoccContainer(
              //         icon: occupiedIcon,
              //         titleUnit: 'rent_due'.tr,
              //         units: '20/40'),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     SearchWidget().occUnoccContainer(
              //         icon: unOccupiedIcon,
              //         titleUnit: 'next_due_date'.tr,
              //         units: '10 Apr 2024'),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              DashBoardTenantWidgets()
                  .filterWidget(context, title: "payment_due".tr),
              Obx(() {
                return Expanded(
                  child: rentalCntrl.isRentalDataLaoding.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : rentalCntrl.paymentHistoryList.isEmpty
                          ? const Center(
                              child: Text("No Payment record found"),
                            )
                          : DashBoardTenantWidgets()
                              .paymentHistory(rentalCntrl.paymentHistoryList),
                );
              })
            ],
          ),
        ));
  }
}
