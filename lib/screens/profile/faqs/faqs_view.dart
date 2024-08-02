import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/profile/faqs/faqs_controller.dart';
import 'package:tanent_management/screens/profile/faqs/faqs_widget.dart';

import '../../../common/text_styles.dart';

class FAQsView extends StatelessWidget {
   FAQsView({super.key});

   final faqCntrl = Get.put(FaqsController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('FAQs', style: CustomStyles.skipBlack)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1.h,color: HexColor('#EBEBEB'),),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  FaqsWidgets().searchBar(),
                  SizedBox(height: 10.h,),
                  FaqsWidgets().faqsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
