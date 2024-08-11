import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/reports/report_widgets.dart';

class ReportTenantScreen extends StatelessWidget {
  const ReportTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Reports',
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
                    "Property Overview",
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Month',
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
              const OverviewCard(
                chartTitle: 'Occupied',
                chartTitle2: 'Available',
                data: [20, 30, 40, 20],
                data2: [10, 20, 30, 10],
                xLabels: ['January', 'February', 'March', 'April'],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kirayedar Overview",
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Month',
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
              const OverviewCard(
                chartTitle: 'No. of Kirayedar Verified',
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
