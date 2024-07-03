
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/text_styles.dart';

class EditProfileController extends GetxController{

  final nameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final permanentAddCntrl = TextEditingController().obs;
  final pinNoCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;


  final  nameFocus = FocusNode().obs;
  final  emailFocus = FocusNode().obs;
  final  phoneFocus = FocusNode().obs;
  final  permanentFocus = FocusNode().obs;
  final  pinNoFocus = FocusNode().obs;
  final  cityFocus = FocusNode().obs;
  final  stateFocus = FocusNode().obs;







//Common Widget

}