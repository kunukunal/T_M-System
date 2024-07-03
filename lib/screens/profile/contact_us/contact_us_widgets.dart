import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/contact_us/contact_us_controller.dart';

import '../../../common/widgets.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';

class ContactUsWidgets{
  //address & contact info container
  addressContainer(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          Container(
              height: 60.h,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('Contact us for Ride share Address',textAlign: TextAlign.center, style: CustomStyles.title414141,),
              )),
          Text('House# 72, Road# 21, Banani, Dhaka-1213 (near Toranto & College, Oxford University of Canada)',textAlign: TextAlign.center,style: CustomStyles.title898989,),
          SizedBox(height: 10.h,),
          Text('Call :+91 9898129898\nEmail : support@tmsystem.com',textAlign: TextAlign.center,style: CustomStyles.title898989,),
          SizedBox(height: 20.h,),
          Text('Send Message',style: CustomStyles.title414141,),
          SizedBox(height: 20.h,),
        ],
      ),
    );
  }

  contactUsForm(){
    final contactCntrl = Get.find<ContactUsController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonlInfoWidget.commomText('Full Name'),
          customTextField(
              controller: contactCntrl.nameCntrl.value,
              focusNode: contactCntrl.nameFocus.value,
              hintText: 'Type Here...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(height: 10.h,),
          PersonlInfoWidget.commomText('Email Id'),
          customTextField(
              controller: contactCntrl.emailCntrl.value,
              focusNode: contactCntrl.emailFocus.value,
              hintText: 'Type Here...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(height: 10.h,),
          PersonlInfoWidget.commomText('Description'),
          customTextField(
            maxLines: 4,
              controller: contactCntrl.descCntrl.value,
              focusNode: contactCntrl.descFocus.value,
              hintText: 'Type Here...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(height: 10.h,),
          customButton(onPressed: (){},text: 'Send Message',width: Get.width)

        ],
      ),
    );
  }
}