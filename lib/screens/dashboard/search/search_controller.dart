import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../property/property_list/property_list_view.dart';

class SearchCntroller extends GetxController{

  final searchCntrl = TextEditingController().obs;
  final items = [
    {
      'unitTitle': 'Unit 1',
      'price': '₹2500.00',
      'availablityTitle': 'Available Since March',
      'icon': 'assets/icons/homeIcon.png',
      'shareIcon': 'assets/icons/Frame.png',
      'buildingIcon':'assets/icons/a.png',
      'property': 'B',
      'building': '1',
      'floor': '2',
      'isOccupied':false

    },
    {
      'unitTitle': 'Unit 3',
      'price': '₹3500.00',
      'availablityTitle': 'Available Since March',
      'icon': 'assets/icons/homeIcon.png',
      'shareIcon': 'assets/icons/Frame.png',
      'buildingIcon':'assets/icons/a.png',
      'property': 'B',
      'building': '1',
      'floor': '2',
      'isOccupied':false

    },
    {
      'unitTitle': 'Unit 2',
      'price': '₹2900.00',
      'availablityTitle': 'Available Since March',
      'icon': 'assets/icons/profileIcon.png',
      'shareIcon': 'assets/icons/Frame.png',
      'buildingIcon':'assets/icons/a.png',
      'property': 'B',
      'building': '1',
      'floor': '2',
      'isOccupied':true

    },
    {
      'unitTitle': 'Unit 1',
      'price': '₹2500.00',
      'availablityTitle': 'Available Since March',
      'icon': 'assets/icons/homeIcon.png',
      'shareIcon': 'assets/icons/Frame.png',
      'buildingIcon':'assets/icons/a.png',
      'property': 'B',
      'building': '1',
      'floor': '2',
      'isOccupied':false

    },
    {
      'unitTitle': 'Unit 1',
      'price': '₹2500.00',
      'availablityTitle': 'Available Since March',
      'icon': 'assets/icons/homeIcon.png',
      'shareIcon': 'assets/icons/Frame.png',
      'buildingIcon':'assets/icons/a.png',
      'property': 'B',
      'building': '1',
      'floor': '2',
      'isOccupied':false

    },
  ].obs;

  onItemTap(){
    Get.to(()=>
        PropertyListView());
  }
}