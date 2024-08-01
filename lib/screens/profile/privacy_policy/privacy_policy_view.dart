import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/profile/privacy_policy/privacy_policy_controller.dart';

import '../../../common/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final privacyCntrl = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Privacy Policy', style: CustomStyles.skipBlack)),
      body: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: privacyCntrl.isPrivacyLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : privacyCntrl.siteFeatureData.keys.isEmpty
                    ? const Center(
                        child: Text("No Privacy Policy data found"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            privacyCntrl.siteFeatureData['feature_type']
                                .toString(),
                            style: CustomStyles.otpStyle050505
                                .copyWith(fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          HtmlWidget(
                            privacyCntrl.siteFeatureData['content'],
                            textStyle: CustomStyles.desc606060
                                .copyWith(fontSize: 14.sp, height: 1.5.h),
                          ),
                        ],
                      ),
          );
        }),
      ),
    );
  }
}
