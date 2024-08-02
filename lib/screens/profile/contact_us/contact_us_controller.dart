import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class ContactUsController extends GetxController {
  //variables
  final nameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final descCntrl = TextEditingController().obs;

  final nameFocus = FocusNode().obs;
  final emailFocus = FocusNode().obs;
  final descFocus = FocusNode().obs;

// @override
// void onInit() {

//   super.onInit();
// }

  onSubmitMessage() {
    if (nameCntrl.value.text.trim().isNotEmpty) {
      if (emailCntrl.value.text.trim().isNotEmpty) {
        if (descCntrl.value.text.trim().isNotEmpty) {
          sendMessageToContact();
        } else {
          customSnackBar(Get.context!, "Please enter the Description");
        }
      } else {
        customSnackBar(Get.context!, "Please enter your email");
      }
    } else {
      customSnackBar(Get.context!, "Please enter your name");
    }
  }

  sendMessageToContact() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    String languaeCode = prefs.getString('languae_code') ?? "en";

    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "name": nameCntrl.value.text,
        "email": emailCntrl.value.text,
        "message": descCntrl.value.text
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: contactUs,
    );

    if (response != null) {
      if (response.statusCode == 201) {
        nameCntrl.value.clear();
        emailCntrl.value.clear();
        descCntrl.value.clear();
        Get.back();
        customSnackBar(Get.context!, "Your request submit successfully");
      } else if (response.statusCode == 400) {
        customSnackBar(Get.context!, response.data['email'][0]);
        // Handle error
      } else if (response.statusCode == 404) {
        // Handle error
      }
    }
  }
}
