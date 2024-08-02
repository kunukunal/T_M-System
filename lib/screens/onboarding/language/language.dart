import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/onboarding/language/language_controller.dart';
import 'package:tanent_management/screens/onboarding/language/language_widget.dart';

class LanguageScreen extends StatelessWidget {
  final bool isFromProfile;
  LanguageScreen({super.key, required this.isFromProfile});

  final langCntrl = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              backArrowIcon(),
              SizedBox(height: 15.h,),
              Text('Choose a Preferred Language',style: CustomStyles.otpStyle050505.copyWith(fontWeight: FontWeight.w600),),
              LanguageWidget.languageSelectionWidget(),
              customButton(onPressed: (){
                langCntrl.onContinueTap(isFromProfile:isFromProfile);
              },width: Get.width,text: 'Continue'),
              SizedBox(height: 20.h,)
            ],
            
          ),
        ),
      ),
    );
  }
}
