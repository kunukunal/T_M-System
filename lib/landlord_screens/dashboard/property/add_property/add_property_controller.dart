import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class AddPropertyCntroller extends GetxController {
  final propertyTitleCntrl = TextEditingController().obs;
  final addressCntrl = TextEditingController().obs;
  // final phoneCntrl = TextEditingController().obs;
  final landmarkCntrl = TextEditingController().obs;
  final pinCodeCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  // final stateCntrl = TextEditingController().obs;
  final selectedState = "Select".obs;

  final isPropertyAdded = false.obs;

  final propertyPickedImage = [].obs;
  final isForEdit = false.obs;
  final propertyId = 0.obs;
  @override
  void onInit() {
    isForEdit.value = Get.arguments[0];
    if (isForEdit.value == true) {
      Map item = Get.arguments[1];
      propertyId.value = item['id'];
      propertyTitleCntrl.value.text = item['title'];
      addressCntrl.value.text = item['address'];
      landmarkCntrl.value.text = item['landmark'];
      pinCodeCntrl.value.text = item['pincode'].toString();
      cityCntrl.value.text = item['city'];
      // stateCntrl.value.text = item['state'];
      checkIsState(item['state']);
      for (int i = 0; i < item['images'].length; i++) {
        propertyPickedImage.add({
          "id": item['images'][i]['id'],
          "image": item['images'][i]['image'],
          "isNetwork": true,
          "isDelete": false
        });
      }
    }
    super.onInit();
  }

  checkIsState(String value) {
    bool data = state.contains(value);
    if (data) {
      selectedState.value = value;
    } else {
      selectedState.value = "Select";
    }
  }

  onSaveTap() {
    if (propertyTitleCntrl.value.text.trim().isNotEmpty) {
      if (addressCntrl.value.text.trim().isNotEmpty) {
        if (pinCodeCntrl.value.text.trim().isNotEmpty) {
          if (cityCntrl.value.text.trim().isNotEmpty) {
            if (selectedState.value != "Select") {
              isPropertyAdded.value = true;

              if (isForEdit.value == true) {
                updatePropertyApi();
              } else {
                addPropertyApi();
              }
            } else {
              customSnackBar(Get.context!, "please_fill_state".tr);
            }
          } else {
            customSnackBar(Get.context!, "please_fill_city".tr);
          }
        } else {
          customSnackBar(Get.context!, "please_fill_pincode".tr);
        }
      } else {
        customSnackBar(Get.context!, "please_fill_address".tr);
      }
    } else {
      customSnackBar(Get.context!, "please_fill_title".tr);
    }

    // Get.to(() => PropertyAb());
  }

  addPropertyApi() async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    var propertyImage = [];
    for (int i = 0; i < propertyPickedImage.length; i++) {
      propertyImage.add(await DioClientServices.instance
          .multipartFile(file: propertyPickedImage[i]["image"]));
    }

    final response = await DioClientServices.instance.dioPostCall(body: {
      "title": propertyTitleCntrl.value.text.trim(),
      "address": addressCntrl.value.text.trim(),
      "pincode": pinCodeCntrl.value.text.trim(),
      "landmark": landmarkCntrl.value.text.trim(),
      "city": cityCntrl.value.text.trim(),
      "state": selectedState.value,
      "property_images": propertyImage
    }, headers: {
      'Authorization': "Bearer $accessToken",
      "Accept-Language": languaeCode,
    }, url: getOrAddPropertyList);
    if (response != null) {
      if (response.statusCode == 201) {
        isPropertyAdded.value = false;
        Get.back(result: true);
      } else if (response.statusCode == 400) {}
    }
  }

  updatePropertyApi() async {
    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";



    var propertyImage = [];
    var deletedImage = [];
    for (int i = 0; i < propertyPickedImage.length; i++) {
      if (propertyPickedImage[i]['isNetwork'] == false) {
        propertyImage.add(await DioClientServices.instance
            .multipartFile(file: propertyPickedImage[i]["image"]));
      } else {
        if (propertyPickedImage[i]['isDelete'] == true) {
          deletedImage.add(propertyPickedImage[i]['id']);
        }
      }
    }

    final response = await DioClientServices.instance.dioPatchCall(body: {
      "title": propertyTitleCntrl.value.text.trim(),
      "address": addressCntrl.value.text.trim(),
      "pincode": pinCodeCntrl.value.text.trim(),
      "landmark": landmarkCntrl.value.text.trim(),
      "city": cityCntrl.value.text.trim(),
      "state": selectedState.value,
      "property_images": propertyImage,
      "img_deleted": jsonEncode(deletedImage)
    }, headers: {
      'Authorization': "Bearer $accessToken",
    }, url: "$getOrAddPropertyList${propertyId.value}/");
    if (response != null) {
      if (response.statusCode == 200) {
        isPropertyAdded.value = false;
        Get.back(result: true);
      } else if (response.statusCode == 400) {}
    }
  }
}
