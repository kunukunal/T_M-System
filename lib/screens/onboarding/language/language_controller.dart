import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/screens/onboarding/walk_through/terms_and_condition.dart';

class LanguageController extends GetxController {
  //variables
  final languageList = <Map>[
    {
      'name': 'English',
      'icon': engFlagIcon,
      'isSelected': true,
      "language_code": "en"
    },
    {
      'name': 'Hindi',
      'icon': hindiFlagIcon,
      'isSelected': false,
      "language_code": "hi"
    },
  ].obs;

  final languageIndex = 0.obs;



 @override
  void onInit() {
      getLanguagepPref();
    super.onInit();

  }
  //functions
  onLanguageChange(index) {
    languageList.map((element) {
      element['isSelected'] = false;
    }).toList();
    languageList[index]['isSelected'] = true;
    languageIndex.value = index;
    languageList.refresh();
  }

  setLanguagepPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languae_code',
        languageList[languageIndex.value]['language_code']);
  }

  getLanguagepPref() async {
    final prefs = await SharedPreferences.getInstance();
    String languaeCode = prefs.getString('languae_code') ?? "en";
    int index = languageList
        .indexWhere((element) => element['language_code'] == languaeCode);
    languageIndex.value = index;
    onLanguageChange(index);
  }

  onContinueTap({required bool isFromProfile}) {
    // save the choose langauge
    setLanguagepPref();
    isFromProfile ? Get.back() : Get.to(() => TermsAndConditionScreen());
  }
}
