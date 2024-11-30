import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_details_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/add_property/unit_List/unit_details/unit_widget.dart';

class UnitDetails extends StatelessWidget {
  UnitDetails({super.key});
  final unitDetailCntrl = Get.put(UnitDetailsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: backArrowImage,
            ),
          ),
          title: Text("unit_details".tr,
              style: CustomStyles.otpStyle050505W700S16),
        ),
        body: Obx(() {
          return unitDetailCntrl.unitDetailsLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (unitDetailCntrl.unitImageList.isNotEmpty)
                        UnitDetailView().pageViewWidget(),
                        SizedBox(height: 10.h),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Colors.grey.shade300,
                            ),
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
                              UnitDetailView().tabContent('overview'.tr),
                              UnitDetailView().tabContent('reviews'.tr),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Remove Expanded to allow the entire screen to scroll
                        SizedBox(
                          height: MediaQuery.of(context)
                              .size
                              .height, // Set a height to ensure it occupies space
                          child: TabBarView(
                            children: [
                              UnitDetailView().overViewWidget(),
                              UnitDetailView().ratingWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
