import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_documents_controller.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_widgets.dart';

import '../../../../common/text_styles.dart';
import '../../../../common/widgets.dart';
import '../../../onboarding/auth/landlord_document/landlord_widget.dart';

class TenantDocScreen extends StatelessWidget {
  TenantDocScreen({super.key});
  final addTenantDocCntrl = Get.put(AddTenantDocumentController());
  // final addTenantCntrl = Get.put(AddTenantController());

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
          centerTitle: true,
          title: Text('Kirayedar Documents',
              style: CustomStyles.otpStyle050505W700S16),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              height: 1.h,
              color: HexColor('#EBEBEB'),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Obx(() {
                return addTenantDocCntrl.doumentLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : addTenantDocCntrl.documentList.isEmpty
                        ? const Center(
                            child: Text("No Document found"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LandlordDocWidget.commomText(
                                    addTenantDocCntrl.documentList[index]
                                        ['type_title'],
                                  ),
                                  AddTenantWidgets.commonDocUpload(
                                      title: addTenantDocCntrl
                                          .documentList[index]['type_title'],
                                      index: index),
                                ],
                              );
                            },

                            itemCount: addTenantDocCntrl.documentList.length,
                            // children: [
                            //   SizedBox(
                            //     height: 10.h,
                            //   ),
                            //   LandlordDocWidget.commomText(
                            //     'Aadhar Card ID',
                            //   ),
                            //   // customTextField(
                            //   //     controller: addTenantDocCntrl.aadharCntrl.value,
                            //   //     focusNode: addTenantDocCntrl.aadharFocus.value,
                            //   //     textInputAction: TextInputAction.next,

                            //   //     hintText: 'Aadhar card number',
                            //   //     isBorder: true,
                            //   //     color: HexColor('#F7F7F7'),
                            //   //     isFilled: false),
                            //   AddTenantWidgets.commonDocUpload(title: 'Upload Aadhar Card'),
                            //   LandlordDocWidget.commomText(
                            //     'Police Verification Documents',
                            //   ),
                            //   // customTextField(
                            //   //     controller: addTenantDocCntrl.policeVerificationCntrl.value,
                            //   //     focusNode: addTenantDocCntrl.policeVerificationFocus.value,
                            //   //     textInputAction: TextInputAction.next,

                            //   //     hintText: 'Document number',
                            //   //     isBorder: true,
                            //   //     color: HexColor('#F7F7F7'),
                            //   //     isFilled: false),
                            //   AddTenantWidgets.commonDocUpload(
                            //       title: 'Upload Police Verification Documents'),
                            //   LandlordDocWidget.commomText(
                            //     'Other Documents',
                            //   ),
                            //   Container(
                            //     height: 140.h,
                            //     child: ListView.separated(
                            //         separatorBuilder: (context, index) {
                            //           return SizedBox(
                            //             width: 10.w,
                            //           );
                            //         },
                            //         scrollDirection: Axis.horizontal,
                            //         itemCount: 2,
                            //         shrinkWrap: true,
                            //         itemBuilder: (context, index) {
                            //           return AddTenantWidgets.commonDocUpload(
                            //               title: 'Upload Document');
                            //         }),
                            //   ),

                            //   // Row(
                            //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   //   children: [
                            //   //     customBorderButton('Previous', () {
                            //   //       addTenantDocCntrl.onPreviousTap();
                            //   //     },
                            //   //         verticalPadding: 10.h,
                            //   //         horizontalPadding: 2.w,
                            //   //         btnHeight: 40.h,
                            //   //         width: Get.width / 2.3,
                            //   //         borderColor: HexColor('#679BF1'),
                            //   //         textColor: HexColor('#679BF1')),
                            //   //     customBorderButton('Submit', () {
                            //   //       addTenantDocCntrl.onSubmitTap();
                            //   //     },
                            //   //         verticalPadding: 10.h,
                            //   //         horizontalPadding: 2.w,
                            //   //         btnHeight: 40.h,
                            //   //         width: Get.width / 2.3,
                            //   //         color: HexColor('#679BF1'),
                            //   //         textColor: HexColor('#FFFFFF'),
                            //   //         borderColor: Colors.transparent)
                            //   //   ],
                            //   // )
                            // ],
                          );
              }),
            ))
          ],
        ),
        bottomNavigationBar: Obx(
          () => addTenantDocCntrl.documentUploading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : customBorderButton('Submit', () {
                  addTenantDocCntrl.onSubmitTap();
                },
                  verticalPadding: 10.h,
                  horizontalPadding: 2.w,
                  btnHeight: 40.h,
                  width: Get.width / 2.3,
                  color: HexColor('#679BF1'),
                  textColor: HexColor('#FFFFFF'),
                  borderColor: Colors.transparent),
        ));
  }
}
