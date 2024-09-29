import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';

import '../../../modals/user_modal.dart';

class SplashController extends GetxController {
//MARK: - Variables & Constants
  final userData = Rxn<UserModel>();
  var isgoThroughVisible = false.obs;
  // final _isLoading = true.obs;
  bool isLoggedIn = false;

  bool isUserLogin = false;
  final isProfileSetup = true.obs;
  final isUserlandlord = false.obs;

  @override
  void onInit() {
    _getUserData();
    _getUserLogin();
    super.onInit();
  }

  _getUserLogin() async {
    String token = await SharedPreferencesServices.getStringData(
            key: SharedPreferencesKeysEnum.accessToken.value) ??
        "";
    isProfileSetup.value = await SharedPreferencesServices.getBoolData(
            key: SharedPreferencesKeysEnum.ispersonalinfocompleted.value) ??
        true;
    isUserlandlord.value = await SharedPreferencesServices.getBoolData(
            key: SharedPreferencesKeysEnum.islandlord.value) ??
        false;
    isLandlord = isUserlandlord.value;
    isUserLogin = token.isNotEmpty;
  }

  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    isgoThroughVisible.value = prefs.getBool('first_run') ?? true;
    // if (prefs.getBool('first_run') ?? true) {

    //   isgoThroughVisible.value=false;
    //   // FlutterSecureStorage storage = const FlutterSecureStorage();
    //   // await storage.deleteAll();
    //   prefs.setBool('first_run', false);
    // }
    // UserModel? userData1 = await getUserData();
    // bool isGoThrough = await isGothroughVisible;
    // userData.value = userData1;
    // isgoThroughVisible.value = isGoThrough;
    // _isLoading.value = true;
  }
}
