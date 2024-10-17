import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/onboarding/walk_through/terms_and_condition_controller.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen({super.key});

  final cntrl = Get.put(TermsAndConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T&C / Policies",
          style: CustomStyles.otpStyle050505,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        // primary: false,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: Container(),
      ),
      floatingActionButton: Obx(() {
        return (cntrl.siteFeatureData.keys.isEmpty) ||
                (cntrl.siteFeatureData.keys.isNotEmpty &&
                    cntrl.isbuttonShow.value == false)
            ? SizedBox()
            : FloatingActionButton.small(
                backgroundColor: Colors.blueAccent,
                onPressed: () {
                  cntrl.scrollController.value.animateTo(
                    cntrl.scrollController.value.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              );
      }),
      body: Obx(() {
        return cntrl.siteFeatureData.keys.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: cntrl.scrollController.value,
                child: Column(
                  children: [
                    Divider(
                      color: HexColor('#EBEBEB'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cntrl.siteFeatureData.keys.length,
                        itemBuilder: (context, index) {
                          String key =
                              cntrl.siteFeatureData.keys.elementAt(index);
                          var section = cntrl.siteFeatureData[key];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                section['feature_type'].toString(),
                                style: CustomStyles.otpStyle050505
                                    .copyWith(fontSize: 16.sp - commonFontSize),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              HtmlWidget(
                                section['content'],
                                textStyle: CustomStyles.desc606060.copyWith(
                                    fontSize: 14.sp - commonFontSize,
                                    height: 1.5.h),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Obx(() {
                          return Checkbox(
                              value: cntrl.checkboxValue.value,
                              onChanged: (value) {
                                cntrl.onCheckBoxClicked(value);
                              });
                        }),
                        Text(
                          'i_agree_and_continue'.tr,
                          style: CustomStyles.desc606060
                              .copyWith(fontSize: 16.sp - commonFontSize),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: customButton(
                          onPressed: () {
                            cntrl.onNextClicked();
                          },
                          width: Get.width,
                          text: 'next'.tr),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
