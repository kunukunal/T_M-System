import 'package:get/get.dart';
import 'package:tanent_management/screens/onboarding/auth/personal_info/personal_info.dart';
import 'package:tanent_management/screens/profile/edit_profile/edit_profile_view.dart';

class MyProfileController extends GetxController{


  //functions
  onEditProfileTap(isFromProfile){

    Get.to(()=>EditProfileVew(isFromProfile: isFromProfile,));

  }
}