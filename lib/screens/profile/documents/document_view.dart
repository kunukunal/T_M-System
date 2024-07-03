import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/profile/documents/document_controller.dart';
import 'package:tanent_management/screens/profile/documents/document_widgets.dart';

import '../../../common/text_styles.dart';

class DocumentScreen extends StatelessWidget {
  final bool isFromTenant;
   DocumentScreen({super.key, required this.isFromTenant});

    final docCntrl = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        title: Text(isFromTenant?'Kirayedar Documents':'Document', style: CustomStyles.skipBlack),centerTitle: true,),
      body: Column(
        children: [
          Divider(height: 1.h,color: HexColor('#EBEBEB'),),
          SizedBox(height: 20.h,),
          Padding( padding:  EdgeInsets.symmetric(horizontal: 16.w,),
          child:
              DocumentWidgets().documentList(),
          ),
          isFromTenant?SizedBox.shrink():  Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
            child: Row(
              children: [
                addIcon,
                Text('Add Document(s)',style: CustomStyles.black16.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w500,fontFamily: 'Inter'),),
              ],
            ),
          )

        ],
      ),
    ));
  }
}
