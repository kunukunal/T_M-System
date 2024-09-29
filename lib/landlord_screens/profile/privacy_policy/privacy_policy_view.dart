import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/profile/privacy_policy/privacy_policy_controller.dart';

import '../../../common/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final int isFrom;
  PrivacyPolicyScreen({super.key, required this.isFrom});
  final privacyCntrl = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              isFrom == 1
                  ? "About Us"
                  : isFrom == 2
                      ? 'privacy_policy'.tr
                      : isFrom == 3
                          ? "Terms and Conditions"
                          : "Refund & Cancellation",
              style: CustomStyles.skipBlack)),
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
                : privacyCntrl.privacyPolicyHtml.keys.isEmpty
                    ? Center(
                        child: Text(isFrom == 1
                            ? "About us data not found"
                            : isFrom == 2
                                ? "privacy_policy_data_not_found".tr
                                : isFrom == 3
                                    ? "Terms and Conditions data not found"
                                    : "Refund & Cancellation"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            isFrom == 1
                                ? privacyCntrl.aboutUsHtml['feature_type']
                                : isFrom == 2
                                    ? privacyCntrl
                                        .privacyPolicyHtml['feature_type']
                                    : isFrom == 3
                                        ? privacyCntrl.termsAndConditionHtml[
                                            'feature_type']
                                        : privacyCntrl
                                            .refundAndCancellationHtml[
                                                'feature_type']
                                            .toString(),
                            style: CustomStyles.otpStyle050505
                                .copyWith(fontSize: 16.sp - commonFontSize),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          HtmlWidget(
                            isFrom == 1
                                ? privacyCntrl.aboutUsHtml['content']
                                : isFrom == 2
                                    ? privacyCntrl.privacyPolicyHtml['content']
                                    : isFrom == 3
                                        ? privacyCntrl
                                            .termsAndConditionHtml['content']
                                        : privacyCntrl
                                                .refundAndCancellationHtml[
                                            'content'],
                            textStyle: CustomStyles.desc606060.copyWith(
                                fontSize: 14.sp - commonFontSize,
                                height: 1.5.h),
                          ),
                        ],
                      ),
          );
        }),
      ),
    );
  }
}
