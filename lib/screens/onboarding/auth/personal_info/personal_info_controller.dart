import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/navbar/navbar_view.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/services/dio_client_service.dart';

import '../landlord_document/landlord_view.dart';

class PersonalInfoController extends GetxController {
  final nameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final permanentAddCntrl = TextEditingController().obs;
  final pinNoCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;

  final nameFocus = FocusNode().obs;
  final emailFocus = FocusNode().obs;
  final phoneFocus = FocusNode().obs;
  final permanentFocus = FocusNode().obs;
  final pinNoFocus = FocusNode().obs;
  final cityFocus = FocusNode().obs;
  final stateFocus = FocusNode().obs;
  final imageFile = Rxn<XFile>();

  final aadharCntrl = TextEditingController().obs;
  final govIdCntrl = TextEditingController().obs;
  final otherDocCntrl = TextEditingController().obs;

  final aadharFocus = FocusNode().obs;
  final govIdFocus = FocusNode().obs;
  final otherDocFocus = FocusNode().obs;
  final showPercentage = 0.obs;
  final isPercentageLoadingStart = false.obs;
  final profileImage = Rxn<dynamic>();
  final documentTypeList = [].obs;
  final isDocumentTypeDataLoading = true.obs;
  final networkImage = "".obs;

  //finctions
  onPreviousTap() {
    Get.back();
  }

  @override
  void onInit() {
    if (documentTypeList.isEmpty) {
      getDocumentType();
    }
    super.onInit();
  }

  void onSubmitTap({required bool? isFromRegistered}) async {
    int index =
        documentTypeList.indexWhere((element) => element['image'] == null);
    if (index != -1) {
      customSnackBar(Get.context!, "Please add all the document");
    } else {
      isPercentageLoadingStart.value = true;
      showPercentage.value = 0; // Reset the percentage

      for (int i = 0; i < documentTypeList.length; i++) {
        await userDocumentUpdate(
            documentType: documentTypeList[i]['id'],
            file: documentTypeList[i]['image']);

        // Update the percentage
        showPercentage.value =
            ((i + 1) / documentTypeList.length * 100).toInt();
        showPercentage.refresh();
        if (i == documentTypeList.length - 1) {
          // Navigate to next screen based on the registration status
          if (isFromRegistered == true) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('is_personal_info_completed', true);
            Get.offAll(() => const NavBar(initialPage: 0));
          } else {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('is_personal_info_completed', true);
            Get.offAll(() => SignInScreen(isFromRegister: isFromRegistered));
          }
        }
      }
      isPercentageLoadingStart.value = false; // Stop loading indicator
    }
  }

  getDocumentType() async {
    isDocumentTypeDataLoading.value = true;
    final authCntrl = Get.put(AuthController());
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
    }, url: "$userDocumentType?limit=100&${authCntrl.onButtonTapTenant.value == 2 ? "for_tenant=true" : "for_landlord=true"}");
    if (response != null) {
      if (response.statusCode == 200) {
        isDocumentTypeDataLoading.value = false;
        final data = response.data;
        documentTypeList.clear();
        isPercentageLoadingStart.value = false;
        for (int i = 0; i < data['results'].length; i++) {
          documentTypeList.add({
            "id": data['results'][i]['id'],
            "type_title": data['results'][i]['type_title'],
            "image": null,
          });
        }
      } else if (response.statusCode == 400) {
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }

  userDocumentUpdate({
    required int documentType,
    required XFile file,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
 
        body: {
          'document_type': documentType,
          'image': await DioClientServices.instance.multipartFile(file: file)
        },
        headers: {
          "Accept-Language": languaeCode,
          'Authorization': "Bearer $accessToken",
        },
        url: userDocument);
    if (response != null) {
      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {}
    }
  }

  //functions
  onSkipTap({required bool? isFromRegister}) {
    Get.to(() => LandlordDocView(
          isFromregister: isFromRegister,
        ));
  }

  onNextTap({required bool? isFromRegister}) {
    if (nameCntrl.value.text.trim().isNotEmpty &&
        emailCntrl.value.text.trim().isNotEmpty &&
        permanentAddCntrl.value.text.trim().isNotEmpty &&
        cityCntrl.value.text.trim().isNotEmpty &&
        pinNoCntrl.value.text.trim().isNotEmpty &&
        stateCntrl.value.text.trim().isNotEmpty) {
      userProfileUpdate(isFromRegister: isFromRegister);
    } else {
      customSnackBar(Get.context!, "Please fill the data correctly");
    }
  }

  onSubmitPressed() {
    Get.offAll(() => const NavBar(initialPage: 0));
  }

  userProfileUpdate({required bool? isFromRegister}) async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";

    final response = await DioClientServices.instance.dioPostCall(

        body: imageFile.value != null
            ? {
                "profile_image": await DioClientServices.instance
                    .multipartFile(file: imageFile.value!),
                "name": nameCntrl.value.text.trim(),
                "email": emailCntrl.value.text.trim(),
                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                "state": stateCntrl.value.text.trim(),
                // "country": "Country",
                // "longitude": 98.5656665,
                // "latitude": 78.5656665,
              }
            : {
                "name": nameCntrl.value.text.trim(),
                "email": emailCntrl.value.text.trim(),
                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                "state": stateCntrl.value.text.trim(),
                // "country": "Country",
                // "longitude": 98.5656665,
                // "latitude": 78.5656665,
              },
        headers: {
          "Accept-Language": languaeCode,
          'Authorization': "Bearer $accessToken",
        },
        url: userProfile);
    if (response != null) {
      if (response.statusCode == 200) {
        customSnackBar(Get.context!, "Profile update Successfully");
        onSkipTap(isFromRegister: isFromRegister);
        log("Profile update Successfully.");
      } else if (response.statusCode == 400) {
        if (response.data.toString().contains("email")) {
          customSnackBar(Get.context!, response.data['email'][0].toString());
        }
      }
    }
  }

  getPersonalDetails() async {
    final authCntrl = Get.find<AuthController>();
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
      'Authorization': "Bearer $accessToken",
    }, url: userProfile);
    if (response != null) {
      if (response.statusCode == 200) {
        final data = response.data;
        authCntrl.onButtonTapTenant.value = data['user_type'] ?? 2;
        phoneCntrl.value.text = data['phone'] ?? "";
        authCntrl.selectedItem.value = "  ${data['phone_code']}";
        nameCntrl.value.text = data['name'] ?? "";
        emailCntrl.value.text = data['email'] ?? "";
        permanentAddCntrl.value.text = data['address'] ?? "";
        pinNoCntrl.value.text = data['zip_code'] ?? "";
        cityCntrl.value.text = data['city'] ?? "";
        stateCntrl.value.text = data['state'] ?? "";
        networkImage.value = data['profile_image'] ?? "";
      } else if (response.statusCode == 400) {
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }
}
