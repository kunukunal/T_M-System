import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/navbar/navbar_view.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/landlord_screens/onboarding/auth/login_view/sign_in.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/tenant_screens/navbar/navbar_view.dart';

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
  final isPercentageLoadingStart = false.obs;
  final profileImage = Rxn<dynamic>();
  final documentTypeList = [].obs;
  final isDocumentTypeDataLoading = false.obs;
  final networkImage = "".obs;

  final selectedState = "Select".obs;

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
      userDocumentUpdate(isFromRegistered: isFromRegistered);
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

  userDocumentUpdate({bool? isFromRegistered}) async {
    final authCntrl = Get.put(AuthController());

    isPercentageLoadingStart.value = true;
    List id = [];
    List image = [];
    for (int i = 0; i < documentTypeList.length; i++) {
      id.add(documentTypeList[i]['id']);
      image.add(await DioClientServices.instance
          .multipartFile(file: documentTypeList[i]['image']));
    }

    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(body: {
      'document_type': jsonEncode(id),
      'image': image
    }, headers: {
      "Accept-Language": languaeCode,
      'Authorization': "Bearer $accessToken",
    }, url: userDocument);
    if (response != null) {
      if (response.statusCode == 200) {
        isPercentageLoadingStart.value = false;
        if (isFromRegistered == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('is_personal_info_completed', true);
          // Get.offAll(() => const NavBar(initialPage: 0));
          if (authCntrl.onButtonTapTenant.value == 1) {
            Get.offAll(() => const NavBar(initialPage: 0));
          } else {
            Get.offAll(() => const NavBarTenant(initialPage: 0));
          }
        } else {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('is_personal_info_completed', true);
          Get.offAll(() => SignInScreen(isFromRegister: isFromRegistered));
        }
        customSnackBar(Get.context!, response.data['message'][0]);
      } else if (response.statusCode == 400) {
        isPercentageLoadingStart.value = false;
        if (response.data['error'] != null) {
          customSnackBar(Get.context!, response.data['error'][0]);
        } else {
          customSnackBar(Get.context!, response.data['document_type'][0]);
        }
      }
    }
  }

  //functions
  onSkipTap({required bool? isFromRegister, bool isFromApi = false}) {
    final authCntrl = Get.put(AuthController());

    if (isFromApi) {
      Get.to(() => LandlordDocView(
            isFromregister: isFromRegister,
          ));
    } else {
      if (authCntrl.onButtonTapTenant.value == 1) {
        Get.offAll(() => const NavBar(initialPage: 0));
      } else {
        Get.offAll(() => const NavBarTenant(initialPage: 0));
      }
    }
    // Get.to(() => LandlordDocView(
    //       isFromregister: isFromRegister,
    //     ));
  }

  onNextTap({required bool? isFromRegister}) {
    if (nameCntrl.value.text.trim().isNotEmpty) {
      // if (emailCntrl.value.text.trim().isNotEmpty) {
      if (permanentAddCntrl.value.text.trim().isNotEmpty) {
        if (pinNoCntrl.value.text.trim().isNotEmpty) {
          if (selectedState.value != "Select") {
            if (cityCntrl.value.text.trim().isNotEmpty) {
              userProfileUpdate(isFromRegister: isFromRegister);
            } else {
              customSnackBar(Get.context!, "Please Enter your City");
            }
          } else {
            customSnackBar(Get.context!, "Please Enter your State");
          }
        } else {
          customSnackBar(Get.context!, "Please Enter your Pin code");
        }
      } else {
        customSnackBar(Get.context!, "Please Enter your Permanent Address");
      }
      // } else {
      //   customSnackBar(Get.context!, "Please Enter your Email");
      // }
    } else {
      customSnackBar(Get.context!, "Please Enter your name");
    }

    // if (nameCntrl.value.text.trim().isNotEmpty &&
    //     // emailCntrl.value.text.trim().isNotEmpty &&
    //     permanentAddCntrl.value.text.trim().isNotEmpty &&
    //     cityCntrl.value.text.trim().isNotEmpty &&
    //     pinNoCntrl.value.text.trim().isNotEmpty &&
    //     stateCntrl.value.text.trim().isNotEmpty) {
    //   userProfileUpdate(isFromRegister: isFromRegister);
    // } else {
    //   customSnackBar(Get.context!, "Please fill the data correctly");
    // }
  }

  onSubmitPressed() {
    final authCntrl = Get.put(AuthController());

    if (authCntrl.onButtonTapTenant.value == 1) {
      Get.offAll(() => const NavBar(initialPage: 0));
    } else {
      Get.offAll(() => const NavBarTenant(initialPage: 0));
    }
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
                if (emailCntrl.value.text.isNotEmpty)
                  "email": emailCntrl.value.text.trim(),

                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                // "state": stateCntrl.value.text.trim(),
                "state": selectedState.value,
                // "country": "Country",
                // "longitude": 98.5656665,
                // "latitude": 78.5656665,
              }
            : {
                "name": nameCntrl.value.text.trim(),
                if (emailCntrl.value.text.isNotEmpty)
                  "email": emailCntrl.value.text.trim(),
                // "age": 19,
                // "gender": "M",
                "address": permanentAddCntrl.value.text.trim(),
                "city": cityCntrl.value.text.trim(),
                "zip_code": pinNoCntrl.value.text,
                // "state": stateCntrl.value.text.trim(),
                "state": selectedState.value,

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
        onSkipTap(isFromRegister: isFromRegister, isFromApi: true);
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
        // stateCntrl.value.text = data['state'] ?? "";
        checkIsState(data['state'] ?? "");
        networkImage.value = data['profile_image'] ?? "";
      } else if (response.statusCode == 400) {
        // if (response.data.toString().contains("email")) {
        //   customSnackBar(Get.context!, response.data['email'][0].toString());
        // }
      }
    }
  }

  checkIsState(String value) {
    bool data = state.contains(value);
    if (data) {
      selectedState.value = value;
    } else {
      selectedState.value = "Select";
    }
  }
}