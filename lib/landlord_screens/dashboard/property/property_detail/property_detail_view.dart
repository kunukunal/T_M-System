import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_detail/property_detail_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_detail/property_detail_widget.dart';

import '../../../../common/constants.dart';

class PropertyDetailView extends StatelessWidget {
  PropertyDetailView({super.key});
  final propertyDetailCntrl = Get.put(PropertyDetailViewController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: backArrowImage,
            ),
          ),
          title: Text("Details", style: CustomStyles.otpStyle050505W700S16),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Properties',
                style: TextStyle(fontSize: 16.sp - commonFontSize, color: grey),
              ),
              bigDropDown(
                selectedItem: propertyDetailCntrl.selectedProperty.value,
                color: whiteColor,
                items: propertyDetailCntrl.propertyList,
                onChange: (item) {
                  propertyDetailCntrl.selectedProperty.value = item;
                },
              ),
              PropertyDetailViewWidget().pageViewWidget(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: .5,color: Colors.grey.shade300,),
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  tabs: [
                    PropertyDetailViewWidget().tabContent('Overview'),
                    PropertyDetailViewWidget().tabContent('Reviews'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // Remove IntrinsicHeight and wrap TabBarView with Expanded
              Expanded(
                child: TabBarView(
                  children: [
                    PropertyDetailViewWidget().overViewWidget(),
                    PropertyDetailViewWidget().ratingWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
