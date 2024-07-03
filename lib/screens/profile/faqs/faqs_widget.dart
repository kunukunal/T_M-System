import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/faqs/faqs_controller.dart';

import '../../../common/widgets.dart';

class FaqsWidgets{

  //Search bar
  searchBar(){
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'))
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
        child: Row(
          children: [
            searchIcon,
            SizedBox(width: 10.w,),
            Text('Search',style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),)
          ],
        ),
      ),

    );
  }

  //faqs list widget
  faqsList(){
    final cntrl = Get.find<FaqsController>();
    return  Obx(
       () {
        return ListView.separated(
          physics: const PageScrollPhysics(),
          itemCount: cntrl.quesAnsList.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return customListTile(
              color:  cntrl.quesAnsList[index]['isExpanded']
                  ? HexColor('#EDF2FC')
                  : HexColor('#F8F8F8'),
                isDivider: true,
                elevation: 1,
                suffixUrl: cntrl.quesAnsList[index]['isExpanded']
                    ? upwardArrowIcon
                    : downwardArrowIcon,
                isExpanded: cntrl.quesAnsList[index]['isExpanded'],
                name: cntrl.quesAnsList[index]['ques'],
                description: cntrl.quesAnsList[index]['ans'],
                onTap: () {
                  cntrl.quesAnsList[index]['isExpanded'] =
                  !cntrl.quesAnsList[index]['isExpanded'];
                  cntrl.quesAnsList.refresh();
                });
          }),
          separatorBuilder: (context, index) => SizedBox(
            height: 12.h,
          ),
        );
      }
    );
  }
}