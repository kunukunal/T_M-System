import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/profile/documents/document_controller.dart';

class DocumentWidgets {
  //Documents List
  documentList() {
    final docCntrl = Get.find<DocumentController>();
    return Obx(() {
      return docCntrl.kiryederDocumentLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : docCntrl.documentList.isEmpty
              ? const Center(
                  child: Text("No document found"),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: docCntrl.documentList.length,
                  itemBuilder: (context, index) {
                    return documentContainer(
                      image: docCntrl.documentList[index]['image'],
                      name: docCntrl.documentList[index]['document_type_value'],
                    );
                  });
    });
  }

  //Document container
  documentContainer({
    required String image,
    required String name,
  }) {
    return Stack(
      children: [
        Container(
          height: 158.h,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'), width: 1.r),
            // image:  DecorationImage(image: image.image)
          ),
          child: Image.network(
            image,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
        Positioned(
          left: .5,
          right: .5,
          bottom: .5,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: HexColor('#D9E3F4'),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: CustomStyles.skipBlack.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  // downloadIcon
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
