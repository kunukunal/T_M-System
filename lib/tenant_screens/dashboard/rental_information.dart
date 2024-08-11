import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_widget.dart';
import 'package:tanent_management/tenant_screens/dashboard/dashboard_widgets.dart';

class RentalInformation extends StatelessWidget {
  const RentalInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Rental Information',
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchWidget().occUnoccContainer(
                        icon: occupiedIcon,
                        titleUnit: 'Rent Due',
                        units: '20/40'),
                    SizedBox(
                      width: 5.w,
                    ),
                    SearchWidget().occUnoccContainer(
                        icon: unOccupiedIcon,
                        titleUnit: 'Next Due Date',
                        units: '10 Apr 2024'),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                DashBoardTenantWidgets().filterWidget(title: "Payment Due"),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      DashBoardTenantWidgets().paymentHistory(),
                )
              ],
            ),
          ),
        ));
  }
}
