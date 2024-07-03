import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_widgets.dart';
import '../../../../common/text_styles.dart';
import '../../../../common/widgets.dart';
import '../../../onboarding/auth/landlord_document/landlord_widget.dart';
import 'add_tenant_controller.dart';

class TenantDocScreen extends StatelessWidget {
   TenantDocScreen({super.key});

   final tanentCntrl = Get.find<AddTenantController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          centerTitle: true,
          title: Text('Kirayedar Documents', style: CustomStyles.otpStyle050505W700S16),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 1.h,color: HexColor('#EBEBEB'),),

            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: ListView(
                    children: [
                      SizedBox(height: 10.h,),
                      LandlordDocWidget.commomText(
                        'Aadhar Card ID',
                      ),
                      customTextField(
                          controller: tanentCntrl.aadharCntrl.value,
                          focusNode: tanentCntrl.aadharFocus.value,
                          textInputAction: TextInputAction.next,

                          hintText: 'Aadhar card number',
                          isBorder: true,
                          color: HexColor('#F7F7F7'),
                          isFilled: false),
                      AddTenantWidgets.commonDocUpload(
                          title: 'Upload Aadhar Card'),
                      LandlordDocWidget.commomText(
                        'Police Verification Documents',
                      ),
                      customTextField(
                          controller: tanentCntrl.policeVerificationCntrl.value,
                          focusNode: tanentCntrl.policeVerificationFocus.value,
                          textInputAction: TextInputAction.next,

                          hintText: 'Document number',
                          isBorder: true,
                          color: HexColor('#F7F7F7'),
                          isFilled: false),
                      AddTenantWidgets.commonDocUpload(
                          title: 'Upload Police Verification Documents'),
                      LandlordDocWidget.commomText(
                        'Other Documents',
                      ),
                      Container(
                        height: 140.h,
                        child: ListView.separated(
                          separatorBuilder: (context,index){
                            return SizedBox(width: 10.w,);
                          },
                          scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return AddTenantWidgets.commonDocUpload(
                                  title: 'Upload Document');
                            }),
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBorderButton('Previous', () {
                            tanentCntrl.onPreviousTap();
                          },
                              verticalPadding: 10.h,
                              horizontalPadding: 2.w,
                              btnHeight: 40.h,
                              width: Get.width / 2.3,
                              borderColor: HexColor('#679BF1'),
                              textColor: HexColor('#679BF1')),
                          customBorderButton('Submit', () {
                            tanentCntrl.onSubmitTap();
                          },
                              verticalPadding: 10.h,
                              horizontalPadding: 2.w,
                              btnHeight: 40.h,
                              width: Get.width / 2.3,
                              color: HexColor('#679BF1'),
                              textColor: HexColor('#FFFFFF'),
                              borderColor: Colors.transparent)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
