import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class EditProfileWidget{

  static   commomText(String title, {bool? isMandatory=false}){
    return Padding(
      padding:  EdgeInsets.only(top: 5.h,bottom: 5.h),
      child: isMandatory!? Row(
        children: [
          Text(title,style: TextStyle(fontFamily: 'Inter', color: HexColor('#111111'),fontSize: 16.sp)),
          Text('*',style: TextStyle(fontFamily: 'Inter', color: HexColor('#EF5E4E'),fontSize: 16.sp)),
        ],
      ):Text(title,style: TextStyle(fontFamily: 'Inter', color: HexColor('#111111'),fontSize: 16.sp)),
    );
  }
}