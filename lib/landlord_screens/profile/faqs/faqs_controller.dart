import 'dart:developer';

import 'package:get/get.dart';
import 'package:tanent_management/common/api_service_strings/api_end_points.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class FaqsController extends GetxController {
  //variables
  final quesAnsList = [
    // {
    //   'ques': 'What is Landlord?',
    //   'isExpanded': true,
    //   'ans':
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ',
    // },
    // {
    //   'ques': 'How do I add a new tenant tomy property?',
    //   'isExpanded': false,
    //   'ans': 'Call 911 in any and all emergency situations.'
    // },
    // {
    //   'ques': 'Can I track rental payments and late fees through the app?',
    //   'isExpanded': false,
    //   'ans':
    //       'Please call your facility for any care needs requiring immediate actions.',
    // },
    // {
    //   'ques': 'How do I add a new tenant to my property',
    //   'isExpanded': false,
    //   'ans':
    //       'Please call your facility for any care needs requiring immediate actions.',
    // },
  ].obs;

  final faqLoading = false.obs;

  @override
  onInit() {
    getFaq();
    super.onInit();
  }

  getFaq() async {
    print("hhkhkhkhk");
    faqLoading.value = true;


    String accessToken = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";        String languaeCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        "en";

    final response = await DioClientServices.instance.dioGetCall(
      headers: {
        'Authorization': "Bearer $accessToken",
        "Content-Type": "application/json",
        "Accept-Language": languaeCode,
      },
      url: faqQuestion,
    );

    if (response != null) {
      log("dlslkdlsakdlkasld ${response.data} ${response.statusCode}");

      if (response.statusCode == 200) {
        faqLoading.value = false;
        quesAnsList.clear();
        quesAnsList.addAll(response.data.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;

          // Add isExpand key to each item, with true for the first item and false for the rest
          return {
            ...item, // Spread the original item properties
            'isExpand':
                index == 0 // Set isExpand to true only for the first item
          };
        }).toList());
      } else if (response.statusCode == 400) {
        // Handle error
      }
    }
  }
}
