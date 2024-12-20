import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/profile/documents/document_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:widget_zoom/widget_zoom.dart';

class DocumentWidgets {
  documentList() {
    final docCntrl = Get.find<DocumentController>();
    return Obx(() {
      return docCntrl.kiryederDocumentLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : docCntrl.documentList.isEmpty
              ? Center(
                  child: Text("no_document_found".tr),
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
                      image: docCntrl.documentList[index]['image'] ?? "",
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
    return GestureDetector(
      onTap: () {
        if (image != "")
          showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            enableDrag: false,
            useSafeArea: true,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      Material(
                        child: WidgetZoom(
                          heroAnimationTag: 'tag',
                          zoomWidget: Image.network(image),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        else
          customSnackBar(Get.context!, "no_document_found".tr);
      },
      child: Stack(
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
            child: image == ""
                ? SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("no_document_uploaded".tr)))
                : Image.network(
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
                        fontSize: 16.sp - commonFontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                    if (image != "")
                      GestureDetector(
                          onTap: () {
                            _saveNetworkImage(image);
                          },
                          child: downloadIcon)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _saveNetworkImage(String url) async {
    try {
      await DioClientServices.instance.saveImageToGallery(url).then((value) {
        if (value['isSuccess'] == true) {
          customSnackBar(Get.context!, "document_download_successfully".tr);
        }
      });
    } on Error {
      throw 'Error has occured while saving';
    }
  }
}
