import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_controller.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unti_detail_widget.dart';

import '../../../../common/constants.dart';

class UnitDetailView extends StatelessWidget {
  UnitDetailView({super.key});
  final unitDetailCntrl = Get.put(UnitDetailViewController());

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
          title: Text("details".tr, style: CustomStyles.otpStyle050505W700S16),
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
                          UnitDetailViewWidget().pageViewWidget(),
                   
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
                              UnitDetailViewWidget().tabContent('overview'.tr),
                              UnitDetailViewWidget().tabContent('reviews'.tr),
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
                              UnitDetailViewWidget().overViewWidget(),
                              UnitDetailViewWidget().ratingWidget(),
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
