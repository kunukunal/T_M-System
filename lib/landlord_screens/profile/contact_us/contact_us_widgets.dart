import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/profile/contact_us/contact_us_controller.dart';

import '../../../common/widgets.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';

class ContactUsWidgets {
  //address & contact info container
  addressContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'contact_us'.tr,
              textAlign: TextAlign.center,
              style: CustomStyles.title414141,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'DaqOrbit Automation and Services (OPC) Private Limited New Delhi, East Delhi',
            textAlign: TextAlign.center,
            style: CustomStyles.title898989,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Call :+91 9898129898\nEmail : support@tmsystem.com',
            textAlign: TextAlign.center,
            style: CustomStyles.title898989,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'send_message'.tr,
            style: CustomStyles.title414141,
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  contactUsForm() {
    final contactCntrl = Get.find<ContactUsController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonlInfoWidget.commomText('full_name'.tr),
          customTextField(
              controller: contactCntrl.nameCntrl.value,
              focusNode: contactCntrl.nameFocus.value,
              keyboardType: TextInputType.name,
              hintText: '${'type_here'.tr}...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(
            height: 10.h,
          ),
          PersonlInfoWidget.commomText('email_id'.tr),
          customTextField(
              controller: contactCntrl.emailCntrl.value,
              focusNode: contactCntrl.emailFocus.value,
              keyboardType: TextInputType.emailAddress,
              hintText: '${'type_here'.tr}...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(
            height: 10.h,
          ),
          PersonlInfoWidget.commomText('description'.tr),
          customTextField(
              maxLines: 4,
              controller: contactCntrl.descCntrl.value,
              focusNode: contactCntrl.descFocus.value,
              hintText: '${'type_here'.tr}...',
              isBorder: true,
              color: HexColor('#F7F7F7'),
              isFilled: false),
          SizedBox(
            height: 10.h,
          ),
          customButton(
              onPressed: () {
                contactCntrl.onSubmitMessage();
              },
              text: 'send_message'.tr,
              width: Get.width)
        ],
      ),
    );
  }
}
