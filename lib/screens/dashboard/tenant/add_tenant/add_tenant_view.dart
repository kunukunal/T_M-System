import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_widgets.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_controller.dart';

import '../../../../common/constants.dart';
import '../../../../common/text_styles.dart';
import '../../../../common/widgets.dart';
import '../../../onboarding/auth/login_view/auth_controller.dart';
import '../../../profile/edit_profile/edit_profile_widget.dart';
import 'add_tenant_controller.dart';

class AddTenantScreen extends StatelessWidget {
  AddTenantScreen({super.key});

  final addTenantCntrl = Get.put(AddTenantController());
  final authCntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
           Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: backArrowImage,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: Text('Add Kirayedar', style: CustomStyles.otpStyle050505W700S16),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color:HexColor('#EBEBEB'),height: 1.h,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                         () {
                          return InkWell(
                            onTap: (){
                              AddTenantWidgets(). showSelectionDialog(Get.context!,true);
                            },
                            child:  addTenantCntrl.profileImage.value != null
                                ?  ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                height: 99.h,
                                width: 110.w,
                                decoration: BoxDecoration(
                                  color: HexColor('#444444'),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                      Image.file(addTenantCntrl.profileImage.value!)
                                          .image,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ):Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    height: 99.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                      color: HexColor('#444444'),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                          Image.asset('assets/icons/profile.png')
                                              .image,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0.h,
                                    right: 0.w,
                                    child:Stack(
                                      children: [
                                        backgroundCameraIcon,
                                        Positioned(
                                          top: 11.h,
                                          bottom: 11.h,
                                          right: 10.w,
                                          left: 10.w,
                                            child: cameraTenantIcon)
                                      ],
                                    ))
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('First Name'),
                          customTextField(
                            controller: addTenantCntrl.firstNameCntrl.value,
                              focusNode: addTenantCntrl.firstNameFocus.value,
                              keyboardType: TextInputType.name,
                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('last Name'),
                          customTextField(
                              controller: addTenantCntrl.lastNameCntrl.value,
                              focusNode: addTenantCntrl.lastNameFocus.value,
                              keyboardType: TextInputType.name,
                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('Email Address'),
                  customTextField(
                      controller: addTenantCntrl.emailCntrl.value,
                      focusNode: addTenantCntrl.emailFocus.value,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('Mobile Number'),
                  customTextField(
                      controller: addTenantCntrl.phoneCntrl.value,
                      focusNode: addTenantCntrl.phoneFocus.value,
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Mobile Number',
                      isBorder: true,
                      maxLength: 10,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      isForCountryCode: true),
                  SizedBox(
                    height: 5.h,
                  ),
                  EditProfileWidget.commomText('Address'),
                  customTextField(
                      controller: addTenantCntrl.permanentAddCntrl.value,
                      focusNode: addTenantCntrl.permanentFocus.value,
                      keyboardType: TextInputType.streetAddress,
                      hintText: 'Type Here...',
                      isBorder: true,
                      color: HexColor('#F7F7F7'),
                      isFilled: false,
                      maxLines: 3),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('Landmark'),
                          customTextField(
                            controller: addTenantCntrl.streetdCntrl.value,
                            focusNode: addTenantCntrl.streetdtFocus.value,
                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('Pin Code',isMandatory: true),
                          customTextField(
                              controller: addTenantCntrl.pinNoCntrl.value,
                              focusNode: addTenantCntrl.pinNoFocus.value,

                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('City',isMandatory: true),
                          customTextField(
                            controller: addTenantCntrl.cityCntrl.value,
                            focusNode: addTenantCntrl.cityFocus.value,
                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditProfileWidget.commomText('State',isMandatory: true),
                          customTextField(
                              controller: addTenantCntrl.stateCntrl.value,
                              focusNode: addTenantCntrl.stateFocus.value,

                              width: Get.width / 2.3,
                              hintText: 'Type Here...',
                              isBorder: true,
                              color: HexColor('#F7F7F7'),
                              isFilled: false),
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  customButton(
                      onPressed: () {
                       addTenantCntrl.onNextTap();

                      },
                      text: 'Next',
                      width: Get.width,
                      verticalPadding: 10.h),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    ));
  }
}
