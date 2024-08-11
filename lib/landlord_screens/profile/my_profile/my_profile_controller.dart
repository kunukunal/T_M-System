import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/profile/edit_profile/edit_profile_view.dart';

class MyProfileController extends GetxController{


  //functions
  onEditProfileTap(isFromProfile){

    Get.to(()=>EditProfileVew(isFromProfile: isFromProfile,));

  }
}