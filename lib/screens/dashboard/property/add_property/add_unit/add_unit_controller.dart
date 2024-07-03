import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUnitController extends GetxController{
  final unitNameCntrl = TextEditingController().obs;
  final areaSizeCntrl = TextEditingController().obs;
  final noteCntrl = TextEditingController().obs;

  final selectedUnitType ='2 BHK'.obs;
  final selectedUnitFeature ='Select'.obs;
  final selectedUnitRent ='Select'.obs;

  final unitType=[
    '2 BHK',
    '3 BHK',
    '4 BHK',
  ].obs;
  final unitFeature=[
    'Select',
    'Select1',
    'Select2',
  ].obs;
  final unitRent=[
    'Select',
    'Select3',
    'Select4',
  ].obs;

  final isSelected=false.obs;
}