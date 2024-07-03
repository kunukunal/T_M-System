import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/tenant_documents.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_view.dart';

import '../../../../common/widgets.dart';

class AddTenantController extends GetxController{
  final firstNameCntrl = TextEditingController().obs;
  final lastNameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final permanentAddCntrl = TextEditingController().obs;
  final streetdCntrl = TextEditingController().obs;
  final pinNoCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;


  final aadharCntrl = TextEditingController().obs;
  final policeVerificationCntrl = TextEditingController().obs;

  final  aadharFocus = FocusNode().obs;
  final  policeVerificationFocus = FocusNode().obs;

  final  firstNameFocus = FocusNode().obs;
  final  lastNameFocus = FocusNode().obs;
  final  emailFocus = FocusNode().obs;
  final  phoneFocus = FocusNode().obs;
  final  permanentFocus = FocusNode().obs;
  final  streetdtFocus = FocusNode().obs;
  final  pinNoFocus = FocusNode().obs;
  final  cityFocus = FocusNode().obs;
  final  stateFocus = FocusNode().obs;

  final profileImage = Rxn<File>();
  final imageFile =Rxn<File>();

  //functions
  onNextTap(){
    Get.to(()=>TenantDocScreen());
  }
  onPreviousTap(){
    Get.back();
  }
  onSubmitTap(){
    // Get.back();
    // Get.back();
    Get.to(()=>TenantListScreen());
  }


}
