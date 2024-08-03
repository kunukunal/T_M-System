import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar/navbar_view.dart';
import 'package:tanent_management/screens/onboarding/auth/landlord_document/landlord_widget.dart';
import 'package:tanent_management/screens/onboarding/auth/personal_info/personal_info_controller.dart';

import '../../../../common/text_styles.dart';

class LandlordDocView extends StatelessWidget {
  final bool? isFromregister;
  LandlordDocView({this.isFromregister, super.key});
  final landlordDocCntrl = Get.find<PersonalInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Landlord Documents', style: CustomStyles.otpStyle050505),
          automaticallyImplyLeading: false,
          leading: Obx(() {
            return landlordDocCntrl.isPercentageLoadingStart.value
                ? const SizedBox.shrink() // Hide leading widget when loading
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
          }),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: InkWell(
                  onTap: () {
                    Get.offAll(() => const NavBar(initialPage: 0));
                  },
                  child: Text('Skip', style: CustomStyles.skipBlack)),
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: HexColor('#679BF1'),
                  height: 5.h,
                  width: Get.width,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    children: [
                      LandlordDocWidget.commomText(
                          'Submit essential photos/documents for smooth landlord-business relationship.',
                          fontsize: 16.sp - commonFontSize),
                      Obx(() {
                        return landlordDocCntrl
                                    .isDocumentTypeDataLoading.value ==
                                true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : landlordDocCntrl.documentTypeList.isEmpty
                                ? const Center(child: Text("No Document Found"))
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: landlordDocCntrl
                                        .documentTypeList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LandlordDocWidget.commomText(
                                            landlordDocCntrl
                                                    .documentTypeList[index]
                                                ['type_title'],
                                          ),
                                          LandlordDocWidget.commonDocUpload(
                                              index: index,
                                              title:
                                                  '${landlordDocCntrl.documentTypeList[index]['type_title']}',
                                              fileImage: landlordDocCntrl
                                                      .documentTypeList[index]
                                                  ['image']),
                                        ],
                                      );
                                    },
                                  );
                      }),

                      // ListView(
                      //   children: [
                      //     LandlordDocWidget.commomText(
                      //       'Aadhar Card Id',
                      //     ),
                      //     customTextField(
                      //       controller: landlordDocCntrl.aadharCntrl.value,
                      //         focusNode: landlordDocCntrl.aadharFocus.value,
                      //         textInputAction: TextInputAction.next,

                      //         hintText: 'Type Here...',
                      //         isBorder: true,
                      //         color: HexColor('#F7F7F7'),
                      //         isFilled: false),
                      //     LandlordDocWidget.commonDocUpload(
                      //         title: 'Upload Aadhar Card'),
                      //     // LandlordDocWidget.commomText(
                      //     //   'Government-issued ID Card Number',
                      //     // ),
                      //     // customTextField(
                      //     //     controller: landlordDocCntrl.govIdCntrl.value,
                      //     //     focusNode: landlordDocCntrl.govIdFocus.value,
                      //     //     textInputAction: TextInputAction.next,

                      //     //     hintText: 'Type Here...',
                      //     //     isBorder: true,
                      //     //     color: HexColor('#F7F7F7'),
                      //     //     isFilled: false),
                      //     // LandlordDocWidget.commonDocUpload(
                      //     //     title: 'Upload Government Card'),
                      //     // LandlordDocWidget.commomText(
                      //     //   'Other Documents',
                      //     // ),
                      //     // customTextField(
                      //     //     controller: landlordDocCntrl.otherDocCntrl.value,
                      //     //     focusNode: landlordDocCntrl.otherDocFocus.value,
                      //     //     textInputAction: TextInputAction.done,
                      //     //     hintText: 'Type Here...',
                      //     //     isBorder: true,
                      //     //     color: HexColor('#F7F7F7'),
                      //     //     isFilled: false),
                      //     // LandlordDocWidget.commonDocUpload(
                      //     //     title: 'Upload Government Card'),
                    ],
                  ),

                  //  landlordDocCntrl.isPercentageLoadingStart.value
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return landlordDocCntrl.isPercentageLoadingStart.value
              ? const Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customBorderButton('Previous', () {
                      landlordDocCntrl.onPreviousTap();
                    },
                        verticalPadding: 10.h,
                        horizontalPadding: 2.w,
                        btnHeight: 40.h,
                        width: Get.width / 2.3,
                        borderColor: HexColor('#679BF1'),
                        textColor: HexColor('#679BF1')),
                    customBorderButton('Submit', () {
                      landlordDocCntrl.onSubmitTap(
                          isFromRegistered: isFromregister);
                    },
                        verticalPadding: 10.h,
                        horizontalPadding: 2.w,
                        btnHeight: 40.h,
                        width: Get.width / 2.3,
                        color: HexColor('#679BF1'),
                        textColor: HexColor('#FFFFFF'),
                        borderColor: Colors.transparent)
                  ],
                );
        }));
  }
}
