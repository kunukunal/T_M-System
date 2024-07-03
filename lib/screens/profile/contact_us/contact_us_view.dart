import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/profile/contact_us/contact_us_controller.dart';
import 'package:tanent_management/screens/profile/contact_us/contact_us_widgets.dart';

import '../../../common/text_styles.dart';

class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});

   final contactCntrl= Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(title: Text('Contact Us', style: CustomStyles.skipBlack)),
      body: Column(
        children: [
          Divider(height: 1.h,color: HexColor('#EBEBEB'),),
          SizedBox(height: 20.h,),
          ContactUsWidgets().addressContainer(),
          ContactUsWidgets().contactUsForm(),

        ],
      ),
    ));
  }
}
