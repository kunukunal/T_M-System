import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/text_styles.dart';

class AddUnitWidget{
  appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: backArrowImage,
        ),
      ),
      centerTitle: true,
      title: Text('Unit 1', style: CustomStyles.otpStyle050505W700S16),
      bottom:  PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1,color: lightBorderGrey,),
      ),
    );
  }

  commomText(String title, {bool? isMandatory=false}){
    return Padding(
      padding:  EdgeInsets.only(top: 8.h,bottom: 8.h),
      child: isMandatory!? Row(
        children: [
          Text(title,style: TextStyle(fontFamily: 'Inter', color: HexColor('#111111'),fontSize: 16.sp)),
          Text('*',style: TextStyle(fontFamily: 'Inter', color: HexColor('#EF5E4E'),fontSize: 16.sp)),
        ],
      ):Text(title,style: TextStyle(fontFamily: 'Inter', color: HexColor('#111111'),fontSize: 16.sp)),
    );
  }
}