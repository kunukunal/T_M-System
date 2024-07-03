import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_view.dart';

class AddPropertyCntroller extends  GetxController{

  final propertyTitleCntrl = TextEditingController().obs;
  final addressCntrl = TextEditingController().obs;
  final phoneCntrl = TextEditingController().obs;
  final landmarkCntrl = TextEditingController().obs;
  final pinCodeCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;

  onSaveTap(){
    Get.to(()=>
        PropertyAb());
  }
}