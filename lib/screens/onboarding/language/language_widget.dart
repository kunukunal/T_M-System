import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/onboarding/language/language_controller.dart';

class LanguageWidget{

  //widgets
  static languageSelectionWidget(){
    final langCntrl = Get.find<LanguageController>();
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: langCntrl.languageList.length,
        itemBuilder: (context,index) {
          return Padding(
            padding:  EdgeInsets.only(top: 8.h),
            child: InkWell(
              onTap: (){
                langCntrl.onLanguageChange(index);
              },
              child: Obx(
                 () {
                  return Container(
                      height: 55.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border:langCntrl.languageList[index]['isSelected']? Border.all(color: HexColor('#679BF1'),width: 2.r):Border.all(color: HexColor('#EBEBEB'),width: 1.r)
                    ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      langCntrl.languageList[index]['icon'],
                      SizedBox(width: 10.w,),
                      Text(langCntrl.languageList[index]['name'],style: CustomStyles.black1E1C1C,)
                    ],
                  ),
                      );
                }
              ),
            ),
          );
        }
      ),
    );
}
}