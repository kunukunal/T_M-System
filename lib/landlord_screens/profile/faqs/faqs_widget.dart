import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/profile/faqs/faqs_controller.dart';

import '../../../common/widgets.dart';

class FaqsWidgets {
  //Search bar
  searchBar() {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: HexColor('#EBEBEB'))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Row(
          children: [
            searchIcon,
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Search',
              style: CustomStyles.desc606060.copyWith(fontFamily: 'DM Sans'),
            )
          ],
        ),
      ),
    );
  }

  //faqs list widget
  faqsList() {
    final cntrl = Get.find<FaqsController>();
    return Obx(() {
      return cntrl.faqLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : cntrl.quesAnsList.isEmpty
              ? const Center(
                  child: Text("No FAQ found"),
                )
              : ListView.separated(
                  physics: const PageScrollPhysics(),
                  itemCount: cntrl.quesAnsList.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return customListTile(
                        color: cntrl.quesAnsList[index]['isExpand'] == true
                            ? HexColor('#EDF2FC')
                            : HexColor('#F8F8F8'),
                        isDivider: true,
                        elevation: 1,
                        suffixUrl: cntrl.quesAnsList[index]['isExpand'] == true
                            ? upwardArrowIcon
                            : downwardArrowIcon,
                        isExpanded: cntrl.quesAnsList[index]['isExpand'],
                        name: cntrl.quesAnsList[index]['question'],
                        description: cntrl.quesAnsList[index]['answer'],
                        onTap: () {
                          cntrl.quesAnsList[index]['isExpand'] =
                              !cntrl.quesAnsList[index]['isExpand'];
                          cntrl.quesAnsList.refresh();
                        });
                  }),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12.h,
                  ),
                );
    });
  }
}
