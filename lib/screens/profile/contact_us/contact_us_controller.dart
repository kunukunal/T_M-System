import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController{

  //variables
  final nameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final descCntrl = TextEditingController().obs;


  final  nameFocus = FocusNode().obs;
  final  emailFocus = FocusNode().obs;
  final  descFocus = FocusNode().obs;



}