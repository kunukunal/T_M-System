import 'dart:convert';

import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/api_service_strings/base_url.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

List state = [
  "Select",
  "Andaman and Nicobar Islands",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh",
  "Chhattisgarh",
  "Dadra and Nagar Haveli and Daman and Diu",
  "Delhi",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Ladakh",
  "Lakshadweep",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Puducherry",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal"
];
Map userData = {
  "id": 0,
  "name": "",
  "phone_code": "",
  "phone": "",
  "email": "",
  "profile_image": "",
  "user_type": 0,
  "user_type_value": "",
  "user_documents": false,
  "email_verified": false
};

bool isLandlord = false;
bool isPlatformIos = false;
String appVersion = "";

clearAll() {
  isLandlord = false;

  userData = {
    "id": 0,
    "name": "",
    "phone_code": "",
    "phone": "",
    "email": "",
    "profile_image": "",
    "user_type": 0,
    "user_type_value": "",
    "user_documents": false,
    "email_verified": false
  };
}

final newVersion = NewVersionPlus();
bool forceUpdateAlllowed = true;

getForceUpdate() async {
  String languaeCode = await SharedPreferencesServices.getStringData(
          key: SharedPreferencesKeysEnum.languaecode.value) ??
      "en";
  final response = await DioClientServices.instance.dioGetCall(headers: {
    "Accept-Language": languaeCode,
  }, url: forceUpdate);

  if (response.statusCode == 200) {
    forceUpdateAlllowed = response.data['force_update'];
  }
}

advancedStatusCheck() async {
  final status = await newVersion.getVersionStatus();
  if (status != null) {
    print("releaseNotes: ${status.releaseNotes}");
    print("appStoreLink: ${status.appStoreLink}");
    print("localVersion: ${status.localVersion}");
    print("storeVersion: ${status.storeVersion}");
    print("canUpdate: ${status.canUpdate.toString()}");
    if (status.canUpdate == true) {
      newVersion.showUpdateDialog(
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'Rentpur - Update Available',
        dialogText:
            'A new version of Rentpur is available. Please update to enjoy the latest features and improvements.',
        launchModeVersion: LaunchModeVersion.external,
        allowDismissal: !forceUpdateAlllowed,
      );
    }
  }
}

final encryptKey =
    "ksdkjkjskdja*6665236mmm|424!@#@!@!#'34;['==;';'09203902930]`1`47328748234823847823><:{{{}}}";

String xorEncrypt(String text) {
  List<int> encoded = [];
  for (int i = 0; i < text.length; i++) {
    encoded
        .add(text.codeUnitAt(i) ^ encryptKey.codeUnitAt(i % encryptKey.length));
  }
  return base64.encode(encoded);
}

String xorDecrypt(String encoded) {
  try {
    List<int> decoded = base64.decode(encoded);
    List<int> decrypted = [];
    for (int i = 0; i < decoded.length; i++) {
      decrypted.add(decoded[i] ^ encryptKey.codeUnitAt(i % encryptKey.length));
    }
    return String.fromCharCodes(decrypted);
  } catch (e) {
    return "errroOccurRentpur";
  }
}

shareUnitById(int id) {
  try {
    String encryptValue = xorEncrypt(id.toString());
    final String message =
        "Hi, I’m sharing the unit details with you. Please click on the link to make a request ${commonBaseUrl}?code=${encryptValue}";
    Share.share(message);
  } catch (e) {}
}
