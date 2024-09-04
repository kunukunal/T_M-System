import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/reports/report_widgets.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "property_overview".tr,
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                  ),
                  Row(
                    children: [
                      Text(
                        'month'.tr,
                        style: CustomStyles.titleText.copyWith(
                            fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                      ),
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
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
               OverviewCard(
                chartTitle: 'occupied'.tr,
                chartTitle2: 'available'.tr,
                data: [20, 30, 40, 20],
                data2: [10, 20, 30, 10],
                xLabels: ['January', 'February', 'March', 'April'],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "kirayedar_overview".tr,
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                  ),
                  Row(
                    children: [
                      Text(
                        'month'.tr,
                        style: CustomStyles.titleText.copyWith(
                            fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                      ),
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
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
               OverviewCard(
                chartTitle: 'no_of_kirayedar_verified'.tr,
                data: [10, 20, 30, 15],
                data2: null,
                xLabels: ['January', 'February', 'March', 'April'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
