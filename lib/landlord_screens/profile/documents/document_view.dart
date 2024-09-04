import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/dashboard/tenant/add_tenant/tenant_documents.dart';
import 'package:tanent_management/landlord_screens/profile/documents/document_controller.dart';
import 'package:tanent_management/landlord_screens/profile/documents/document_widgets.dart';

import '../../../common/text_styles.dart';

class DocumentScreen extends StatelessWidget {
  final bool isFromTenant;
  DocumentScreen({super.key, required this.isFromTenant});

  final docCntrl = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        title: Text(isFromTenant ? 'kirayedar_documents'.tr : 'documents'.tr,
            style: CustomStyles.skipBlack),
        centerTitle: true,
        actions: [
          Obx(() {
            return docCntrl.documentList.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => TenantDocScreen(), arguments: [
                        docCntrl.userId.value,
                        docCntrl.isFromTenant.value,
                        {
                          'isEdit': true,
                          'isConsent': true,
                          'isFromTenantDoc': docCntrl.isFromTenant.value,
                          'docList': docCntrl.documentList
                        },
                        !docCntrl.islandLord.value
                      ])!
                          .then((value) {
                        if (value == true) {
                          docCntrl.getDocumentById();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: editIcon,
                    ),
                  )
                : const SizedBox();
          })
        ],
      ),
      body: Column(
        children: [
          Divider(
            height: 1.h,
            color: HexColor('#EBEBEB'),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: DocumentWidgets().documentList(),
          ),
          // isFromTenant
          //     ? SizedBox.shrink()
          //     : Padding(
          //         padding:
          //             EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          //         child: Row(
          //           children: [
          //             addIcon,
          //             Text(
          //               'Add Document(s)',
          //               style: CustomStyles.black16.copyWith(
          //                   fontSize: 16.sp - commonFontSize,
          //                   fontWeight: FontWeight.w500,
          //                   fontFamily: 'Inter'),
          //             ),
          //           ],
          //         ),
          //       )
        ],
      ),
    );
  }
}
