import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/services/dio_client_service.dart';

class AddTenantDocumentController extends GetxController {
  final aadharCntrl = TextEditingController().obs;
  final policeVerificationCntrl = TextEditingController().obs;

  final aadharFocus = FocusNode().obs;
  final policeVerificationFocus = FocusNode().obs;
  final imageFile = Rxn<XFile>();
  final documentList = [].obs;
  final kriyederId = 0.obs;
  final doumentLoading = false.obs;
  final documentUploading = false.obs;
  final isFromCheckTenat = true.obs;
  final consentEditMap = {}.obs;
  final isFromTenantDoc = true.obs;
  final isForDocEdit = false.obs;

  final isProfileNotCome = true.obs;

  @override
  onInit() {
    kriyederId.value = Get.arguments[0];
    isFromCheckTenat.value = Get.arguments[1];
    consentEditMap.value = Get.arguments[2];
    isProfileNotCome.value = Get.arguments[3];
    isForDocEdit.value = consentEditMap['isEdit'];
    if (isForDocEdit.value == true) {
      isFromTenantDoc.value = consentEditMap['isFromTenantDoc'];
    }

    getDocumentType();
    super.onInit();
  }

  onPreviousTap() {
    Get.back();
  }

  onSubmitTap() {
    if (documentList.isNotEmpty) {
      int index = -1;

      for (int i = 0; i < documentList.length; i++) {
        if (documentList[i]['image'] == null) {
          index = i;
          break;
        }
      }
      if (index == -1) {
        if (isForDocEdit.value) {
          updateDocument();
        } else {
          uploadDocumenById();
        }
      } else {
        customSnackBar(Get.context!,
            "Please add the ${documentList[index]['type_title']}");
      }
    }
  }

  uploadDocumenById() async {
    documentUploading.value = true;
    List id = [];
    List image = [];

    for (int i = 0; i < documentList.length; i++) {
      id.add(documentList[i]['id']);
      image.add(await DioClientServices.instance
          .multipartFile(file: documentList[i]['image']));
    }
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPostCall(
        body: isProfileNotCome.value
            ? {
                'document_type': jsonEncode(id),
                'image': image,
                'user': kriyederId.value
              }
            : {
                'document_type': jsonEncode(id),
                'image': image,
              },
        headers: {
          "Accept-Language": languaeCode,
          'Authorization': "Bearer $accessToken",
          "Content-Type": "application/json"
        },
        url: userDocument);
    if (response != null) {
      if (response.statusCode == 200) {
        documentUploading.value = false;
        customSnackBar(Get.context!, response.data['message'][0]);

        Get.back(result: !isFromCheckTenat.value);
        if (isFromCheckTenat.value) {
        } else {}
      } else if (response.statusCode == 400) {
        documentUploading.value = false;
        customSnackBar(Get.context!, response.data['error'][0]);
      }
    }
  }

  getDocumentType() async {
    doumentLoading.value = true;
    print(
        "jhjhj ${"$userDocumentType?limit=100&${isProfileNotCome.value ? "for_tenant=true" : "for_landlord=true"}"}");
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    final response = await DioClientServices.instance.dioGetCall(headers: {
      "Accept-Language": languaeCode,
    }, url: "$userDocumentType?limit=100&${isProfileNotCome.value ? "for_tenant=true" : "for_landlord=true"}");
    if (response != null) {
      if (response.statusCode == 200) {
        doumentLoading.value = false;
        final data = response.data;
        documentList.clear();

        for (int i = 0; i < data['results'].length; i++) {
          documentList.add({
            "id": data['results'][i]['id'],
            "type_title": data['results'][i]['type_title'],
            "image": null,
            "isNetworkImage": false,
            "isUpdated": false,
            "docId": 0,
          });
        }
        if (isForDocEdit.value == true) {
          for (int i = 0; i < documentList.length; i++) {
            for (int j = 0; j < consentEditMap['docList'].length; j++) {
              if (documentList[i]['id'] ==
                  consentEditMap['docList'][j]['document_type']) {
                documentList[i]['image'] =
                    consentEditMap['docList'][j]['image'];
                documentList[i]['isNetworkImage'] = true;
                documentList[i]['docId'] = consentEditMap['docList'][j]['id'];
                break;
              }
            }
          }
        }
      } else if (response.statusCode == 400) {
        doumentLoading.value = false;
      }
    }
  }

  updateDocument() async {
    documentUploading.value = true;
    List id = [];
    List image = [];

    for (int i = 0; i < documentList.length; i++) {
      if (documentList[i]['isUpdated'] == true) {
        id.add(documentList[i]['docId']);
        image.add(await DioClientServices.instance
            .multipartFile(file: documentList[i]['image']));
      }
    }
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    String accessToken = prefs.getString('access_token') ?? "";
    final response = await DioClientServices.instance.dioPutCall(
        body: isFromTenantDoc.value
            ? {
                'id_list': jsonEncode(id),
                'image': image,
                'user': kriyederId.value
              }
            : {
                'id_list': jsonEncode(id),
                'image': image,
              },
        headers: {
          "Accept-Language": languaeCode,
          'Authorization': "Bearer $accessToken",
          "Content-Type": "application/json"
        },
        url: documentUpdate);
    if (response != null) {
      if (response.statusCode == 200) {
        documentUploading.value = false;
        customSnackBar(Get.context!, response.data['message'][0]);
        Get.back(result: true);
        if (isFromCheckTenat.value) {
        } else {}
      } else if (response.statusCode == 400) {
        documentUploading.value = false;
        customSnackBar(Get.context!, response.data['error'][0]);
      }
    }
  }
}
