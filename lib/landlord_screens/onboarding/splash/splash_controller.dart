import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/functions.dart';
import '../../../modals/user_modal.dart';

class SplashController extends GetxController {
//MARK: - Variables & Constants
  final userData = Rxn<UserModel>();
  var isgoThroughVisible = false.obs;
  final _isLoading = true.obs;
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
    final prefs = await SharedPreferences.getInstance();

    isProfileSetup.value = prefs.getBool('is_personal_info_completed') ?? true;
    isUserlandlord.value = prefs.getBool('is_landlord') ?? false;
    String token = prefs.getString('access_token') ?? "";
    isUserLogin = token.isNotEmpty;
  }

  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.deleteAll();
      prefs.setBool('first_run', false);
    }
    UserModel? userData1 = await getUserData();
    bool isGoThrough = await isGothroughVisible;
    userData.value = userData1;
    isgoThroughVisible.value = isGoThrough;
    _isLoading.value = true;
  }
}
