import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/add_tenant_widgets.dart';
import 'package:tanent_management/screens/dashboard/tenant/add_tenant/tenant_documents.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class AddTenantController extends GetxController {
  final name = TextEditingController().obs;

  final emailCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final permanentAddCntrl = TextEditingController().obs;
  final streetdCntrl = TextEditingController().obs;
  final pinNoCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;

  final aadharCntrl = TextEditingController().obs;
  final policeVerificationCntrl = TextEditingController().obs;

  final aadharFocus = FocusNode().obs;
  final policeVerificationFocus = FocusNode().obs;

  final firstNameFocus = FocusNode().obs;
  // final lastNameFocus = FocusNode().obs;
  final emailFocus = FocusNode().obs;
  final phoneFocus = FocusNode().obs;
  final permanentFocus = FocusNode().obs;
  final streetdtFocus = FocusNode().obs;
  final pinNoFocus = FocusNode().obs;
  final cityFocus = FocusNode().obs;
  final stateFocus = FocusNode().obs;

  final profileImage = Rxn<XFile>();

  final isFromCheckTenat = false.obs;

  @override
  onInit() {
    isFromCheckTenat.value = Get.arguments[0];

    if (isFromCheckTenat.value) {
      final data = Get.arguments[1];

      phoneCntrl.value.text = data['phone'];
    }

    super.onInit();
  }

  //functions
  onNextTap() {
    if (name.value.text.trim().isNotEmpty) {
      if (emailCntrl.value.text.trim().isNotEmpty) {
        if (phoneCntrl.value.text.trim().isNotEmpty) {
          if (pinNoCntrl.value.text.trim().isNotEmpty) {
            if (cityCntrl.value.text.trim().isNotEmpty) {
              if (stateCntrl.value.text.trim().isNotEmpty) {
                addTenantByLandLordApi();
              } else {
                customSnackBar(Get.context!, "Please enter the State");
              }
            } else {
              customSnackBar(Get.context!, "Please enter the city");
            }
          } else {
            customSnackBar(Get.context!, "Please enter the pincode");
          }
        } else {
          customSnackBar(Get.context!, "Please enter the phone number");
        }
      } else {
        customSnackBar(Get.context!, "Please enter the email");
      }
    } else {
      customSnackBar(Get.context!, "Please enter the name");
    }

    // Get.to(() => TenantDocScreen());
  }

  final addTenantByLandlordLaoding = false.obs;
  final addTenantOtpVerify = false.obs;

  addTenantByLandLordApi({bool istenantaddfromOtp = true}) async {
    final authCntrl = Get.find<AuthController>();
    authCntrl.otpController1.value.clear();
    authCntrl.otpController2.value.clear();
    authCntrl.otpController3.value.clear();
    authCntrl.otpController4.value.clear();

    final image = profileImage.value != null
        ? await DioClientServices.instance
            .multipartFile(file: profileImage.value!)
        : null;
    addTenantByLandlordLaoding.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "user_type": 2,
        "phone_code": authCntrl.selectedItem.trim(),
        "phone": phoneCntrl.value.text.trim(),
        "name": name.value.text.trim(),
        "profile_image": image,
        "email": emailCntrl.value.text.trim(),
        "address": permanentAddCntrl.value.text.trim(),
        "city": cityCntrl.value.text.trim(),
        "zip_code": pinNoCntrl.value.text.trim(),
        "state": stateCntrl.value.text.trim(),
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: addTenantByLandlord,
    );

    if (response != null) {
      print("dlskdlsklkslad ${response.data} ${response.statusCode}");
      if (response.statusCode == 200) {
        if (istenantaddfromOtp) {
          addTenantOtpVerify.value = false;
          AddTenantWidgets().otpPop();
        }

        customSnackBar(Get.context!, response.data['message'][0]);
        addTenantByLandlordLaoding.value = false;
      } else if (response.statusCode == 400) {
        addTenantByLandlordLaoding.value = false;
        if (response.data.toString().contains("phone")) {
          customSnackBar(Get.context!, response.data['phone'][0]);
        }
        if (response.data.toString().contains("email")) {
          customSnackBar(Get.context!, response.data['email'][0]);
        }
        // Handle error
      } else {
        addTenantByLandlordLaoding.value = false;
      }
    }
  }

  verifyTanantOtp() async {
    final authCntrl = Get.find<AuthController>();
    addTenantOtpVerify.value = true;
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
      body: {
        "phone_code": authCntrl.selectedItem.trim(),
        "phone": phoneCntrl.value.text.trim(),
        "otp": authCntrl.otpController1.value.text +
            authCntrl.otpController2.value.text +
            authCntrl.otpController3.value.text +
            authCntrl.otpController4.value.text
      },
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      url: addTenantByLandlordOtpVerify,
    );

    if (response != null) {
      if (response.statusCode == 202) {
        addTenantOtpVerify.value = false;
        Get.back();
        customSnackBar(Get.context!, response.data['message']);
        Get.off(() => TenantDocScreen(),
            arguments: [response.data['data']['id'], isFromCheckTenat.value]);
      } else if (response.statusCode == 400) {
        addTenantOtpVerify.value = false;
        if (response.data.toString().contains("otp")) {
          customSnackBar(Get.context!, response.data['otp'][0]);
        }
        if (response.data.toString().contains("phone")) {
          customSnackBar(Get.context!, response.data['phone'][0]);
        }
      } else {
        addTenantOtpVerify.value = false;
      }
    }
  }
}
