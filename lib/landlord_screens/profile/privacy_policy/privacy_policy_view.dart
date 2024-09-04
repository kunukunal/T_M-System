import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/profile/privacy_policy/privacy_policy_controller.dart';

import '../../../common/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final privacyCntrl = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('privacy_policy'.tr, style: CustomStyles.skipBlack)),
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
                    ?  Center(
                        child: Text("privacy_policy_data_not_found".tr),
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
                                .copyWith(fontSize: 16.sp - commonFontSize),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          HtmlWidget(
                            privacyCntrl.siteFeatureData['content'],
                            textStyle: CustomStyles.desc606060
                                .copyWith(fontSize: 14.sp - commonFontSize, height: 1.5.h),
                          ),
                        ],
                      ),
          );
        }),
      ),
    );
  }
}
