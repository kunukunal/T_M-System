import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/landlord_screens/onboarding/walk_through/terms_and_condition.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

class LanguageController extends GetxController {
  // Observable list for the available languages
  final languageList = <Map<String, dynamic>>[
    {
      'name': 'English',
      'icon': engFlagIcon,
      'isSelected': true,
      'language_code': 'en',
    },
    {
      'name': 'हिंदी',
      'icon': hindiFlagIcon,
      'isSelected': false,
      'language_code': 'hi',
    },
  ].obs;

  // Observable index for the selected language
  final languageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getLanguagePref(); // Load saved language preference on initialization
  }

  // Function to handle language change
  void onLanguageChange(int index) {
    // Deselect all languages
    for (var element in languageList) {
      element['isSelected'] = false;
    }

    // Select the chosen language
    languageList[index]['isSelected'] = true;
    languageIndex.value = index;

    // Update the locale
    Locale locale = Locale(languageList[index]['language_code']);
    Get.updateLocale(locale);

    // Refresh the list to reflect the selection change
    languageList.refresh();
  }

  // Function to save the selected language in SharedPreferences
  Future<void> setLanguagePref() async {
    await SharedPreferencesServices.setStringData(
      key: SharedPreferencesKeysEnum.languaecode.value,
      value: languageList[languageIndex.value]['language_code'],
    );
  }

  // Function to load the saved language preference
  Future<void> getLanguagePref() async {
    String languageCode = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.languaecode.value) ??
        'en';

    // Find the index of the saved language
    int index = languageList
        .indexWhere((element) => element['language_code'] == languageCode);

    // If the saved language is not found, default to English
    if (index == -1) {
      index = 0;
    }

    // languageIndex.value = index;
    // Locale locale = Locale(languageCode);
    // Get.updateLocale(locale);
    onLanguageChange(index); // Ensure the UI reflects the saved language
  }

  // Function to handle the continue button tap
  void onContinueTap({required bool isFromProfile}) {
    // Save the selected language preference
    setLanguagePref();

    if (isFromProfile) {
      Get.back(); // Go back if coming from the profile screen
    } else {
      Get.to(() =>
          TermsAndConditionScreen()); // Navigate to Terms and Conditions screen
    }
  }
}
